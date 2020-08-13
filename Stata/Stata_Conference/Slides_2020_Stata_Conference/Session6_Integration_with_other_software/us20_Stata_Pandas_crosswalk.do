/*************************************************************
**
**   Prepared by: Adam Ross Nelson JD PhD
**                https://github.com/adamrossnelson
**                https://twitter.com/adamrossnelson
**                July 2020
**
**   Purpose:     Demonstrate State-Python Code Crosswalk
**                State-Python Code Rosetta Stone
**
***************************************************************/

cls
set more off
clear all
capture log close
log using my_logfile.txt, text replace

sysuse auto

python
from sfi import Data          # Import Stata's Python API
import pandas as pd           # Import Pandas, Popular DataFrame module
import numpy as np            # Import Numpy, Popular scientific computing module

# Display parameters that will approximate State output
pd.set_option('display.max_columns', None)
pd.set_option('display.expand_frame_repr', False)

# Store dataset variable names for later reference
vars = pd.DataFrame(Data.getAsDict()).columns
vars = [Data.getVarName(x) for x in range(0,Data.getVarCount())]

# Store dataset in a Pandas dataframe
df = pd.DataFrame(Data.getAsDict())
df.head()

df['rep78'].describe().transpose()

# Store dataset in a Pandas dataframe, manage missing and value labels
df = pd.DataFrame(Data.getAsDict(valuelabel=True, 
                                 missingval=np.nan))
df.head()

end

// Loop through each variable - Stata
foreach var of varlist * {
     di "`var'”
}

python
# Loop through each variable - Python
for v in vars:
     print(v)

end


// Stata Code - List first five observations
list in 1/5
list make trunk weight foreign in 1/5

// Stata Code - List last five observations
list in -5/-1
list make trunk weight foreign in -5/-1

python
# Python Code - List first five observations
Data.list(obs=range(0,5))
Data.list('make trunk weight foreign', obs=range(0,5))

df.head()
df[['make','trunk','weight','foreign']].head()

df.tail()
df[['make','trunk','weight','foreign']].tail()

end

// Stata Code - Describe the data set
desc

python
# Python Code - Describe the data set
df.info()

for var in vars:
    print('{:18} {:12} {}'.format(var, Data.getVarType(var), Data.getVarLabel(var)))

pd.DataFrame({'Variable Name':vars, 
              'Data Type':[Data.getVarType(v) for v in vars], 
              'Variable Label':[Data.getVarLabel(l) for l in vars]})
			  
auto_info =  pd.DataFrame({'Variable Name':vars, 
                           'Data Type':[Data.getVarType(v) for v in vars], 
                           'Variable Label':[Data.getVarLabel(l) for l in vars]})
auto_info
			  
end

// Stata Code - Get summary statistics
sum

python
# Python Code - Get summary statistics
df.describe()

df.describe().transpose()

end

// Stata Code - Generate new text variable
gen newtxt = "Some text here"

python
# Python Code - Generate new text variable with Stata API
Data.addVarStr('newtxt', 20)
Data.store('newtxt', None, ['Some text here'] * Data.getObsTotal())

# Python Code - Generate new text variable with Stata API & Pandas
df['newtxt'] = 'Some text here'
Data.store('newtxt', None, df['newtxt'])

end

// Stata Code - Transform continuous to binary
gen isExpensive = price > 3000

// Stata Code - Create text based categorical
gen Expensive = "Affordable"
replace Expensive = "Expensive" if price > 4000

gen Long = "Short"
replace Long = "Long" if length > 187

drop isExpensive

python
# Python Code - Transform continuous to binary Combine Stata's API with Pandas
Data.addVarByte('isExpensive')
df['isExpensive'] = [1 if p > 4000 else 0 for p in df['price']]
Data.store('isExpensive', None, df['isExpensive'])

# Python code - Create text based categorical
df['Expensive'] = ['Expensive' if p > 4000 else \
                   'Affordable' for p in df['price']]

df['Long'] = ['Long' if len > 187 else \
              'Short' for len in df['length']]


end

// Stata Code - Interact price with itself
gen price2 = price * price

drop price2

python
# Python Code - Interact price with itself
Data.addVarInt('price2')
df['price2'] = df['price'].apply(lambda p: p * p)
Data.store('price2', None, df['price2'])

end

/*************************************************************
**
**   Problematic code. Expected behavior is to delete
**   price2 column from data frame. Experienced behavior
**   is output that indicates delimiter modification.
**
**   del['price2']
**   df['price2'] = df['price'] * df['price']
**
***************************************************************/

// Stata Code - Tabulate two categorical
tab Expensive foreign

python
# Python Code - Tabulate two categorical
pd.crosstab(df['Expensive'], df['foreign'])

end

// Stata Code - Tabulate three categorical
table rep78 Expensive foreign

python
# Python Code - Tabulate three categorical
pd.crosstab(df['rep78'], [df['Expensive'], df['foreign']])

end

// Stata Code - Tabulate four categorical
table foreign rep78 isExp, by(Long)

python
# Python Code - Tabulate four categorical
pd.crosstab([df['Long'], df['foreign']],
            [df['Expensive'], df['rep78']])

end

// Stata Code - The 'missing option'
tab rep78, missing

python
# Python Code - The '.fillna()' method
df['rep78'].fillna('None').value_counts()

end

// Stata Code - Merge two datasets
use http://www.stata-press.com/data/r15/autoexpense.dta, clear
merge 1:1 make using http://www.stata-press.com/data/r15/autosize.dta

python
# Python Code - Load seperate data sets
expns_df = pd.read_stata('http://www.stata-press.com/data/r15/autoexpense.dta')
sizes_df = pd.read_stata('http://www.stata-press.com/data/r15/autosize.dta')

# Perform the merge operation
# df = pd.merge(expns_df, sizes_df, on='make', how='outer', indicator=True)

# Display results using the '_merge' indicator variable
# df['_merge'].value_counts()

end


