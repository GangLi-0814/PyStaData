clear
set obs 60
set seed 2020
gen v = 10*runiform()

 
 xpose, clear varname
 drop _varname
 stack v1-v60, into(V1-V20)
 drop _stack
 xpose, clear