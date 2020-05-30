use sample.dta, clear

gen y = year(日期)
gen m = month(日期)
gen d = day(日期)

foreach t in "y m d"{
	tostring `t', replace
}
gen date = m + "/" + d + "/" + y
drop y m d

gr box 正式教室排课数, marker(1,msize(vsmall)) ///
 over(date, sort(日期) label(ang(90) labsize(*.5))) scheme(plotplain) 
 