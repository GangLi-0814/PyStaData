


clear
set obs 4748
gen date= mdy(12,31,2004) + _n
format date %td

expand 141
bys date: gen idN=_n

sort  idN date
merge m:1 idN using state_county_idN
drop _merge

xtset idN date
