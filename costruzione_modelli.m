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



%______________MODELLI ARMAX______________%


%ERRORE DI PREDIZIONE 
errore3342 = pe(amx3342,[y1_id u_id]);
errore3331 = pe(amx3331,[y1_id u_id]);
errore3332 = pe(amx3332,[y1_id u_id]);
errore3341 = pe(amx3341,[y1_id u_id]);
errore3351 = pe(amx3351,[y1_id u_id]);
errore3352 = pe(amx3352,[y1_id u_id]);
errore4352 = pe(amx4352,[y1_id u_id]);
errore4351 = pe(amx4351,[y1_id u_id]);
errore4431 = pe(amx4431,[y1_id u_id]);
errore4432 = pe(amx4432,[y1_id u_id]);
errore4441 = pe(amx4441,[y1_id u_id]);
errore4341 = pe(amx4341,[y1_id u_id]);
errore4331 = pe(amx4331,[y1_id u_id]);
errore4342 = pe(amx4342,[y1_id u_id]);
errore4442 = pe(amx4442,[y1_id u_id]);
errore4451 = pe(amx4451,[y1_id u_id]);
errore4452 = pe(amx4452,[y1_id u_id]);
errore4332 = pe(amx4332,[y1_id u_id]);
errore4322 = pe(amx4322,[y1_id u_id]);

%ANDERSON
%{
Anderson(errore3342);
Anderson(errore3331);
Anderson(errore3332);
Anderson(errore3341);
Anderson(errore3351);
Anderson(errore3352);
Anderson(errore4352);
Anderson(errore4351);
Anderson(errore4431);
Anderson(errore4432);
Anderson(errore4441);
Anderson(errore4341);
Anderson(errore4331);
Anderson(errore4342);
Anderson(errore4442);
Anderson(errore4451);
Anderson(errore4452);
Anderson(errore4332);
Anderson(errore4322);
%}

%INCERTEZZA COEFFICIENTI

[v_3342, st_dev_3342] = getpvec(amx3342);
incertezza3342 = (st_dev_3342 ./ v_3342)*100;
incertezza_max_3342 = max(abs(incertezza3342));

[v_3331, st_dev_3331] = getpvec(amx3331);
incertezza3331 = (st_dev_3331 ./ v_3331)*100;
incertezza_max_3331 = max(abs(incertezza3331));

[v_3332, st_dev_3332] = getpvec(amx3332);
incertezza3332 = (st_dev_3332 ./ v_3332)*100;
incertezza_max_3332 = max(abs(incertezza3332));

[v_3341, st_dev_3341] = getpvec(amx3341);
incertezza3341 = (st_dev_3341 ./ v_3341)*100;
incertezza_max_3341 = max(abs(incertezza3341));

[v_3351, st_dev_3351] = getpvec(amx3351);
incertezza3351 = (st_dev_3351 ./ v_3351)*100;
incertezza_max_3351 = max(abs(incertezza3351));

[v_3352, st_dev_3352] = getpvec(amx3352)
incertezza3352 = (st_dev_3352 ./ v_3352)*100
incertezza_max_3352 = max(abs(incertezza3352))

[v_4351, st_dev_4351] = getpvec(amx4351);
incertezza4351 = (st_dev_4351 ./ v_4351)*100;
incertezza_max_4351 = max(abs(incertezza4351));

[v_4431, st_dev_4431] = getpvec(amx4431);
incertezza4431 = (st_dev_4431 ./ v_4431)*100;
incertezza_max_4431 = max(abs(incertezza4431));

[v_4432, st_dev_4432] = getpvec(amx4432);
incertezza4432 = (st_dev_4432 ./ v_4432)*100;
incertezza_max_4432 = max(abs(incertezza4432));

[v_4441, st_dev_4441] = getpvec(amx4441);
incertezza4441 = (st_dev_4441 ./ v_4441)*100;
incertezza_max_4441 = max(abs(incertezza4441));

[v_4341, st_dev_4341] = getpvec(amx4341);
incertezza4341 = (st_dev_4341 ./ v_4341)*100;
incertezza_max_4341 = max(abs(incertezza4341));

[v_4331, st_dev_4331] = getpvec(amx4331);
incertezza4331 = (st_dev_4331 ./ v_4331)*100;
incertezza_max_4331 = max(abs(incertezza4331));

[v_4342, st_dev_4342] = getpvec(amx4342);
incertezza4342 = (st_dev_4342 ./ v_4342)*100;
incertezza_max_4342 = max(abs(incertezza4342));

[v_4442, st_dev_4442] = getpvec(amx4442);
incertezza4442 = (st_dev_4442 ./ v_4442)*100;
incertezza_max_4442 = max(abs(incertezza4442));

[v_4451, st_dev_4451] = getpvec(amx4451);
incertezza4451 = (st_dev_4451 ./ v_4451)*100;
incertezza_max_4451 = max(abs(incertezza4451));

[v_4452, st_dev_4452] = getpvec(amx4452);
incertezza4452 = (st_dev_4452 ./ v_4452)*100;
incertezza_max_4452 = max(abs(incertezza4452));

[v_4332, st_dev_4332] = getpvec(amx4332);
incertezza4332 = (st_dev_4332 ./ v_4332)*100;
incertezza_max_4332 = max(abs(incertezza4332));

[v_4322, st_dev_4322] = getpvec(amx4322);
incertezza4322 = (st_dev_4322 ./ v_4322)*100;
incertezza_max_4322 = max(abs(incertezza4322));







