function incertezza_max = Incertezza_Coefficienti(theta)
    %funzione che restituisce i coefficienti con le relative incertezze e 
    %l'incertezza massima
    [v, st_dev] = getpvec(theta);
    incertezza = (st_dev ./ v) * 100;
    incertezza_max = max(abs(incertezza));
    vettore = [v incertezza];
    fprintf('\nI coefficienti con le relative incertezze sono: \n');
    disp(vettore);
    fprintf("\nL'incertezza massima è: ");
    fprintf("%f", incertezza_max);
    fprintf("\n\n");
end