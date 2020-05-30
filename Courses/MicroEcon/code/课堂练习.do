
global path = "C:\Users\mudaozi\Documents\WeChatPlatform\Economics\microeco"
global image = "$path/image"


**********
* 第一章
**********
clear
set obs 100

gen q = _n
gen d_p = (100 - q)/2

line d_p q, scheme(plotplain) ytitle(P) xtitle(Q)  ///
            xline(40) xline(60) ///
            yline(20,lp(dash)) yline(30,lp(dash)) ///
			text(45 25  "{it:D(P) = 100 - 2*P}") ///
			text(10 48 "{it:S1 = 40}")  ///
			text(10 68 "{it:S2 = 60}") 
graph export "$image/1.png", replace

		
************
* 第二章
************

/*
s.t.
m =3000
p1 = 10; p2 = 300; p3 = p2*2

p1x1 + p2x2 = m -> x2 = (100-p1x1)/p2 
*/

clear
set obs 100

scalar m = 3000
scalar p1 = 30
scalar p2 = 100
scalar p3 = 2*p2

gen x1 = _n
gen x2 = (m-p1*x1)/p2 
gen x3 = (m-p1*x1)/p3 

tw (line x2 x1) (line x3 x1), scheme(plotplain)
graph export "$image/2.png", replace