
global data_url "http://www.principlesofeconometrics.com/poe4/data/stata/"

view browse "http://www.principlesofeconometrics.com/poe4/poe4stata.htm"

*********
* 弹性
*********
/*
$$
e = (\Delta Y/Y)/(\Delta X/X) 
= \frac{\Delta y}{\Delta X} \cdot \frac{X}{Y} 
$$

导数形式：
$$
e = \frac{dy/y}{dx/x} = \frac{dy}{dx} \cdot \frac{x}{y} = \beta_2 \frac{x}{y}
$$
*/

* 示例：需求收入弹性
use "http://www.principlesofeconometrics.com/poe4/data/stata/food.dta", clear
/*
每周食品支出与每周收入的关系
*/
* 手动计算
sum income
scalar x_mean = r(mean)
sum food_exp
scalar y_mean = r(mean)
reg food_exp income
dis  "弹性：" _b[income] * (x_mean/y_mean) //0.71

* margins 命令
reg food_exp income
margins, eyex(income) atmeans // 条件边际效应(conditional marginal effects)

* 平均边际效应
/*
平均边际效应（Average marginal effects）：求出每个值的弹性，然后求所有观测值的平均弹性。
$$
AME = \hat e = \frac{1}{N} \sum_{i=1}^N b_2 (\frac{x_i}{y_i})
$$
*/
* 手动计算
reg food_exp income
predict yhat, xb
gen elas = _b[income]*(income/yhat)
sum elas

* 命令
margins, eyex(income)


****************
* 估计误差项方差
****************
/*
\hat \sigma^2 = \frac{RSS}{df} = \frac{\sum e_i^2}{N-k-1} 
*/
reg food_exp income
eret list
dis "MS Residual = " `e(rss)'/(`e(N)'-`e(df_m)'-1) // MS Residual

* 估计方差和协方差
/*
\hat var(b_1) 
\hat var(b_2)
\hat cov(b_1,b_2)

估计误差的平方根就是估计系数的标准误差
se(b_1) = \sqrt{var(b_1)}
se(b_2) = \sqrt{var(b_2)}

*/
estat vce

* 估计非线性关系

* 1. 二次项
use "http://www.principlesofeconometrics.com/poe4/data/stata/br.dta", clear

/*
斜率
预测值
因子变量
*/

reg price c.sqft#c.sqft
margins, dydx(*) at(sqft=(2000 4000 6000)) //斜率
margins, eyex(*) at(sqft=(2000 4000 6000)) //弹性

margins, eyex(*) //平均弹性
reg, coeflegend

* 2. 对数线性模型

********************
* 区间估计与假设检验
********************

* 区间估计
** t 分布的临界值
* df=38 在 5% 水平的临界值
scalar tc975 = invttail(38, 0.025)
di "t crirical value 97.5 percentile = " tc975
di "t(30) 95th percentile = " invttail(30, 0.05)

* 绘图演示
clear

* specify critcal values as globals
global t025=invttail(38,0.975)
global t975=invttail(38,0.025)

* draw the shaded areas, then draw the overall curve
twoway (function y=tden(38,x), range(-5 $t025) ///
                   color(ltblue) recast(area)) ///
       (function y=tden(38,x), range($t975 5)  ///
	               color(ltblue) recast(area)) ///
       (function y=tden(38,x), range(-5 5)),   ///
       legend(off) plotregion(margin(zero))    ///
	             ytitle("f(t)") xtitle("t")    ///
	   text(0 -2.024 "-2.024", place(s))       ///
	   text(0 2.024 "2.024", place(s))         ///
	   text(0 4.8773781 "4.87", place(s)) ///
	   title("Two-tail rejection region" "t(38), alpha=0.05")

	   
* ssc install ttest, replace
ttable 38


** 区间估计
/*
\hat \beta_j + c \cdot se(\hat \beta_j)
\hat \beta_j - c \cdot se(\hat \beta_j)
其中：
一个 95% 的置信区间的 c 为第 97.5 个百分位数
*/
use "http://www.principlesofeconometrics.com/poe4/data/stata/food.dta", clear
reg food_exp income
scalar ub2 = _b[income] + tc975*_se[income]
scalar lb2 = _b[income] - tc975*_se[income]
di "beta_2 95% interval estimate is [" lb2 ", " ub2 "]"



* 假设检验
/*
invttail 命令对 t 分布的右侧(upper-tail)分布有效，
与左侧的临界值(lower-tail)可能会混淆。
t 分布图形是对称的，在百分比为 90，95，97.5 和 99 上为正数，
百分比为 1， 2.5， 5 和 10 为负数。
*/
** 右侧显著性检验
scalar tstat0 = _b[income]/_se[income]
di "t statistic for H0: beta_2 = 0 = " tstat0
di "t(38) 95th percentile = " invttail(38,0.05)

lincom 5*income - 3*_cons - 1 //线性组合假设检验

