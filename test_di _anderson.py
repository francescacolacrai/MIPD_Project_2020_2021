#TEST DI ANDERSON: si vuole verificare la bianchezza del segnale generato 'gauss'

#Importiamo inizialmente le librerie necessarie
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm as nm

#Importiamo i dati del file 
#from generazione_rumore import gauss

#generazione segnale per provare la funzione 'Anderson'
np.random.seed(1)
media = 2
var = 1
dev = np.sqrt(var)
signal = media + dev * np.random.randn(10000)

#Numero di campioni
N = signal.size 
signal_t = signal.transpose()

#Scelgo il ritardo massimo
tau_max = 30

#Scelgo il valore del livello di confidenza alpha
alpha = 0.05 # 5%

 #Determino il parametro beta: percentile è una misura utilizzata in statistica 
#che indica il valore in corrispondenza del quale cade una data percentuale di osservazioni
#Forniamo '2.5' perché consideriamo la singola coda (l'area complessiva coperta dalle due code è 5)
#beta = abs(np.quantile(gauss, alpha/2))
beta = abs(nm.ppf(alpha/2))
#beta = abs(np.percentile(signal, (alpha*100)/2))
print ('Il parametro beta vale: \n', round(beta,6))

#Controllo livello di significatività alpha
if alpha <= 0 or alpha >= 1 :
    raise ValueError('***Il livello di significatività alpha deve stare in (0,1)***')

def Anderson(rumore,alpha,tau_max) :

    #Calcolo una stima della funzione di covarianza campionaria normalizzata
    def Rho(segnale,tau_max) :
        gamma = np.zeros((tau_max+1),dtype=int)
        segnale_t = segnale.transpose()
        #gamma_zero: stima della varianza del segnale 'gauss'
        gamma_zero = (1/tau_max) * np.dot(segnale[1:tau_max], segnale_t[1:tau_max])
        for t in range(0,tau_max):
            gamma[t+1] = (1/tau_max) * np.dot(segnale[1:tau_max-t], segnale_t[1+t:tau_max])
            rho = gamma / gamma_zero
        return rho

    print('\nRho vale: \n', Rho(rumore,tau_max))

    #estremo dell'intervallo di confidenza
    estremo = beta/np.sqrt(tau_max)
    print('\nGli estremi di intervallo di confidenza sono: \n', -round(estremo,6), ' e ', round(estremo,6), '\n')


    #grafico della covarianza appena ottenuta
    plt.figure('Stima della covarianza campionaria normalizzata')
    #for i in range (tau_max+1) :
        #plt.plot(i, Rho(rumore,tau_max), linewidth=1.5)
    plt.plot(range(0,tau_max+1),Rho(rumore,tau_max))
    sup = plt.axhline(estremo, xmin=0, xmax=tau_max)
    inf = plt.axhline(-estremo, xmin=0, xmax=tau_max)
    plt.title('Grafico di una stima di covarianza campionaria normalizzata \n' r'$\mathbf{\hat\rho(\tau)}$', fontweight='bold')
    plt.xlabel('Ritardo ' r'$\tau$')
    plt.ylabel(r'$\rho(\tau)$')
    plt.show()

    #Calcolo dei valori che cadono al di fuori dell'intervallo di confidenza dato
    def Conteggio(segnale,tau_max) :
        fuori = 0
        for i in range (1,len(Rho(segnale,tau_max))) :
            if np.any(Rho(segnale,tau_max)[i] > beta / np.sqrt(tau_max)) or np.any(Rho(segnale,tau_max)[i] < -beta / np.sqrt(tau_max)) :
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
test = Anderson(signal,alpha,tau_max)

print('\n Il risultato del test è: \n', test, '\n')
