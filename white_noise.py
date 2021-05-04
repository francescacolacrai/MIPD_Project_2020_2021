#GENERATION OF A GAUSSIAN WHITE NOISE (~WN[O,lambda^2])

import pandas as pd
import pandas.plotting as pdpl
import matplotlib.pyplot as plt
import matplotlib as mpl
import numpy as np 
import statistics as st
from statsmodels.graphics import tsaplots

#define plot style
plt.style.use(['classic', '_classic_test_patch'])
mpl.rcParams['lines.linewidth'] = 0.5
mpl.rcParams['lines.linestyle'] = '-'

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

#line plot
plt.plot(gauss, color='navy', label='White Noise Series')
plt.title('White Noise($ \\mu=0$, $\\sigma^2$=1)', fontweight='bold')
plt.xlabel('Cross-section')
plt.ylabel("Values")
plt.axis([0, 10000, -4.5, 5.0])
plt.grid(True)
plt.show()

#histogram plot 
num_bins = 100
n, bins, patches = plt.hist(gauss, num_bins, density = 3, color='#006400', edgecolor='k', label='Histogram')  
PDF_Gauss = (1/(np.sqrt(2*np.pi)*dev_st)) * np.exp(-((bins-media)**2)/(2*dev_st**2))
plt.plot(bins, PDF_Gauss, color='#FF4500', linewidth=2, label='Gaussian PDF')
plt.text(-3.7,0.3,r'$p_X(x)=\frac{1}{\lambda \sqrt{2\pi}}e^{-\frac{(x-\mu)^2}{2\lambda^2}} \searrow$', size=14)
plt.title('Probability distribution of white noise (gaussian)', fontweight='bold')
plt.xlabel('')
plt.ylabel('Distribution')
plt.legend(frameon=True, shadow=True, borderpad=1)
plt.show()

#autocorrelation plot
acorr = pdpl.autocorrelation_plot(gauss, color='#800000', lw=1, label='Autocorrelation')
acorr.set_xlim([0,500])
plt.title('Autocorrelation plot', fontweight='bold')
plt.xlabel('Lag')
plt.ylabel('Autocorrelation')
plt.axis([0,500,-0.3,0.3])
plt.legend(frameon=True, shadow=True, borderpad=1)
plt.show()


