%IDENTIFICAZIONE%

%carico i le coppie ingresso uscita osservate
load('ES_4.MAT');

%divido a metà i dati: la prima parte per identificazione e la seconda
%per la validazione
u_id = es4_u(1:150);
u_val = es4_u(151:301);
y1_id = es4_y1(1:150);
y1_val = es4_y1(151:301);
dati_id = [y1_id u_id];
dati_val = [y1_val u_val];

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
        % A(z)/B(z) deve essere strettamente proprio
        idx = find(modello(:,2) > modello(:,1));
        modello(idx,:) = [];
        n_model = size(modello);
        fprintf("I modelli nell'intorno dell'ordine appena trovato sono: \n");
        disp(modello);
        
        for i = 1:n_model
            theta = arx(dati_id,[modello(i,1),modello(i,2),modello(i,3)]); %creo il modello
            fprintf("Modello ARX(");
            fprintf("%d",modello(i,1));
            fprintf(",")
            fprintf("%d",modello(i,2));
            fprintf(",")
            fprintf("%d",modello(i,3));
            fprintf(") \n\n");
            Errore_id_arx(theta,dati_id,modello(i,1),modello(i,2),modello(i,3));
            inc_max = Incertezza_Coefficienti(theta);
            v_inc_max(i) = inc_max;
        end
        %ordino in modo crescente i modelli rispetto all'incertezza massima
        v_inc_max = v_inc_max';
        fprintf("\nLe incertezze massime in ordine crescente sono: \n");
        v_inc_max = sortrows(v_inc_max,1)
    case 'armax'
        modello = struc(n-1:n,n-1:n+1,n-1:n+1,1:2);
        n_model = size(modello);

        % so che l'ARMAX è dato da y(t) = [B(z)/A(z)]*u(t-1) + [C(z)/A(z)]*xi(t) e 
        % A(z)/B(z) deve essere strettamente proprio
        idx = find(modello(:,2) > modello(:,1));
        modello(idx,:) = [];
        n_model = size(modello)
        fprintf("I modelli nell'intorno dell'ordine appena trovato sono: \n");
        disp(modello);

        for i = 1:n_model
            theta = armax(dati_id,[modello(i,1),modello(i,2),modello(i,3),modello(i,4)]); %creo il modello
            fprintf("Modello ARMAX(");
            fprintf("%d",modello(i,1));
            fprintf(',')
            fprintf("%d",modello(i,2));
            fprintf(',')
            fprintf("%d",modello(i,3));
            fprintf(',')
            fprintf("%d",modello(i,4));
            fprintf(") \n\n");
            Errore_id_armax(theta,dati_id,modello(i,1),modello(i,2),modello(i,3),modello(i,4));
            inc_max = Incertezza_Coefficienti(theta);
            v_inc_max(i) = inc_max;
        end
        
        %ordino in modo crescente i modelli rispetto all'incertezza massima
        v_inc_max = v_inc_max';
        fprintf("\nLe incertezze massime in ordine crescente sono: \n");
        v_inc_max = sortrows(v_inc_max,1);
    otherwise 
        %non fa niente
end


%{
%VALIDAZIONE%

n_arx = input("Quanti sono i modelli ARX su cui fare la validazione?\n");
for i = 1 : n_arx
    modelli = input("Inserisci l'ordine del modello da validare:\n");
    modelli = num2str(modelli);
    theta = arx(dati_val,[modelli(i,1),modelli(i,2),modelli(i,3)]);
    fprintf("Modello ARX(");
    fprintf("%d", modelli(i,1));
    fprintf(",")
    fprintf("%d", modelli(i,2));
    fprintf(",")
    fprintf("%d", modelli(i,3));
    fprintf(") \n\n");
    Errore_val_arx(theta,dati_val,modelli(i,1),modelli(i,2),modelli(i,3));
end

n_armax = input("Quanti sono i modelli ARMAX su cui fare la validazione?\n");
for i = 1 : n_armax
    modelli = input("Inserisci l'ordine del modello da validare:\n");
    modelli = num2str(modelli);
    theta = armax(dati_val,[modelli(i,1),modelli(i,2),modelli(i,3),modelli(i,4)]);
    fprintf("Modello ARMAX(");
    fprintf("%d",modelli(i,1));
    fprintf(",")
    fprintf("%d",modelli(i,2));
    fprintf(",")
    fprintf("%d",modelli(i,3));
    fprintf(",")
    fprintf("%d",modelli(i,4));
    fprintf(") \n\n");
    Errore_val_armax(theta,dati_val,modelli(i,1),modelli(i,2),modelli(i,3),modelli(i,4));
end

%}
