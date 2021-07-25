%%%IDENTIFICAZIONE%%%

%carico i le coppie ingresso-uscita osservate
load('ES_4.MAT');

%divido a metà i dati: la prima parte per identificazione e la seconda
%per la validazione
u_id = es4_u(1:150);
u_val = es4_u(151:301);
y5_id = es4_y5(1:150);
y5_val = es4_y5(151:301);
dati_id = [y5_id u_id];
dati_val = [y5_val u_val];

%elimino la media dai dati
dati_id_detrend = detrend(dati_id);
dati_val_detrend = detrend(dati_val);

%creo modelli nell'intorno dell'ordine trovato
n = input("Inserisci l'ordine ottenuto: ");
%n = 4; %ordine trovato


%scelta del modello
s = input("Quale famiglia di modelli vuoi realizzare? \n", 's');
scelta = s;
switch scelta
    case 'arx'
        modello = struc(n-1:n+1,n-1:n+1,1:2);
        n_model = size(modello);

        % so che l'ARX è dato da y(t) = [B(z)/A(z)]*u(t-1) + [1/A(z)]*xi(t) e 
        % B(z)/A(z) deve essere strettamente propria
        idx = find(modello(:,2) > modello(:,1));
        modello(idx,:) = [];
        n_model = size(modello);
        fprintf("\nI modelli nell'intorno dell'ordine appena trovato sono: \n");
        disp(modello);
        
        Incertezza_max = zeros(n_model(1,1),1); %inizializzo il vettore delle incertezze massime
        Nome = ("");
        for i = 1:n_model(1,1)
            Nome(i) = "arx(" + modello(i,1) + ',' + modello(i,2) + ',' + modello(i,3) + ')';
            fprintf("\nModello ARX(");
            fprintf("%d",modello(i,1));
            fprintf(",")
            fprintf("%d",modello(i,2));
            fprintf(",")
            fprintf("%d",modello(i,3));
            fprintf(")\n");
            theta = arx(dati_id_detrend,[modello(i,1),modello(i,2),modello(i,3)]); %creo il modello
            Errore_id_arx(theta,dati_id_detrend,modello(i,1),modello(i,2),modello(i,3)); %test di anderson
            inc_max = Incertezza_Coefficienti(theta); %valuto l'incertezza massima
            Incertezza_max(i) = inc_max;
        end
    
        Nome = Nome';
        titolo = ["Modello", "Incertezza massima"];
        fprintf("I modelli con le relative incertezze sono: \n");
        Esito = [titolo; Nome Incertezza_max] 
     
        %elimino i modelli con le incertezze elevate
        l = size(Esito);
        incertezze = zeros(l(1,1),1);
        for i = 2 : l(1,1)
            incertezze(i) = str2num(Esito(i,2));
        end
        ind = find(incertezze(:) > 100);
        incertezze(ind) = [];
        Esito(ind,:) = [];
        incertezze(1) = [];
        fprintf("Le incertezze apprezzabili sono: \n");
        incertezze
        fprintf("I modelli con le incertezze accettabili sono: \n");
        Esito
    case 'armax'
        modello = struc(n-1:n,n-1:n+1,n-1:n+1,1:2);
        n_model = size(modello);

        % so che l'ARMAX è dato da y(t) = [B(z)/A(z)]*u(t-1) + [C(z)/A(z)]*xi(t) e 
        % B(z)/A(z) deve essere propria
        idx = find(modello(:,2) > modello(:,1));
        modello(idx,:) = [];
        n_model = size(modello)
        fprintf("I modelli nell'intorno dell'ordine appena trovato sono: \n");
        disp(modello);

        Incertezza_max = zeros(n_model(1,1),1); %inizializzo il vettore delle incertezze massime
        Nome = ("");
        for i = 1:n_model
            Nome(i) = "armax(" + modello(i,1) + ',' + modello(i,2) + ',' + modello(i,3) + ',' + modello(i,4) + ')';
            fprintf("Modello ARMAX(");
            fprintf("%d",modello(i,1));
            fprintf(',')
            fprintf("%d",modello(i,2));
            fprintf(',')
            fprintf("%d",modello(i,3));
            fprintf(',')
            fprintf("%d",modello(i,4));
            fprintf(")\n");
            theta = armax(dati_id_detrend,[modello(i,1),modello(i,2),modello(i,3),modello(i,4)]) %creo il modello
            Errore_id_armax(theta,dati_id_detrend,modello(i,1),modello(i,2),modello(i,3),modello(i,4));
            inc_max = Incertezza_Coefficienti(theta);
            Incertezza_max(i) = inc_max;
        end
        
        Nome = Nome';
        titolo = ["Modello", "Incertezza massima"];
        fprintf("I modelli con le relative incertezze sono: \n");
        Esito = [titolo; Nome Incertezza_max] 
     
        %elimino i modelli con le incertezze elevate
        l = size(Esito);
        incertezze = zeros(l(1,1),1);
        for i = 2 : l(1,1)
            incertezze(i) = str2num(Esito(i,2));
        end
        ind = find(incertezze(:) > 100);
        incertezze(ind) = [];
        Esito(ind,:) = [];
        incertezze(1) = [];
        fprintf("Le incertezze apprezzabili sono: \n");
        incertezze
        fprintf("I modelli con le incertezze accettabili sono: \n");
        Esito
        
    otherwise 
        %non fa niente
end