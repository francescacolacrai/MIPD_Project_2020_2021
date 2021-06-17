%inizio la costruzione dei modelli, scartando quelli che non vanno bene per
%quanto riguarda il test di Anderson e l'incertezza dei parametri stimati.

%Dalla valutazione dell'ordine a priori si deduce che l'ordine di partenza
%attorno al quale studiare i modelli ARX è 4

%carico i le coppie ingresso uscita osservate
load('ES_4.MAT');

%divido a metà i dati: la prima parte per identificazione e la seconda
%per la validazione
u_id = es4_u(1:150);
y1_id = es4_y1(1:150);
u_val = es4_u(151:301);
y1_val = es4_y1(151:301);

%-------MODELLO ARX(4,4,2)--------%
arx442 = arx([y1_id u_id],[4 4 2]);

%-------MODELLO ARX(4,4,1)--------%
arx441 = arx([y1_id u_id],[4 4 1]);

%-------MODELLO ARX(4,3,2)--------%
arx432 = arx([y1_id u_id],[4 3 2]);

%-------MODELLO ARX(4,3,1)--------%
arx431 = arx([y1_id u_id],[4 3 1]);

%*******MODELLO ARX(4,2,1)********%
arx421 = arx([y1_id u_id],[4 2 1]);

%-------MODELLO ARX(3,3,2)--------%
arx332 = arx([y1_id u_id],[3 3 2]);

%-------MODELLO ARX(3,3,1)--------%
arx331 = arx([y1_id u_id],[3 3 1]);

%*******MODELLO ARX(3,2,2)********%
arx322 = arx([y1_id u_id],[3 2 2]);

%*******MODELLO ARX(3,2,1)********%
arx321 = arx([y1_id u_id],[3 2 1]);

%-------MODELLO ARX(5,5,2)--------%
arx552 = arx([y1_id u_id],[5 5 2]);

%-------MODELLO ARX(5,5,1)--------%
arx551 = arx([y1_id u_id],[5 5 1]);

%-------MODELLO ARX(5,4,2)--------%
arx542 = arx([y1_id u_id],[5 4 2]);

%-------MODELLO ARX(5,4,1)--------%
arx541 = arx([y1_id u_id],[5 4 1]);

%-------MODELLO ARX(5,3,2)--------%
arx532 = arx([y1_id u_id],[5 3 2]);

%-------MODELLO ARX(5,3,1)--------%
arx531 = arx([y1_id u_id],[5 3 1]);

%*******MODELLO ARX(5,2,1)********%
arx521 = arx([y1_id u_id],[5 2 1]);

%calcolo l'errore di predizione confrontando la risposta ottenuta con il
%comando arx, ovvero l'uscita stimata del modello e quella osservata 
errore442 = pe(arx442,[y1_id u_id]);
errore441 = pe(arx441,[y1_id u_id]);
errore432 = pe(arx432,[y1_id u_id]);
errore431 = pe(arx431,[y1_id u_id]);
errore421 = pe(arx421,[y1_id u_id]);
errore332 = pe(arx332,[y1_id u_id]);
errore331 = pe(arx331,[y1_id u_id]);
errore322 = pe(arx322,[y1_id u_id]);
errore321 = pe(arx321,[y1_id u_id]);
errore552 = pe(arx552,[y1_id u_id]);
errore551 = pe(arx551,[y1_id u_id]);
errore542 = pe(arx542,[y1_id u_id]);
errore541 = pe(arx541,[y1_id u_id]);
errore532 = pe(arx532,[y1_id u_id]);
errore531 = pe(arx531,[y1_id u_id]);
errore521 = pe(arx521,[y1_id u_id]);

