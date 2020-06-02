clear
set obs 200

gen p = _n
gen d = 12-2*p
gen s = d*p
drop if s < 0

scatter s p || qfit s p, ///
xline(3, lp(dash)) text(18.5 3 "(3, 18)")
