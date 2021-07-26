#GENERAZIONE DELL'ONDA SINUSOIDALE DAI CAMPIONI OTTENUTI CON L'ADC

import numpy as np
import math as mt
import matplotlib.pyplot as plt


A = 3.3 #ampiezza (V)
F = 15 #frequenza (Hz)
T_tot = 5 #s
omega = 2 * np.pi * F #pulsazione
F_max = 10 #frequenza max di acquisizione (Hz)
phi = 0 #fase iniziale 
t = 0

#generazione grafici 
for t in range(0,T_tot):
    #generazione sinusoide
    for i in range (1,F_max) :
        sinusoide = A * mt.sin(omega + phi)
        plt.figure('Generazione del segnale a ... Hz')
        plt.plot(t,sinusoide, linewidth = 1.5, color = 'darkcyan')
        plt.xlabel('Istante ' r'$\mathbf{t}$')
        plt.ylabel('Sinusoide di frequenza' r'$\mathbf{f}$')
        plt.axis([0, 5, -3.3, 3.3])
        plt.title("Generazione onda sinusoidale dai dati campionati dall'ADC", fontweight = 'bold')
        plt.show