cd "./爬取学院通知"
cap mkdir "news"
cap mkdir "temp"
cd "news"

forvalues i = 1/102{
	local end "htm"
	if `i' >= 10{
		local end "psp"
	}
	qui{
		copy "http://gsxy.zuel.edu.cn/4140/listm`i'.`end'" news_`i'.txt, replace
		infix strL v 1-20000 using "news_`i'.txt", clear
		keep if regexm(v,`"<li class="cols n"') == 1
		gen title = regexs(1) if regexm(v,"title='(.*)'>")
		gen link = regexs(1) if regexm(v,"<a href='(.*)' target")
		gen date = regexs(1) if regexm(v,`"<span class="cols_date">(.*)</span>"')
		save "../temp/news_`i'.dta", replace
	}
	dis "第-`i'-页爬取完毕！"
}

cd "../temp"
openall
keep if regexm(title,"十佳") == 1

export excel using "../通知.xlsx", firstrow(variable) replace


