function Errore_val_arx(theta,dati_val,na,nb,nk)
    %funzione che calcola calcola l'errore di predizione ed effettua il 
    %test di anderson
    global err_val;
    err_val = pe(theta,dati_val); %errore sui dati di validazione
    Anderson(err_val); %valuto la bianchezza dell'errore su valid
end