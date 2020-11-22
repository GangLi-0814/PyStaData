global path "D:\PyStaData\Stata\Stata_Graphic\2020社科基金可视化"
global d "$path/data"
global o "$path/output"
global r "$path/result"


* 数据来源
*view browse "http://www.nopss.gov.cn/n1/2020/0909/c219469-31855619.html"

* # 1.数据准备
**********************
	* ## 1.1 下载数据
	*******************
cd "$d"
	copy "http://download.people.com.cn/dangwang/one15996450631.xls" "2020年国家社科基金年度项目立项名单.xls", replace
	copy "http://download.people.com.cn/dangwang/one15996450861.xls" "2020年国家社科基金青年项目立项名单.xls", replace
	
	* ## 1.2 合并数据
	********************
	foreach t in "年度项目" "青年项目"{
		import excel "2020年国家社科基金`t'立项名单.xls", firstrow clear
		gen 项目类型 = "`t'"
		save "$o/`t'.dta", replace
	}

cd "$o"
	openall
save "$r/2020社科立项名单.dta", replace



* # 2.分析数据
********************
use "$r/2020社科立项名单.dta", clear

	* ## 2.1 项目类型与学科
	************************
	tab 项目类型
	tab 项目类别 if 项目类型 == "年度项目"
	
	tab 所在学科, sort
	bysort 项目类型: tab 所在学科, sort
	bysort 项目类别: tab 所在学科 if 项目类型 == "年度项目", sort

	
	* ## 2.2 工作单位
	*********************
	tab 工作单位, sort
	
	* 管理学
	tab 工作单位 if 所在学科 == "管理学", sort

	* 应用经济+理论经济
	tab 工作单位 if 所在学科 == "应用经济" == 1, sort
	tab 工作单位 if 所在学科 == "理论经济" == 1, sort

	* 项目类别对应的单位
	tab 工作单位 if 项目类别 == "重点项目", sort
	tab 工作单位 if 项目类别 == "一般项目", sort
	tab 工作单位 if 项目类别 == "青年项目", sort

	edit if 工作单位 == "中南财经政法大学"
