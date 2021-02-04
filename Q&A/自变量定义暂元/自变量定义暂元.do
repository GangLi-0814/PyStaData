sysuse auto,clear

local v1 "wei"
local v2 "wei len"
local v3 "wei len rep78"

forvalues i = 1/3{
	reg price `v`i''
}


sysuse auto,clear
global v1 "wei"
global v2 "wei len"
global v3 "wei len rep78"

forvalues i = 1/3{
	local indep "v`i'"
	reg price $`indep'
}


