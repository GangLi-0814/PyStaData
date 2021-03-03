help datetime function
help datetime

/*
Stata 处理日期变量的方式
1. You begin with the datetime variables in your data however they are recorded, such as 21nov2006
or 11/21/2006 or November 21, 2006, or 13:42:02.213 or 1:42 p.m. The original values are
usually best stored in string variables.
2. Using functions we will describe below, you translate the original into the integers that Stata
understands and store those values in a new variable.
3. You specify the appropriate display format for the new variable so that, rather than displaying
as the integer values that they are, they display in a way you can read them such as 21nov2006
or 11/21/2006 or November 21, 2006, or 13:42:02.213 or 1:42 p.m.

1.您从数据中的datetime变量开始，但是已记录它们，例如21nov2006
或11/21/2006或2006年11月21日，或13：42：02.213或下午1:42原始值是
通常最好存储在字符串变量中。

2.使用下面将要描述的函数，您可以将原始数据转换为Stata的整数
理解这些值并将其存储在新变量中。

3.您为新变量指定适当的显示格式，以便而不是显示
作为它们的整数值，它们以一种您可以阅读的方式显示，例如21nov2006
或11/21/2006或2006年11月21日，或13：42：02.213或下午1:42
*/

* 生成示例数据
clear
set obs 30
gen date = ""
forvalues i = 1/30{
	dis `i'
	if `i' < 10{
		replace date = "1960-01-" + "0" + "`i'" in `i'
	}
	else{
		replace date = "1960-01-" + "`i'" in `i'
	}
}

* 转换为日期格式
generate date1 = date(date, "YMD")
gen date2 = date1
format date2 %td

/*
| 格式  |   基准    |     单位     |       备注        | 转换函数                   |
| :---: | :-------: | :----------: | :---------------: | -------------------------- |
| `%tc` | 01jan1960 | milliseconds |     忽略闰秒      | `clock(string, mask)`      |
| `%tC` | 01jan1960 | milliseconds |      算闰秒       | `Clock(string,mask)`       |
| `%td` | 01jan1960 |     days     |   日历日期格式    | `date(string,mask)`        |
| `%tw` |  1960-w1  |    weeks     | 第52周可能超过7天 | `weekly(string, mask)`     |
| `%tm` |  jan1960  |    months    |    日历月格式     | `monthly(string,mask)`     |
| `%tq` |  1960-q1  |   quarters   |     财务季度      | `quarterly(string, mask)`  |
| `%th` |  1960-h1  |  half-years  | 1个半年= 2个季度  | `halfyearly(string, mask)` |
| `%ty` |   0 A.D   |     year     |  1960年是1960年   | `yearly(string,mask)`      |
| `%tb` |     -     |     days     |    用户自定义     | -                          |
*/

* 日期和时间转换
gen date3 = cofd(date2)
format date3 %tc
gen date4 = dofc(date3)
format date4 %td

* 提取日期
/*
year(date) returns four-digit year; e.g., 1980, 2002
month(date) returns month; 1, 2, . . . , 12
day(date) returns day within month; 1, 2, . . . , 31
halfyear(date) returns the half of year; 1 or 2
quarter(date) returns quarter of year; 1, 2, 3, or 4
week(date) returns week of year; 1, 2, . . . , 52
dow(date) returns day of week; 0, 1, . . . , 6; 0 = Sunday
doy(date) returns day of year; 1, 2, . . . , 366
*/
clear
input str20 var1
"2021-01-01"
"2021-04-02"
"2021-07-01"
"2021-10-01"
end

generate date1 = date(var1, "YMD")
gen year = year(date1) // 年份
gen month = month(date1) //月份
gen quarter = quarter(date1) //季度
gen halfyear = halfyear(date1) //半年
gen doy = doy(date1) // 一年内第几天


* 筛选日期
* 生成示例数据
clear
set obs 30
gen date = ""
forvalues i = 1/30{
	dis `i'
	if `i' < 10{
		replace date = "1960-01-" + "0" + "`i'" in `i'
	}
	else{
		replace date = "1960-01-" + "`i'" in `i'
	}
}

generate date1 = date(date, "YMD")
format date1 %td

* 保留 1960-01-15 前
keep if date1 > date("1960-01-15","YMD")