** 经济假设的右侧检验
/*
H_0: \beta_2 <= 5.5, H_1: \beta > 5.5
检验统计量和 0.01 右侧临界值
*/
scalar tstat1 = (_b[income] - 5.5)/_se[income]
di "t-statistic for H_0: \beta_2 = 5.5 is" tstat1
di "t(38) 99th percentile =" invttail(38, 0.01)

lincom income -5.5

** 经济假设的右侧检验
/*
H_0: \beta_2 >= 15, H_1: \beta < 15
检验统计量和 0.05 右侧临界值
*/
scalar tstat2 = (_b[income] - 15)/_se[income]
di "t-statistic for H_0: \beta_2 = 15 is" tstat2
di "t(38) 5th percentile =" invttail(38, 0.95)

lincom income -15

** 经济假设的双侧检验
/*
H_0: \beta_2 = 7.5, H_1: \beta_2 \neq 7.5
对于一个显著性的水平为 0.05 的检验，t 分布临界值为 2。5% 和 97.5%
*/
scalar tstat3 = (_b[income] - 7.5)/_se[income]
di "t-statistic for H_0: \beta_2 = 7.5 is" tstat3
di "t(38) 97.5th percentile =" invttail(38, 0.025)
di "t(38) 2.5th percentile =" invttail(38, 0.975)

lincom income -7.5


* p 值
/*
称原假设可被拒绝的最小显著性水平为此假设检验问题的 p 值。
- 如果 H_1: \beta_k > c, p = t 右侧的概率；
若 p <= \alpha ,则拒绝 H_0 ，若 p > \alpha 则不能拒绝H_0 。
*/

help ttail
/* ttail(n,t) // n 为自由度，t 为t统计量的值
return the reverse cumulative (upper-tail) Student's distribution; 
it returns the probability T > t.
*/

** 右侧检验的 p 值
scalar tstat1 = (_b[income] - 5.5)/_se[income]
di "p-value for right-tail test h_0: beat_2 = 5.5 is" ttail(38, tstat1)

** 左侧检验的 p 值
scalar tstat2 = (_b[income] - 15)/_se[income]
di "p-value for left-tail test h_0: beat_2 = 15 is" 1- ttail(38, tstat2)

** 双侧检验的 p 值
scalar tstat3 = (_b[income] - 7.5)/_se[income]
scalar phalf = ttail(38,abs(tstat3))
scalar p3 = 2*phalf
di "p-value for two-tail test h_0: beat_2 = 7.5 is" p3

di "p-value for two-tail test h_0: beat_2 = 7.5 is" 2*ttail(38, abs(tstat3))

lincom income-15


* 检验并估计参数的线性组合
/*
H_0 : c_1 \beta_1 + c_2 \beta_2 = c_0
=> t = \frac{(c_1b_1+c_2b_2)-c_0}{se(c_1 \beta_1 + c_2 \beta_2)}
*/

estat vce
lincom _cons + income*20 // 假设 c_1 = 1, c_2 = 20 => 20*income + _cons = 0
lincom _cons + income*20 - 250  // 假设 c_0 = 250, c_1 = 1, c_2 = 20

* 图形
help tden(n,t) //概率密度函数值
clear

* specify critcal values as globals
global t025=invttail(38,0.975)
global t975=invttail(38,0.025)

* draw the shaded areas, then draw the overall curve
twoway (function y=tden(38,x), range(-5 $t025) ///
                   color(ltblue) recast(area)) ///
       (function y=tden(38,x), range($t975 5)  ///
	               color(ltblue) recast(area)) ///
       (function y=tden(38,x), range(-5 5)),   ///
       legend(off) plotregion(margin(zero))    ///
	             ytitle("f(t)") xtitle("t")    ///
	   text(0 -2.024 "-2.024", place(s))       ///
	   text(0 2.024 "2.024", place(s))         ///
	   title("Two-tail rejection region" "t(38), alpha=0.05")

* 右侧检验拒绝域
twoway (function y=tden(38,x), range(1.686 5) ///
                   color(ltblue) recast(area)) ///
       (function y=tden(38,x), range(-5 5)), ///
       legend(off) plotregion(margin(zero)) ///
	              ytitle("f(t)") xtitle("t") ///
	   text(0 1.686 "1.686", place(s)) ///
	   title("Right-tail rejection region" "t(38), alpha=0.05")

	  	   
*蒙特卡洛实验模拟
* set up
clear all

* define global variables
global numobs 40  					     
global beta1 100					
global beta2 10						
global sigma 50

* set random number seed
set seed 1234567

* generate sample of data
set obs $numobs
gen x = 10
replace x = 20 if _n > $numobs/2
gen y = $beta1 + $beta2*x + rnormal(0,$sigma)

* regression
quietly regress y x

* test h0: beta2 = 10
scalar tstat = (_b[x]-$beta2)/_se[x]
di "ttest of ho b2 = 10 " tstat

