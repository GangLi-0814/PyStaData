global data_url "http://www.principlesofeconometrics.com/poe4/data/stata/"

use "$data_url/food.dta", clear
reg food_exp income
graph twoway (scatter food_exp income)(lfit food_exp income)

* 8.2 检测异方差

** 8.2.1 残差图
qui reg food_exp income
predict ehat, res
graph twoway scatter ehat income, yline(0)

// 残差大小和自变量关系
help lowess
gen abs_e = abs(ehat) // 使用abs作为局部加权值
twoway (scatter abs_e income) ///
(lowess abs_e income,lw(thick)) // 平滑散点图：lowess

** 8.2.2 拉格朗日乘数检验
/*
1.BP检验
2.White 检验
*/

* BP检验(Wooldridge 5ed, p.225)
use "$data_url/food.dta", clear
qui regress food_exp income
predict ehat, res
gen ehat2 = ehat^2
qui reg ehat2 income
dis "NR2 = " e(N)*e(r2)
dis "5% critical value = " invchi2tail(e(df_m),.05)
dis "p-value =" chi2tail(e(df_m),e(N)*e(r2))

* White 检验
quietly reg ehat2 income c.income#c.income
dis "NR2=" e(N)*e(r2)
dis "5% critical value = " invchi2tail(e(df_m),.05)
dis "p-value =" chi2tail(e(df_m),e(N)*e(r2))

qui reg food_exp income //陈强-Slides, 2015
estat hettest income, iid //  heteroskedasticity test
estat imtest, white

* 8.2.3 Goldfeld-Quandt 检验
use "$data_url/cps2", clear
/*
教育、经验和都市...工资回归模型
*/
reg wage educ exper metro
reg wage educ exper if metro == 0 //rural
scalar rmse_r = e(rmse)
scalar df_r = e(df_r)


reg wage educ exper if metro == 1 //metro
scalar rmse_m = e(rmse)
scalar df_m = e(df_r)

scalar GQ = rmse_m^2/rmse_r^2
scalar crit = invFtail(df_m, df_r, .05)
scalar pvalue = Ftail(df_m, df_r, GQ)
scalar list GQ pvalue crit

* 食品支出例子
use "$data_url/food.dta", clear
sum //N=40
sort income
reg food_exp income in 1/20
scalar s_small = e(rmse)^2
scalar df_small = e(df_r)

reg food_exp income in 21/40
scalar s_large = e(rmse)^2
scalar df_large = e(df_r)

scalar GQ = s_large/s_small
scalar crit = invFtail(df_large, df_small, .05)
scalar pvalue = Ftail(df_large, df_small, GQ)
scalar list GQ pvalue crit

* 8.3 异方差一致标准误差

* 8.4 广义最小二乘估计

* 8.4.1 分组 GLS
* 8.4.2 FGLS

* 8.5 LPM 的异方差





 
