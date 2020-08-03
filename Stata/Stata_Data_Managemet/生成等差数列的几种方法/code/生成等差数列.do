cd "D:\PyStaData\Stata\Stata_Data_Managemet\生成等差数列的几种方法\code"


/* 问题：
使用 Stata 生成 1~100，步长为2的等差数列。
*/

*************
* 法一
*************
clear
set obs 50
egen x1 =  fill(1(2)100)

**************
* 法二
**************
gen x2 = .
local i = 1
forvalues j = 1(2)100{
	qui replace x2 = `j' in `i'
	local i = `i' + 1
}

************
* Python
************
clear
python:
from sfi import Data

x3 = []
for i in range(1, 100, 2):
    x3.append(i)	

Data.addObs(len(x3))
Data.addVarInt('x3')
Data.store('x3',None,x3)
end


*example
 
view browse "https://www.statalist.org/forums/forum/general-stata-discussion/general/1507057-storing-a-database-from-python-into-a-stata-dataframe"

clear
python
import pandas as pd
import sfi as sfi
from sfi import Frame, Data
from pandas import Series, DataFrame
data = {'school': ['UCSC', 'UCLA', 'UCD', 'UCSB', 'UCI', 'UCSF'],'year': [2000, 2001, 2002, 2001, 2002, 2003], 'num': [4000, 3987, 5000, 4321, 5000, 8200]}

ds = pd.DataFrame(data)
Data.setObsTotal(len(ds))
Data.addVarStr('school', 1)
Data.addVarDouble('year')
Data.addVarDouble('num')
Data.store(None, None, ds.values.tolist())
end
list