%vedo la percentuale di FIT dei vari modelli con l'uscita osservata y1
%{
compare([y1_id u_id],arx442);
compare([y1_id u_id],arx441);
compare([y1_id u_id],arx432);
compare([y1_id u_id],arx431);
%compare([y1_id u_id],arx421);
compare([y1_id u_id],arx332);
compare([y1_id u_id],arx331);
%compare([y1_id u_id],arx322);
%compare([y1_id u_id],arx321);
compare([y1_id u_id],arx552);
compare([y1_id u_id],arx551);
compare([y1_id u_id],arx542);
compare([y1_id u_id],arx541);
compare([y1_id u_id],arx532);
compare([y1_id u_id],arx531);
%compare([y1_id u_id],arx521);
%}

%applico la funzione 'Anderson' per la verifica della bianchezza
%dell'errore di predizione ottenuto
%Anderson(errore442);
%Anderson(errore441);
%Anderson(errore432);
%Anderson(errore431);
%Anderson(errore421);
%Anderson(errore332);
%Anderson(errore331);
%Anderson(errore322);
%Anderson(errore321);
%Anderson(errore552);
%Anderson(errore551);
%Anderson(errore542);
%Anderson(errore541);
%Anderson(errore532);
%Anderson(errore531);
%Anderson(errore521);

%calcolo dell'incertezza massima dei coefficienti 
[v_442, st_dev_442] = getpvec(arx442);
incertezza442 = (st_dev_442 ./ v_442)*100;
incertezza_max_442 = max(abs(incertezza442));

[v_441, st_dev_441] = getpvec(arx441);
incertezza441 = (st_dev_441 ./ v_441)*100;
incertezza_max_441 = max(abs(incertezza441));

[v_432, st_dev_432] = getpvec(arx432);
incertezza432 = (st_dev_432 ./ v_432)*100;
incertezza_max_432 = max(abs(incertezza432));

[v_431, st_dev_431] = getpvec(arx431);
incertezza431 = (st_dev_431 ./ v_431)*100;
incertezza_max_431 = max(abs(incertezza431));

%{
[v_421, st_dev_421] = getpvec(arx421)
incertezza421 = (st_dev_421 ./ v_421)*100
incertezza_max_421 = max(abs(incertezza421))
%}

[v_332, st_dev_332] = getpvec(arx332);
incertezza332 = (st_dev_332 ./ v_332)*100;
incertezza_max_332 = max(abs(incertezza332));

[v_331, st_dev_331] = getpvec(arx331);
incertezza331 = (st_dev_331 ./ v_331)*100;
incertezza_max_331 = max(abs(incertezza331));

%{
[v_322, st_dev_322] = getpvec(arx322)
incertezza322 = (st_dev_322 ./ v_322)*100
incertezza_max_322 = max(abs(incertezza322))

[v_321, st_dev_321] = getpvec(arx321)
incertezza321 = (st_dev_321 ./ v_321)*100
incertezza_max_321 = max(abs(incertezza321))
%}

[v_552, st_dev_552] = getpvec(arx552);
incertezza552 = (st_dev_552 ./ v_552)*100;
incertezza_max_552 = max(abs(incertezza552));

[v_551, st_dev_551] = getpvec(arx551);
incertezza551 = (st_dev_551 ./ v_551)*100;
incertezza_max_551 = max(abs(incertezza551));

[v_542, st_dev_542] = getpvec(arx542);
incertezza542 = (st_dev_542 ./ v_542)*100;
incertezza_max_542 = max(abs(incertezza542));

[v_541, st_dev_541] = getpvec(arx541);
incertezza541 = (st_dev_541 ./ v_541)*100;
incertezza_max_541 = max(abs(incertezza541));

[v_532, st_dev_532] = getpvec(arx532);
incertezza532 = (st_dev_532 ./ v_532)*100;
incertezza_max_532 = max(abs(incertezza532));

[v_531, st_dev_531] = getpvec(arx531);
incertezza531 = (st_dev_531 ./ v_531)*100;
incertezza_max_531 = max(abs(incertezza531));

%{
[v_521, st_dev_521] = getpvec(arx521);
incertezza521 = (st_dev_521 ./ v_521)*100;
incertezza_max_521 = max(abs(incertezza521));
%}
