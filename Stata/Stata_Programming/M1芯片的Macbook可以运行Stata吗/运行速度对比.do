
* 安装外部命令
/* net install benchmark,   ///
from(https://raw.githubusercontent.com/mcaceresb/stata-benchmark/master/)
 */

**************
* 导入数据
**************
cd "/Users/gangli/Database/工业企业数据库（STATA）"
forvalues year = 1998/2013{
	benchmark: ///
	use "FIRM`year'_raw.dta", clear
}

***************
* 数据整理与绘图
***************
cd "/Users/gangli/OneDrive/文档/PyStaData"

* 数据整理
import excel using "运行时间.xlsx", firstrow clear
split Stata15, p(" ")
split Stata16, p(" ")
encode 设备, gen("Device")
keep 数据年份 数据大小 Device Stata151 Stata161
rename (数据年份 数据大小 Stata151 Stata161) (Year Size Stata15 Stata16)
destring Stata15 Stata16, replace


* 画图
tw connect Stata15 Stata16 Year, by(Device, note("")) ///
scheme(tufte) legend(row(1)) ///
xtitle("") ytitle("耗时（单位：秒）") ///
ylabel(0(3)9) xlabel(1998(2)2013)
graph export "Spend_Time_By_Devices.jpg", replace


