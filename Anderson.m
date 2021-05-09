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

WN = WN(:)';
N = length(WN); %numero di campioni

%beta si può ottenere tramite il comando 'norminv' che ci permette di avere
%il valore dell'ascissa che assume la distribuzione in corrispondenza del
%valore 'alpha/2'
alpha = 0.05;
beta = abs(norminv(alpha/2));

%massimo valore del ritardo
tau_max = 30;

%Calcolo una stima della covarianza campionaria
gamma = zeros(N+1,1);
for t = 1:N-tau_max
    gamma = WN(tau_max)*WN(t+tau_max)';
end

%Calcolo di una stima della varianza campionaria normalizzata:
%gamma(1) = una stima della varianza di WN
rho = gamma / gamma(1); 
  
%Calcolo dei valori che cadono al di fuori dell'intervallo dato
out = 0;
if rho < (-beta/sqrt(tau_max)) || rho > (beta/sqrt(tau_max))
out = out + 1;
end 

%verifico se il test è bianco oppure no
if (out/tau_max) < alpha
    anderson = 'Il segnale generato WN è BIANCO';
else 
    anderson = 'Il segnale generato WN NON è BIANCO';
end
end