
* 标准差
/*
标准差：
标准差是一组数值自平均值分散开来的程度的一种测量观念。
一个较大的标准差，代表大部分的数值和其平均值之间差异较大；
一个较小的标准差，代表这些数值较接近平均值

方差：s^2 = \frac{\sum_{i=1}^n (x_i - \bar x)^2}{n-1}
标准差 = sqrt(s^2)
*/

use "http://www.principlesofeconometrics.com/poe4/data/stata/food.dta", clear
sum income
ret list
scalar income_mean = r(mean)
gen dev_square = (income - income_mean)^2
egen sum_dev_square = total(dev_square)
dis " income 的方差为:" sum_dev_square/(r(N)-1)
dis " income 的标准差为:" sqrt(sum_dev_square/(r(N)-1))

* 估计量的标准误
view browse "https://www.ershicimi.com/p/98fc054e6a57b09c0f90fad050d90b3c"
/*
标准误：通过样本估计总体时，样本分布的标准差
标准误(standard error)，也叫抽样标准误，是样本统计量的标准差，
衡量的是抽样分布的离散度，对应的随机变量是样本统计量。
比如样本均值的标准误(standard error of sample mean)，
衡量的就是样本均值的离散度。

估计误差的平方根 就是估计系数的标准误

se(b_1) = \sqrt(ESS/df)
ESS = \sum_{i=1}^n (\hat x_i - x_i)^2

se(b_1) = \sqrt{var(b_1)}
se(b_2) = \sqrt{var(b_2)}
*/

use "http://www.principlesofeconometrics.com/poe4/data/stata/food.dta", clear
reg food_exp income
estat vce //方差和协方差矩阵
dis "income的标准误为：" sqrt(4.3817522) // 2.0932635


sysuse auto,clear



* Z 检验


* 均方误差（MSE）
