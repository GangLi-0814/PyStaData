
cd "/Users/gangli/PyStaData/Stata/Stata_Data_Managemet/批量转换数据格式"

cd "code/data"

* ssc install fs, replace
fs *.xlsx

foreach file in `r(files)'{
 local filename = subinstr("`file'",substr("`file'",-5,.),"",.)
 import excel using "`file'", clear
 save "../output/`filename'.dta", replace
}



local files: dir "`c(pwd)'" files "*.xlsx"
foreach file in `files'{
 local filename = subinstr("`file'",substr("`file'",-5,.),"",.)
 import excel using "`file'", clear
 save "../output/`filename'.dta", replace
}
