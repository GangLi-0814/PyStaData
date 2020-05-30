/*
功能：爬取中国经济网房价指数
日期：2018年7月4日
思路：1.采用curl 处理post网页
       2.利用正则表达式处理字符串
*/

set rmsg on 
cap mkdir "C:\stata15\ado\personal\housePrice"
global path = "C:\stata15\ado\personal\housePrice"
cd  $path

//用正则匹配 pagecount：获取总页面
!curl -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36" -d "curPage=`p'&numPerPage=15&rand=1530620756348" -o housePrice.txt "http://data.ce.cn/servlet/macrography/MacrographyAction?function=Housing"
infix strL v 1-20000 using housePrice.txt,clear
keep if index(v, "pagecount")
if ustrregexm(v,"(\d+)") local a = ustrregexs(1)

forvalues p = 1/`a'{   
	!curl -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36" -d "curPage=`p'&numPerPage=15&rand=1530620756348" -o housePrice.txt "http://data.ce.cn/servlet/macrography/MacrographyAction?function=Housing"
	infix strL v 1-200000 using housePrice.txt,clear
	keep if index(v,`"<td >"') | index(v,`"<td class="tsblue" style="border-left:0 none;">"') & index(v,"</td>")  //将表头先不要
	replace v = ustrregexra(v,"<(.*?)td(.*?)>","") 
	//format v %200s
	save `p'.dta,replace
}
openall
save finaldata.dta,replace
use finaldata.dta,clear
forvalues j = 1/8 {
	gen v`j' = v[_n + `j']
}
keep if mod(_n, 9) == 1
qui rename (v - v8) (时间 地区 新建住宅价格指数 二手90以下 二手90至144 二手144以上 ///
                     新建商品住宅90以下 新建商品住宅90至144 新建商品住宅144以上)
compress
save housePriceData.dta,replace
export excel using housePrice.xlsx,replace firstrow(var)  //导出为excel