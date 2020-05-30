
* 主要用途: 自动将值分为 n 列，preserve 和 frames 对比
* 作者：PyStaData_LG
* 创建时间：20200327
* 上次修改：20200327



*******************
* 生成数据
********************
version 16.0
clear
set obs 200
set seed 2020
gen x = 10*runiform()

**************************************
* 常规方法：preserve/restore + merge
**************************************

local group = 3  // 分成几组

* 组别识别变量
gen n = _n
gen temp = int(autocode(n,`group',0,_N)) 

* 拆分成子集
levelsof temp
local a = 1
qui{
	foreach i in `r(levels)'{
	preserve
	gen x`a' = x if temp == `i'
	drop if x`a' == .
	gen temp2 = _n
	keep temp2 x`a'	
	save "temp_x_`a'.dta", replace
	local a = `a' + 1
	restore
	}
}

* 合并子集
use "temp_x_1.dta", clear
forvalues i = 2/`group'{
	qui merge 1:1 temp2 using "temp_x_`i'.dta", nogen
}
drop temp*
save "result.dta", replace

* 清除临时文件
qui{
	fs "temp_x*.dta"
	foreach i in `r(files)'{
		erase `i'
	}
}

*******************
* Data Frames
*******************
frame reset
set obs 200
set seed 2020
gen x = 10*runiform()
local g = 3  

gen n = _n
gen temp = int(autocode(n,`g',0,_N))

local a = 1
levelsof temp
foreach i in `r(levels)'{
	cap frame drop group`a'
	frame copy default group`a'
	frame change group`a'
	keep if temp == `i'
	gen x`a' = x
	gen temp2 = _n
	keep x`a' temp2
	local a = `a' + 1
	frame change default
}

frame copy default result
gen temp2 = _n
keep temp2
forvalues i = 1/`g'{
	frlink 1:1 temp2, frame(group`i')
	frget x`i' = x`i', from(group`i') 
}
egen m = rowmiss(_all)
drop if m == 6
keep x*
