import random as rd
import pandas as pd
import pandas.plotting as pdpl
import matplotlib.pyplot as plt
import matplotlib as mpl

#define plot style
plt.style.use(['classic', '_classic_test_patch'])
mpl.rcParams['lines.linewidth'] = 0.5
mpl.rcParams['lines.linestyle'] = '-'

#seed random number generator
rd.seed(1)

#create white noise series
series = [rd.gauss(0.0, 1.0) for i in range(10000)]
series = pd.Series(series)

#summary stats
print(series.describe())

#line plot
plt.plot(series, color='navy', label='White Noise Series')
plt.title('White Noise($\\mu=0$, $\\sigma^2$=1)')
plt.xlabel('Cross-section')
plt.ylabel("Values")
plt.axis([0, 10000, -4.5, 5.0])
plt.legend(frameon=True, shadow=True, borderpad=1)
plt.grid(True)
plt.show()

#histogram plot 
plt.hist(series, color='navy', edgecolor='k', label='Histogram')
plt.title('Probability distribution of white noise(gaussian) ')
plt.xlabel('')
plt.ylabel('Distribution')
plt.legend(frameon=True, shadow=True, borderpad=1)
plt.grid(True)
plt.show()

#autocorrelation plot
pdpl.autocorrelation_plot(series, color='navy', label='Autocorrelation')
plt.title('Autocorrelation plot')
plt.xlabel('Lag')
plt.ylabel('Autocorrelation')
plt.axis([0,10000,-0.3,0.3])
plt.legend(frameon=True, shadow=True, borderpad=1)
plt.show()