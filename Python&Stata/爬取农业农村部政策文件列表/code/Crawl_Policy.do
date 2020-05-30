
/*
<li class="ztlb">
<a href="./201911/t20191121_6332163.htm" target="_blank" title="关于印发《国家农民合作社示范社评定及监测办法》的通知">
                                                                                                         关于印发《国家农民合作社示范社评定及监测办法》的通知</a>
<span> 2019-11-13</span>
</li>

*/

cd "$data"
clear
cls
************
*爬取
************
python:

import requests
from bs4 import BeautifulSoup

#法律
stata: capture log close
stata:log using "法律.txt", replace
for i in range(0, 5):
	if i == 0:
		res =requests.get('http://www.moa.gov.cn/gk/zcfg/fl/index.htm')
	else:
		res =requests.get('http://www.moa.gov.cn/gk/zcfg/fl/index_{}.htm'.format(i))
	res.encoding = 'utf-8'
	soup = BeautifulSoup(res.text, 'html.parser')
	list = soup.find_all("li",{"class","ztlb"})
	print(list)

#规范性文件
stata: capture log close
stata:log using "规范性文件.txt", replace
for i in range(0, 44):
	if i == 0:
		res =requests.get('http://www.moa.gov.cn/gk/zcfg/nybgz/index.htm')
	else:
		res =requests.get('http://www.moa.gov.cn/gk/zcfg/nybgz/index_{}.htm'.format(i))
	res.encoding = 'utf-8'
	soup = BeautifulSoup(res.text, 'html.parser')
	list = soup.find_all("li",{"class","ztlb"})
	print(list)

#行政法规
stata: capture log close
stata:log using "行政法规.txt", replace
for i in range(0, 5):
	if i == 0:
		res =requests.get('http://www.moa.gov.cn/gk/zcfg/xzfg/index.htm')
	else:
		res =requests.get('http://www.moa.gov.cn/gk/zcfg/xzfg/index_{}.htm'.format(i))
	res.encoding = 'utf-8'
	soup = BeautifulSoup(res.text, 'html.parser')
	list = soup.find_all("li",{"class","ztlb"})
	print(list)

#政策
stata: capture log close
stata:log using "政策.txt", replace
for i in range(0, 3):
	if i == 0:
		res =requests.get('http://www.moa.gov.cn/gk/zcfg/qnhnzc/index.htm')
	else:
		res =requests.get('http://www.moa.gov.cn/gk/zcfg/qnhnzc/index_{}.htm'.format(i))
	res.encoding = 'utf-8'
	soup = BeautifulSoup(res.text, 'html.parser')
	list = soup.find_all("li",{"class","ztlb"})
	print(list)

stata: cap log close
end

*************
*处理文本
*************
global policy = "法律 规范性文件 行政法规 政策"

foreach p in $policy{
	insheet using "`p'.txt", clear
	keep v1
	drop if v1 == "" | regexm(v1, "ztlb>") == 1 | regexm(v1, "</li>]") == 1
	gen date = strtrim(regexs(1)) if regexm(v1[_n+1],"<span>(.*)</span>")
	drop if regexm(date,"-") == 0
	replace v1 = subinstr(v1,">","",.)
	replace v1 = regexs(1) if regexm(v1, "#000000&gt;(.*)&lt;/font&gt;'")
	rename v1 title
	gen type = "`p'"
	save "temp_`p'.dta", replace
}

******************
*合并、导出数据
******************
clear
openall temp*
compress
duplicates drop
save "$outputdata/农村农业部公开政策法规和公布时间.dta", replace
export excel using "$outputdata/农村农业部公开政策法规和公布时间.xlsx", firstrow(variable)  replace

************
*数据分析
************
use "$outputdata/农村农业部公开政策法规和公布时间.dta", clear

*数据整理
split date,p("-")
renvars date1 date2 date3 \ year month day
destring year month day,replace
encode type, gen(type_c)

tab year
keep if year > 1995

*每年政策公布量
bysort year:gen total_issue = _N

*政策总量线图
keep if year > 1995
twoway (scatter total_issue year) ///
	   (connected total_issue year, clpattern(dash) msymbol(d)), ///
       scheme(s1mono) legend(off) ///
       note("数据来源：整理自农业农村部官网")
 graph export "$result/Fig01_Policy_Issue.png", replace
