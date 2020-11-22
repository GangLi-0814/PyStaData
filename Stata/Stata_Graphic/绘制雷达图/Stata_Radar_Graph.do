ssc install radar, replace
ssc install brewscheme, replace

brewscheme, scheme(test2) barst(paired) barc(12) dotst(prgn) dotc(7) ///   
scatstyle(set1) scatc(9) linest(pastel2) linec(8) boxstyle(accent) boxc(8)  ///   
areast(dark2) areac(8) piest(mdepoint) sunst(greys) histst(veggiese)   ///   
cist(activitiesa) matst(spectral) reflst(purd) refmst(set3) const(ylgn)  ///   
cone(puor)

set scheme test2 
sysuse auto,clear   
radar make weight if foreign

//法二：
sysuse auto,clear
   
radar make weight if foreign ,plotregion(style(none))

radar make turn mpg trunk if foreign

radar make turn mpg trunk if foreign, title(Nice Radar graph)

radar make turn mpg trunk if foreign, title(Nice Radar graph) lc(red blue green) lp(dash dot dash_dot)



qui{
use "http://www.stata-press.com/data/r9/fullauto.dta", clear
drop if rep78 ==.
collapse mpg, by(rep78)
qui tab rep
local num = r(r)
gen max = ceil(mpg)
rename rep id
sort id
tempfile foo1 foo2 foo3
save `foo1'
sum max
local max = round(r(max),10)
clear
local num = `num' + 1
set obs `num'
gen angle = 72*(_n-1)
replace angle = 360 in 1
gen ang2 = angle/57.2957795
gen y = `max'*sin(ang2)
gen x = `max'*cos(ang2)
gen halfy = (`max'/2)*sin(ang2)
gen halfx = (`max'/2)*cos(ang2)
gen center1 = 0
gen center2 = 0
gen id = _n
sort id
save `foo2'
use `foo1'-
merge id using `foo2'
drop _m
replace mpg = mpg[1] in 6
sort id
save `foo2', replace
gen j = _n
reshape wide x y, i(id) j(j)
sort id
save `foo3'
use `foo2'
merge id using `foo3'
forv i = 1/6 {
replace x`i' = 0 if x`i' == .
replace y`i' = 0 if y`i' == .
}
replace id = . in 6
input clock
12
3
6
6
9
end
gen mpg_y = mpg*sin(ang2)
gen mpg_x = mpg*cos(ang2)
}
twoway connect  x y, lc(black) mc(gs0) lw(medthick) ///
ml(id) mlabsize(large) mlabv(clock)  ///
|| conn  mpg_x mpg_y ,mc(gs0) lc(gs0) recast(area) ///
|| conn   halfx halfy, lc(black) mc(gs0) lp(dash) ///
|| scatter center1 center2, mc(gs0) ///
|| connect x1 y1,lc(gs0) mc(gs0) ///
|| conn x2 y2,lc(gs0) mc(gs0) ///
|| conn x3 y3,lc(gs0) mc(gs0) ///
|| conn x4 y4 ,lc(gs0) mc(gs0) ///
|| conn x5 y5, lc(gs0) mc(gs0) ///
|| conn x6 y6, legend(off)lc(gs0)  mc(gs0) ///
xscale(off) yscale(off) xlabel(none) ylabel(none, nogrid) ///
aspect(1) plotregion(style(none) margin(large)) ///
text( 15 -2 "`=`max'/2'", size(small)) scheme(test2) ///
text(27 -2 "`max'", size(small)) title("Average MPG by Repair Record")