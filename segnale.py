#FILE D'APPOGGIO PER IL SEGNALE GENERATO IN PYTHON 

#importazione delle librerie
import numpy as np 
import statistics as st

#seed random number generator
np.random.seed(1)

#create white noise 
media = 0 
dev_st = 1
varianza = dev_st ^ 2
gauss = media + dev_st * np.random.randn(10000)

#verify properties
print('\n La media è: \n', st.mean(gauss))
print('\n La deviazione standard è: \n', st.stdev(gauss))
print('\n La varianza è: \n', st.variance(gauss), '\n')
