

cap mkdir "findbooks"

cd "findbooks"

*****查找页码*****

copy   "http://202.114.238.250/SMJS/tableResultDetail?strText=Stata&marc_ctype=0&SearchColunm=grp_02&match_flag=2&ltzt=1&js=0" bookinfo.txt,replace

infix strL v 1-20000 using bookinfo.txt,clear
keep if index(v, "pagelist")
if ustrregexm(v,"<b>(\d+)</b>页"){
local a = ustrregexs(1)
}



forvalues p =1/`a'{
copy "http://202.114.238.250/SMJS/tableResultDetail?PageIndex=`p'&strText=Stata&marc_ctype=0&SearchColunm=grp_02&match_flag=2&ltzt=1&js=0" bookinfo.txt,replace

infix strL v 1-20000 using bookinfo.txt,clear

keep if index(v, "</strong></span>") | index(v,"target=‘_blank’")

replace v = ustrregexra(v, "<.*?>", "")

drop if ustrregexm(v, "价格|丛书|复本数|累借天数|累借次数|在馆数")

save `p'.dta,replace
}

openall
save final.dta,replace


use final.dta,clear
split v,parse("：")
replace v2 = ustrregexs(1) if ustrregexm(v1,"(.*?):\S") & v2==""
drop v v1
rename v2 v
forvalues j = 1/7 {
gen v`j' = v[_n + `j']
}
keep if mod(_n, 8) == 1 
rename (v - v7) (书名 作者 出版社 出版时间 ISBN 索书号 分类号 页数)
compress
