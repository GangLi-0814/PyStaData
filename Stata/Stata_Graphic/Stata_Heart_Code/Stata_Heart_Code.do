**********************
* Stata 笛卡尔心型线
**********************
clear
range t 0 2*_pi 1000
gen x=16*sin(t)^3
gen y=13*cos(t)-5*cos(2*t)-2*cos(3*t)-cos(4*t)
egen x_min=min(x)
egen x_max=max(x)
egen y_min=min(y)
egen y_max=max(y)
gen a=(x-x_min)/(x_max-x_min)
gen b=(y-y_min)/(y_max-y_min)
line b a
gr_edit yaxis1.draw_view.setstyle， style(no)
gr_edit xaxis1.draw_view.setstyle， style(no)
gr_edit plotregion1.AddTextBox added_text editor .7055394244311991 .2810707216715078
gr_edit plotregion1.added_text_new = 1
gr_edit plotregion1.added_text_rec = 1
gr_edit plotregion1.added_text[1].style.editstyle  angle(default) size(medsmall) color(red) horizontal(left) vertical(middle) margin(zero) linegap(zero) drawbox(no) boxmargin(zero) fillcolor(bluishgray) linestyle( width(thin) color(red) pattern(solid)) box_alignment(east) editcopy
gr_edit plotregion1.added_text[1].style.editstyle size(large) editcopy
gr_edit plotregion1.added_text[1].text = {}
gr_edit plotregion1.added_text[1].text.Arrpush  "           I LOVE YOU"
graph export "C：\Desktop\520.png"， as(png) wid(800)hei(600) replace


********************
* Stata Heart Code
********************
/* Author: Belen Chavez
     Stata Heart Code
     Happy Valentine's Day <3 */

* view browse "http://www.belenchavez.com/data-blog/happy-valentines-day-stata-style"

clear all
set obs 463
gen t = .
local c = 1  
forv i = 0(0.05)`=2`c(pi)''{
        replace t = `i' in `c'
        local ++c
}

gen x = 16*sin(t)^3
gen y = 13*cos(t)-5*cos(2*t)-2*cos(3*t)-cos(4*t)

gen mlab = ustrunescape("\U0001f63b")
graph3d x y t , colorscheme(bcgyr) scale(3) markeroptions(mlab(mlab))


***************
* Stata emoji
***************
clear
set obs 12
gen x = _n
gen y = x + uniform()

gen emoji = ustrunescape("\U0001f400") if x == 1
replace emoji = ustrunescape("\U0001f430") if x == 2
replace emoji = ustrunescape("\U0001f439") if x == 3
replace emoji = ustrunescape("\U0001f411") if x == 4
replace emoji = ustrunescape("\U0001f410") if x == 5
replace emoji = ustrunescape("\U0001f404") if x == 6
replace emoji = ustrunescape("\U0001f408") if x == 7
replace emoji = ustrunescape("\U0001f412") if x == 8
replace emoji = ustrunescape("\U0001f434") if x == 9
replace emoji = ustrunescape("\U0001f437") if x == 10
replace emoji = ustrunescape("\U0001f418") if x == 11
replace emoji = ustrunescape("\U0001f43a") if x == 12

scatter y x,msymbol(none) mlabel(emoji) mlabposition(0) mlabsize(huge)

graph export animals.svg, replace
shellout animals.svg


******************
* Stata 绘制国旗
******************
clear
set obs 100
gen x = .
gen y = .
gen _ID = .

// 红色背景
replace x = -15 in 1
replace y =  10 in 1
replace x =  15 in 2
replace y =  10 in 2
replace x =  15 in 3
replace y = -10 in 3
replace x = -15 in 4
replace y = -10 in 4
replace x = -15 in 5
replace y =  10 in 5
replace _ID = 1 in 1/5

