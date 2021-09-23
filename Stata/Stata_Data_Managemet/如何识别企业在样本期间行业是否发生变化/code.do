************************************
* 如何识别企业在样本期间行业是否发生变化
************************************


use "try.dta", clear

* 法一：数据集匹配
preserve
sort code year
keep code indcd
duplicates drop code,force
save "try_indcd_temp.dta", replace
restore
merge m:1 code indcd using "try_indcd_temp.dta"
gen diff = 1 if _merge != 3
egen total_diff = count(diff), by(code)
gen changed_1 = (total_diff != 0)
drop _merge diff total_diff
count if changed_1 == 1

* 法二：利用 _N 
bysort code indcd:gen numa=_N
bysort code :gen numb=_N
gen changed_2 = (numa!=numb)
count if changed_2 == 1
drop numa numb

* 法三：nvals() 函数
egen group_dup = nvals(indcd), by(code)
gen changed_3 = (group_dup != 1)
drop group_dup
count if changed_3 == 1

sum  changed*