* program to generate data and to examine
* 	performance of interval estimator and
*	hypothesis test  	
program chap03sim, rclass
    version 11.1 
    drop _all
    set obs $numobs
    gen x = 10
	replace x = 20 if _n > $numobs/2
    gen ey = $beta1 + $beta2*x
	gen e = rnormal(0, $sigma)
	gen y = ey + e
	regress y x
	scalar tc975 = invttail($numobs-2,0.025)

	* calculating 95% interval estimate
	return scalar b2 = _b[x]
	return scalar se2 = _se[x]
	return scalar ub = _b[x] + tc975*_se[x]
    return scalar lb = _b[x] - tc975*_se[x]
	
	* calculating t-statistic
    return scalar tstat = (_b[x] - $beta2)/_se[x]
end

* display 95% interval for test size with different number 
*	of monte carlo samples 

di "lower bound with 10000 replications is " 0.05 - 1.96*sqrt(0.05*0.95/10000)
di "upper bound with 10000 replications is " 0.05 + 1.96*sqrt(0.05*0.95/10000)
di "lower bound with 1000 replications is " 0.05 - 1.96*sqrt(0.05*0.95/1000)
di "upper bound with 1000 replications is " 0.05 + 1.96*sqrt(0.05*0.95/1000)

* simulate command
simulate b2r = r(b2) se2r = r(se2) ubr = r(ub) lbr=r(lb) ///
	tstatr=r(tstat) , reps(10000) nodots nolegend ///
	seed(1234567): chap03sim

* display experiment parameters		 
di " Simulation parameters"	
di " beta1 = " $beta1
di " beta2 = " $beta2
di " N = " $numobs	 
di " sigma^2 = " $sigma^2

* count intervals covering true beta2 = 10
gen cover = (lbr < $beta2) & ($beta2 < ubr)

* count rejections of true h0: beta2 = 10
gen reject = (tstatr > invttail($numobs-2,0.05))

* examine some values
list b2r se2r tstatr reject lbr ubr cover in 101/120, table

* summarize coverage and rejection
summarize cover reject

*****************************
* 9. 时间序列数据回归：平稳变量
*****************************

* 9.1.1 定义时间序列
help dates and times
clear
set obs 100
gen date = tq(1961q1) + _n-1 // tw(), tm(), ty()
format %tq date
tset date

use "$data_url/okun", clear // 奥肯定律
/*
1985q2-2009q3, GDP & unemployment
*/
gen date = tq(1985q2) + _n -1
format %tq date 
tsset date

* 9.1.2 时间序列图
label var u "% unemployed"
label var g "% GDP growth"
tsline u g, lp(solid dash)

* 9.1.3 滞后和差分运算符
/*
L.   //lag(x_{t-1})
L2.  //2-period lag(x_{t-2})
D.   // difference(x_t - x_{t-1})
D2.  // difference of difference (x_t - 2x_{t-1}+x_{t-2})
F.  //前导运算符
S. // 季节差分运算符
*/

list date u L.u D.u g L1.g L2.g L3.g in 1/5
list date u L.u D.u g L1.g L2.g L3.g in 96/98

* 使用数列组合简写
list date L(0/1).u D.u L(0/3).g in 1/5
list date L(0/1).u D.u L(0/3).g in 96/98


* 9.2 有限分布滞后模型
/*
U_t - U_{t-1} = - \gamma (G_t - G_N)
DU_t = \alpha + \beta_0G + e_t
*/
tsline D.u g
reg D.u L(0/3).g
reg D.u L(0/2).g

* 9.3 序列相关
/*
回归模型的误差彼此相关
检验：残差自相关检验
*/

sum g
scatter g L.g, xline(`r(mean)') yline(`r(mean)')

ac g, lags(12) generate(ac_g) //计算样本的自相关值, Bartlett 法
list ac_g in 1/12

gen z = sqrt(e(N)) * ac_g //置信区间：$sqrt(T)r_k^{\alpha} ~ N(0,1)$
list ac_g z in 1/12


use "$data_url/phillips_aus", clear //菲尔普斯曲线
/*
1987q1: inf, unemployment
inf_{t} = \beta_1 + \beta_2 DU_t + e_t
*/
gen date = tq(1987q1) + _n - 1
format %tq date
tsset date
grss tsline inf
grss tsline D.u
grss clear
reg inf D.u
predict ehat, res
ac ehat, lags(12) generate(rk) //残差自相关图
list rk in 1/5

corrgram ehat, lags(5) //自相关函数的表
ret list
dis "rho1 = " r(ac1) "rho2 = " r(ac2) "rho3 = " r(ac3)

* 9.4 序列相关的其他检验

* 9.5 序列相关误差估计
** 9.5.1 最小二乘法和 HAC 的标准误差
** 9.5.2 非线性的最小二乘法

* 9.6 自回归分布滞后模型（ARDL）
** 9.6.1 菲利普曲线
** 9.6.2 奥肯定律
** 9.6.3 自回归模型

* 9.7 预测
** 9.7.1 用 AR 模型预测
** 9.7.2 指数平滑法

* 9.8 乘数分析

* 9.9 附录
** 9.9.1 Durbin-Waston 检验并估计参数的线性组合





















