clear 
set obs 126 
egen year = seq(), block(6) from(1990) to(2010)
set seed 2803
gen y = exp(rnormal())

* 问题图片
graph box y, over(year)

* 换为 hbox
graph hbox y, over(year)

* 更改刻度间距
forval y = 1990/2010 {
    if mod(`y', 5) {
        label def ylbl `y' `"{char 0xa0}"', add // 0xa0: UTF-8编码的空格 
    }
}
label val year ylbl 
label li ylbl 
graph box y, over(year)

* 倾斜
clear 
set obs 126 
egen year = seq(), block(6) from(1990) to(2010)
set seed 2803
gen y = exp(rnormal())

gen date = year
tostring date, replace


gen date1 = date(date, "Y")
format date1 %tdCCYY.NN.DD



graph box y, over(year,label(angle(45)))

/*
参考资料: 
https://www.statalist.org/forums/forum/general-stata-discussion/general/1297758-axis-options-for-box-plot-how-can-i-reduce-number-of-labels-on-the-x-axis
*/

