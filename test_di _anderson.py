#TEST DI ANDERSON: si vuole verificare la bianchezza del segnale generato 'gauss'

#Importiamo inizialmente le librerie necessarie
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm as nm

#Importiamo i dati del file 'segnale.py' contenente la generazione del segnale fatta in precedenza
from segnale import gauss

#Trasposto del segnale per il calcolo della covarianza campionaria
gauss_t = gauss.transpose()

#Scelgo il valore del livello di confidenza alpha
alpha = 0.05 # 5%

#Scelgo il ritardo massimo
tau_max = 30

def Anderson(rumore,tau_max=30,alpha=0.05) :

    #Controllo livello di significatività alpha
    if alpha <= 0 or alpha >= 1 :
        print('\n')
        raise ValueError('*** Il livello di significatività alpha deve stare in (0,1) ***')

     #Controllo del passaggio del parametro tau_max
    if tau_max >= len(gauss) or tau_max <0:
        print('\n')
        raise ValueError('*** tau_max deve essere positivo ed minore della lungezza del segnale ***')
       
    #Calcolo una stima della funzione di covarianza campionaria normalizzata
    def Rho(segnale,tau_max) :
        #Inizializzo gamma
        gamma = np.zeros((tau_max+1),dtype=int)
        segnale_t = segnale.transpose()
        for t in range(0,tau_max):
            gamma[t] = (1/tau_max) * np.dot(segnale[0:tau_max-t], segnale_t[t:tau_max])
        #Calcolo di una stima della varianza campionaria normalizzata:
        #gamma[0] corrisponde ad una stima della varianza campionaria del segnale
        rho = gamma / gamma[0]
        return rho

    #print('\nRho vale: \n', Rho(rumore,tau_max))

    #Determino il parametro beta: 
    #forniamo 'alpha/2' perché consideriamo la singola coda (l'area complessiva delle due code è 5)
    beta = abs(nm.ppf(alpha/2))
    print ('\n Il parametro beta vale: \n', round(beta,6)) 

    #estremo dell'intervallo di confidenza
    estremo = beta/np.sqrt(tau_max)
    print('\nGli estremi di intervallo di confidenza sono: \n', -round(estremo,6), ' e ', \
            round(estremo,6), '\n')

    #grafico della covarianza appena ottenuta
    plt.figure('Stima della covarianza campionaria normalizzata')
    plt.plot(range(0,tau_max+1), Rho(rumore,tau_max), color='darkcyan', \
             label='Stima della covarianza campionaria ' r'$\hat\rho(\tau)$', linewidth=1.5)
    #Estremo superiore dell'intervallo di confidenza
    plt.axhline(estremo, xmin=0, xmax=tau_max, color='orange', \
                      label='Estremo superiore di ' \
                      r'$(-\frac{\beta}{\sqrt{\tau_{max}}},\frac{\beta}{\sqrt{\tau_{max}}})$', 
                      linewidth=1.5)
    #Estremo inferiore dell'intervallo di confidenza
    plt.axhline(-estremo, xmin=0, xmax=tau_max, color='red', label='Estremo inferiore di ' \
                      r'$(-\frac{\beta}{\sqrt{\tau_{max}}},\frac{\beta}{\sqrt{\tau_{max}}})$', \
                      linewidth=1.5)
    plt.axis([0,30,-0.4,1])
    plt.title('Grafico di una stima di covarianza campionaria normalizzata \n' \
               r'$\mathbf{\hat\rho(\tau)}$', fontweight='bold')
    plt.xlabel('Ritardo ' r'$\tau$')
    plt.ylabel(r'$\hat\rho(\tau)$')
    plt.legend(frameon=True, shadow=True, borderpad=1)
    plt.show()

    #Calcolo dei valori che cadono al di fuori dell'intervallo di confidenza dato
    def Conteggio(segnale,tau_max) :
        fuori = 0
        for i in range (1,len(Rho(segnale,tau_max))) :
            if np.any(Rho(segnale,tau_max)[i] > beta / np.sqrt(tau_max)) or \
               np.any(Rho(segnale,tau_max)[i] < -beta / np.sqrt(tau_max)) :
                fuori += 1
        return fuori

    print('\n Il numero dei valori fuori è: \n', Conteggio(rumore,tau_max))

    #Verifico la bianchezza
    def Test(rumore,tau_max,alpha) :
        if Conteggio(rumore,tau_max) / tau_max < alpha :
            return ('***Il segnale generato è BIANCO***')
        else :
            return('***Il segnale generato NON è BIANCO***')

    return [Test(rumore,tau_max,alpha)]

#Applico la funzione al segnale 'gauss' generato in precedenza
test = Anderson(gauss,tau_max,alpha)

print('\n Il risultato del test è: \n', test, '\n')
