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
** 9.9.1 Durbin-Waston 检验
** 9.9.2 Prais-Winsten FGLS
