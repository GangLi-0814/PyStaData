


cd "C:\Users\mudaozi\Documents\WeChatPlatform\Stata_Data_Managemet\爬取企业景气指数并可视化"

******************
* 数据爬取
******************

* 获取页面截止页码
!curl -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36" -d "curPage=1&numPerPage=15&rand=1587711227852" -o confidenceIndex.txt "http://data.ce.cn/servlet/macrography/MacrographyAction?function=Condition"
infix strL v 1-20000 using confidenceIndex.txt,clear
keep if index(v, "pagecount")
if ustrregexm(v,"(\d+)") local a = ustrregexs(1)

* 爬取并存储单页数据
forvalues p = 1/`a'{ 
	qui{
	!curl -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36" -d "curPage=`p'&numPerPage=15&rand=1530620756348" -o confidenceIndex.txt "http://data.ce.cn/servlet/macrography/MacrographyAction?function=Condition"

	* 处理字符串
	infix strL v 1-200000 using confidenceIndex.txt,clear
	keep if index(v,`"<td >"') | ///
        index(v,`"<td style="border-left:none;">"') | ///
        index(v,`"<td class="tsblue" style="border-left:0 none;">"') 
		
	replace v = ustrregexra(v,"<(.*?)td(.*?)>","") 

	* 调整数据格式
		forvalues i = 0/7{
			gen temp`i' = v if mod(_n, 7) == `i'
			preserve
			keep temp`i'
			drop if temp`i' == ""
			save ".\temp\temp`i'.dta", replace
			restore
		}	

	use ".\temp\temp0.dta", clear
	forvalues i = 1/6{
		merge 1:1 _n using ".\temp\temp`i'.dta", nogen	
	}

	nrow
	save ".\result\result`p'.dta", replace
}
	dis in result "第 -`p'- 页爬取完毕!"
}

* 合并、整理并保存数据
openall, directory("./result/")
save "企业景气指数与企业家信心指数.dta", replace

*****************
*数据整理与可视化
*****************
use "企业景气指数与企业家信心指数.dta", clear

* 日期变量
gen q = usubstr(月份,1,4) + "q" + usubstr(月份,6,1)
g 季度=quarterly(q,"YQ")
format 季度 %tq
drop q

* 数据类型
order 月份 数据类型 总体 工业 建筑业 房地产业 住宿和餐饮业
destring 总体-住宿和餐饮业, replace
encode 数据类型, gen(类型)

* 定义panel
xtset 季度 类型

* 绘图
tw (line 工业 季度 if 类型 == 1) ///
   (line 工业 季度 if 类型 == 2), ///
   scheme(qleanmono) ///
   legend(pos(8) label(1 "企业家信心指数") label(2 "企业景气指数")) ///
   title("中国企业景气指数与企业家信心指数：工业") ///
   subtitle("（时间：1999年第1季度-2019年第4季度）") ///
   ytitle("指数类别：工业") xtitle("季度") ///
   note("数据来源：中国经济网（http://data.ce.cn）")
graph export "中国企业景气指数与企业家信心指数_工业.png", replace
