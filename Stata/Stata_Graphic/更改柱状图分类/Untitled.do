cd  "D:\Q&A\画图"
cap mkdir temp
cap mkdir result

****************
* 调整数据结构
****************

use "画图数据.dta", clear
global categories =  "sacrifice compassion policymaking publicinterest"
foreach c in $categories{
	preserve
	gen 愿意在农村地区工作 = `c' if 您是否愿意在农村地区工作 == 1
	gen categories = "`c'"
	keep 愿意在农村地区工作 categories
	drop if 愿意在农村地区工作 == .
	gen id = _n
	save "./temp/`c'_1.dta", replace
	restore

	preserve
	gen 不愿意在农村地区工作 = `c' if 您是否愿意在农村地区工作 == 2
	gen categories = "`c'"
	keep 不愿意在农村地区工作 categories
	drop if 不愿意在农村地区工作 == .
	gen id = _n
	save "./temp/`c'_2.dta", replace
	restore
}


cd temp
clear 
set obs 4
gen categories = ""
local i = 1
foreach c in $categories{
	replace categories = "`c'" in `i'
	local i = `i' + 1
}
save "categories.dta", replace

foreach c in $categories{
	use "categories.dta", clear
	merge 1:m categories using `c'_1.dta, nogen keep(3)
	merge 1:1 id using `c'_2.dta, nogen keep(3)
	drop id
	save "../result/`c'.dta", replace
}

cd ../result
openall
save "D:\Q&A\画图\data_transfered.dta", replace

***********
* 绘图
***********
graph bar 愿意在农村地区工作 不愿意在农村地区工作,scheme(plotplain) ///
over(categories) bargap(-30)  ///
title("Average Willingness to Stay in the Countryside") ///
ytitle("Willingness") ///
subtitle("by type of decision maker") ///
note("Source: China Family Panel Studies (CFPS)(www.isss.pku.edu.cn/cfps)") ///
blabel(bar, position(inside) format(%9.1f) color(white)) ///
legend(col(1) label(1 "Stay") label(2 "Not Stay") )

