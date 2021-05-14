%{
--------------------------------------
TEST DI BIANCHEZZA SUL RUMORE GENERATO
--------------------------------------
Con la seguente funzione Anderson si vuole verificare se il rumore bianco
generato in precedenza sia effettivamente bianco.

Gli argomenti della funzione sono rispettivamente 'WN', 'alpha' e 'tau_max'
%}
function anderson = Anderson(~,~,~)

load('workspace_generazione.mat','WN');

%controllo ingressi della funzione
if nargin < 3
   tau_max = 30;
end

if tau_max >= length(WN)
   tau_max = length(WN)-1;
end

if nargin < 2
  alpha = 0.05;
end

%verifico media e varianza
fprintf('\n');
fprintf('La media di WN e: \n');
fprintf('%f', mean(WN));
fprintf('\n \n');
fprintf('La varianza di WN e: \n');
fprintf('%f', var(WN));
fprintf('\n');

WN = WN(:)'; %trasposto per il calcolo successivo di gamma

%beta si può ottenere tramite il comando 'norminv' che ci permette di avere
%il valore dell'ascissa che assume la distribuzione in corrispondenza del
%valore 'alpha/2'
alpha = 0.05;

%controllo livello di significatività alpha
if alpha <= 0 || alpha >= 1
    error('***Il livello di significatività deve appartenere a (0,1)!***');
    return;
end
beta = abs(norminv(alpha/2));
%beta = sqrt(2) * erfcinv(alpha);

fprintf('\n');
fprintf('Il coefficiente beta è: \n');
fprintf('%f', beta);
fprintf('\n');

%massimo valore del ritardo
tau_max = 30;

%Calcolo una stima della covarianza campionaria
%gamma = zeros(tau_max+1,1);

for t=0:tau_max
    gamma(t+1)=WN(1:tau_max-t)*WN(1+t:tau_max)';
end

fprintf('\nGamma vale: \n');
fprintf('%f', gamma);
fprintf('\n');

%Calcolo di una stima della varianza campionaria normalizzata:
%gamma(1) = una stima della varianza di WN
rho = gamma / gamma(1); 

%estremo dell'intervallo di confidenza 
estremo = beta/sqrt(tau_max);
fprintf('\nGli estremi di intervallo di confidenza sono: \n');
fprintf('%f', -estremo);
fprintf(' e ');
fprintf('%f', estremo);
fprintf('\n');

%grafico della stima di covarianza ottenuta
figure('Name','Stima della covarianza campionaria normalizzata')
indice=0:tau_max;
plot(indice,rho,'Color',[0.252 0.638 0.7],'LineWidth',1);
hold on;
sup = yline(estremo,'Color',[0.752 0.438 0.4],'LineWidth',1);
inf = yline(-estremo,'Color',[0.752 0.798 0.2],'LineWidth',1);
hold off;
title('Grafico di una stima di \rho(\tau)');
xlabel('Ritardo \tau');
ylabel('\rho(\tau)');
grid on;

%Calcolo dei valori che cadono al di fuori dell'intervallo dato
out = 0;
if abs(rho) > estremo
out = out + 1;
end 

fprintf('\n');
fprintf('Il numero dei valori che cadono al di fuori è: \n');
fprintf('%d', out);
fprintf('\n');

%verifico se il test è bianco oppure no
if (out/tau_max) < alpha
    anderson = 'Il segnale generato WN è BIANCO';
else 
    anderson = 'Il segnale generato WN NON è BIANCO';
end
end
