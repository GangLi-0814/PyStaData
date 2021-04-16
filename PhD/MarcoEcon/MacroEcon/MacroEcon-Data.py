import akshare as ak
import pandas as pd 
import matplotlib.pyplot as plt

# Example 2: Make a plot of the US unemployment rate

# Set plotting style to 'classic' because I like the look
plt.style.use('classic')

# Specify that you want plots displayed in the Jupyter Notebook and not in an external window (IPython magic command)
# %matplotlib inline

# Download the unemployment rate data (PROVIDED)
unemployment = pd.read_csv('https://fred.stlouisfed.org/data/UNRATE.txt',skiprows=24,sep='\s+',index_col=0,parse_dates = True)

# Print first 5 rows of unemployment variable
unemployment.head()

# Create a well-labeled plot of the US unemployment rate
unemployment.plot(legend=False,lw=3,alpha=0.75)
plt.ylabel('Percent')
plt.xlabel('Date')
plt.title('US Unemployment Rate')
plt.grid()

# Save the figure to the current working directory at 120 dots per inch resolution
plt.savefig('unemployment.png',dpi=120)


