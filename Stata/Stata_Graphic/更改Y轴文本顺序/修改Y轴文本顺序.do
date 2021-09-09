



* Way1: reverse the title text 
sysuse auto, clear
local ytext "平均班级规模"
local ytext_re = ustrreverse("`ytext'")
scatter pr wei, ytitle("`ytext_re'")


* Way2: modify the orientation of title text
sysuse auto, clear
scatter pr wei, ytitle("平均班级规模",orientation(rvertical))

* Way3: Modify the text 
sysuse auto, clear
local text = "平"+char(10)+"均"+char(10)+"班"+char(10)+"级"+char(10)+"规"+char(10)+"模"
scatter pr wei, ytitle("`text'",orientation(horizon))

* Way4
sysuse auto, clear
scatter pr wei, ytitle("幼" "儿" "园" "平" "均" "班" "级" "规" "模",orientation(horizontal)) ylabel(,ang(0))


tw  (line 全国幼儿园 year, lp(solid)) ///
 (line 城区幼儿园 year, lp(shortdash)) ///
 (line 镇区幼儿园 year, lp(dash_dot)) ///
 (line 乡村幼儿园 year, lp(longdash)) ///
  , xlabel(2001(1)2017, ang(45)) xtitle(年份) ///
  ylabel(20(2)34) ytitle("幼" "儿" "园" "平" "均" "班" "级" "规" "模",orientation(horizontal)) ylabel(,ang(0)) ///
  leg(rows(1) position(6) ring(0)) scheme(s1mono) 

*******************************
set scheme s2mono


sysuse auto,clear
scatter pr wei, ytitle("汽车价格") 


sysuse auto,clear

* 方式一
scatter pr wei, ///
ytitle("汽" "车" "价" "格", place(12) orientation(horizontal) margin(medsmall))


sysuse auto,clear

* 方式一
scatter pr wei, ///
ytitle("汽车价格", place(12) orientation(horizontal) margin(medsmall))