// 大五角星（中心点(-10, 5),半径为3）
forvalues i = 1/6{
    local theta = (`i' - 1) * 4 * _pi / 5
    local k = `i' + 6

    replace x = 3*sin(`theta') - 10 in `k'
    replace y = 3*cos(`theta') + 5  in `k'
}
replace _ID = 2 in 6/12

// 第一颗小五角星（中心点(-5, 8), 半径为1）
forvalues i = 1/6{
    local theta = (`i' - 1) * 4 * _pi / 5 - (_pi - atan(5/3))
    local k = `i' + 13

    replace x = sin(`theta') - 5 in `k'
    replace y = cos(`theta') + 8  in `k'
}
replace _ID = 3 in 13/19

// 第二颗小五角星（中心点(-3, 6), 半径为1）
forvalues i = 1/6{
    local theta = (`i' - 1) * 4 * _pi / 5 - (_pi - atan(7))
    local k = `i' + 20

    replace x = sin(`theta') - 3 in `k'
    replace y = cos(`theta') + 6  in `k'
}
replace _ID = 4 in 20/26

// 第三颗小五角星（中心点(-3, 3), 半径为1）
forvalues i = 1/6{
    local theta = (`i' - 1) * 4 * _pi / 5 - atan(7/2)
    local k = `i' + 27

    replace x = sin(`theta') - 3 in `k'
    replace y = cos(`theta') + 3  in `k'
}
replace _ID = 5 in 27/33

// 第四颗小五角星（中心点(-5, 1), 半径为1）
forvalues i = 1/6{
    local theta = (`i' - 1) * 4 * _pi / 5 - atan(5/4)
    local k = `i' + 34

    replace x = sin(`theta') - 5 in `k'
    replace y = cos(`theta') + 1  in `k'
}
replace _ID = 6 in 34/40

#delimit ;
    twoway (area y x if _ID==1, color(red))
           (area y x if _ID==2, color(yellow))
           (area y x if _ID==3, color(yellow))
           (area y x if _ID==4, color(yellow))
           (area y x if _ID==5, color(yellow))
           (area y x if _ID==6, color(yellow)),
    xsize(15) ysize(10)         // 设置图形尺寸
    xlabel(none) ylabel(none)   // 不显示轴标签
    xtitle("") ytitle("")       // 不显示轴名称
    legend(off) scheme(s1color) // 关闭图例
    ;
#delimit cr

// 使用cmiss()选项
#delimit ;
    twoway (area y x if _ID==1, cmiss(n) color(red))
           (area y x if _ID>=2, cmiss(n) color(yellow)),
        xsize(15) ysize(10) 
        xlabel(none) ylabel(none)
        xtitle("") ytitle("") 
        xscale(off) yscale(off) // 不显示坐标轴
        graphr(margin(zero))    // 图形区Margin为0
        plotr(margin(zero))     // 绘图区Margin为0
        legend(off) scheme(s1color)
    ;
#delimit cr


* 附：绘制草图
#delimit ;
    twoway (line y x,  cmiss(n) lcolor(black))
           (pci 5 -10 8 -5, lcolor(gray))
           (pci 5 -10 6 -3, lcolor(gray))
           (pci 5 -10 3 -3, lcolor(gray))
           (pci 5 -10 1 -5, lcolor(gray))
           (pcarrowi -10 0 10 0  (8)  "Y"
                     0 -15 0 15  (11) "X", 
                     headlabel lcolor(black)) // 绘制坐标轴
           (pcarrowi 7 -13 5 -10 (12) "(-10, 5)"
                     9 -3  8 -5  (3)  "(-5, 8)"
                     6 -1  6 -3  (3)  "(-3, 6)"
                     3 -1  3 -3  (3)  "(-3, 3)"
                     0 -3  1 -5  (3)  "(-5, 1)") // 添加五角星中心坐标
        ,
        xsize(15) ysize(10) xscale(off) yscale(off)
        xlabel(-15(1)15, grid) ylabel(-10(1)10, grid ang(0))
        xtitle("") ytitle("") legend(off)
    ;
#delimit cr

*******************
* Stata 绘制麻将
*******************
clear
set obs 4                    // 设置观察值
gen y = cond(_n>2, 1, 0)
gen x = cond(mod(_n, 2)==0, 1, 0)

forvalues i = 1/4{          // 麻将
	local s`i' = ""
	forvalues j = `=126966+`i'*10'/`=126976+`i'*10'{
	local s`i' = "`s`i''" + uchar(`j')
	}
}

local s5 = uchar(127019)*11 // 桌上的麻将
local s6 = uchar(9861)*3    // 骰子

#delimit ;                  // 画图
    scatter y x, xtitle("") ytitle("")
        t2title(`s1', size(vlarge) margin(medlarge)) 
        b2title(`s2', size(vlarge) margin(medlarge))
        l2title(`s3', size(vlarge) margin(medlarge)) 
        r2title(`s4', size(vlarge) margin(medlarge))
        text(0.05 0.50 "`s5'", size(medlarge))
        text(0.95 0.50 "`s5'", size(medlarge))
        text(0.50 0.05 "`s5'", size(medlarge) orient(vertical))
        text(0.50 0.95 "`s5'", size(medlarge) orient(vertical))
        text(0.55 0.50 "`s6'", size(huge))
        text(0.45 0.50 "`s6'", size(huge))
        scheme(s1mono) msize(vtiny)
        xlabel(none) ylabel(none)
        xsize(12) ysize(11)
        graphregion(margin(2 2 0 0))
    ;
#delimit cr