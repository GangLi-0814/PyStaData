
/* Q2:若利率为20%，20年后的100万元相当于今天的多少钱？
*/
scalar r = 0.2
scalar t  = 20 
scalar fv = 100

scalar pv = fv/(1+r)^t  
dis "现值为: "pv "万元"

/* 
Q3:若利率为10%，一年后的100元钱的现值是多大？如果利率是5%呢？
*/

scalar r1 = 0.1
scalar r2 =  0.05
scalar t  = 1 
scalar fv = 100

forvalues i = 1/2{
	scalar pv = fv/(1+r`i')^t  
	dis "利率为r`i'时，现值为: "pv "元" 
}

/*
*/

* 消费者剩余
clear
set obs 200

gen q = _n
gen p = (20-q)/2 
keep if  p >0
gen p1 = 2
gen p2 = 3

line p q || (rarea p p1 q if q <= 16 & p <= 3, sort color(gray)) || ///
	(rarea p1 p2 q if q <= 14,sort color(gray)), ///
	scheme(qleanmono) plotregion(margin(sides)) legend(off) /// 
	title("消费者剩余的变化") ///
	ytitle("p") xtitle("q") ///
	yline(2,lp(dash)) xline(16,lp(dash)) ///
	yline(3,lp(dash)) xline(14,lp(dash)) ///
	ylabel(0(2)10 2 3) xlabel(0(4)20 14 16) ///
	text(6.5 10  "{it:D(P) = 20 - 2*P}") ///
	text(2 17 "{it:(16,2)}")  ///
	text(3 15 "{it:(14,3)}") ///
	text(2.5 6 "{it:S =½(14+16)*1 = 15 }")
	


