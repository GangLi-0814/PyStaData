cd "D:\PyStaData\Stata\Stata_Data_Managemet\行数据相加"

import excel using "Data.xlsx", firstrow clear
split MIS, p("_")

 foreach v of varlist  TOV1993-TOV2018{
	bysort MIS1: egen `v'_1 = total(`v')
 }

keep MIS1 TOV*_1
*ssc install renvars, replace
renvars TOV1993_1-TOV2018_1, postdrop(2)
duplicates drop

gen MIS_NUM = real(subinstr(MIS1,"MIS","",.))
sort MIS_NUM
export excel using "Data_Result.xlsx", firstrow(variable) replace