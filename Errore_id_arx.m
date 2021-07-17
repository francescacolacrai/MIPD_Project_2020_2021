function Errore_id_arx(theta,dati_id,na,nb,nk)
    %funzione che calcola calcola l'errore di predizione ed effettua il 
    %test di anderson
    global err_id;
    err_id = pe(theta,dati_id); %errore sui dati di ident
    Anderson(err_id); %valuto la bianchezza dell'errore su ident
end
