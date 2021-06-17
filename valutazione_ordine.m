%{
------------------------------
DETERMINAZIONE ORDINE A PRIORI
------------------------------

Con la seguente funzione 'valutazione_ordine' si vuole procedere con la
determinazione dell'ordine a priori, a partire dal quale si cercherà di
ottenere il miglior modello ARX o eventualmente ARMAX, e realizzazione
dell'andamento dell'autovalore minimo in funzione di n.

Gli argomenti della funzione sono gli input e output forniti al sistema
%}

%applico la funzione alla coppia di dati
%Ordine(es4_u, es4_y)
Ordine(es4_u,es4_y1)
%Ordine(es4_u,es4_y5)
%Ordine(es4_u,es4_y10)

%scelta del parametro n tramite osservazione del grafico ottenuto
fprintf("Il risultato della valutazione dell'ordine a priori risulta essere: \n");
ordine = input('n = ');
fprintf("L'ordine a priori è: \n");
fprintf("%d", ordine);
fprintf("\n");

function Ordine(u,y)

%carico i dati ottenuti 
load('ES_4.MAT', 'es4_u', 'es4_y1', 'es4_y5', 'es4_y10');

N = length(u);
lambda_min = zeros(1,10); %inizializzo il vettore di autovalori minimi 

%realizzo la matrice M(n)
for n = 1:10 %valuto nel range di n tra 1 e 10
    M = zeros(N-n,2*n+1); %matrice M di N-n righe e 2n+1 colonne
    for i = 1:n
        %costruisco le colonne per u ed y e le inserisco nelle opportune
        %colonne della matrice M ad eccezione della prima colonna che è 
        %sempre la stessa per ogni valore di n
        M(:,2*(n+1)-i) = u(i:(N-(n+1))+i); 
        M(:,(n+2)-i) = y(i:(N-(n+1))+i);
    end
    M(:,1) = es4_y1(n+1:N); %inserisco la prima colonna di M
    
    %calcolo gli autovalori per ogni valore di n e inserisco in un nuovo 
    %vettore gli autovalori minimi associati ai diversi valori di n
    lambda_min(1,n) = min(eig(M'* M));   
end

%realizzazione del grafico dell'andamento degli autovalori in funzione di n
figure('Name','Valutazione ordine a priori');
plot(lambda_min);
xlim([0 10]);
ylim([min(lambda_min) max(lambda_min)]);
title('Andamento autovalore minimo in funzione della complessità del modello');
xlabel('Complessità del modello (n)');
ylabel('Autovalore \lambda');
end




