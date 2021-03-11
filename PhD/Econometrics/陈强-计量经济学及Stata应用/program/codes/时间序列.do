
use gdp_china, clear
/*
1978-2013 年，中国国内生产 总值(1978 年不变价格，亿元)
*/

tsset year

* 时间序列的自相关
tsline y, xlabel(1980(10)2010)
/*
GDP存在指数增长趋势，通常的处理方法是将GDP取对数，把指数趋势变为线性趋势。
*/

gen lny = log(y)
tsline lny, xlabel(1980(10)2010)

gen dlny = d.lny //一阶差分
tsline dlny, xlabel(1980(10)2010)

/*
\Delta y_y = ln(y_t) - ln(y_{t-1}) 
= ln(y_t\y_{t-1}) 
= ln((y_{t+1} + \Delta y_t)/y_{t-1})
= ln(1+\Delta y_t\y_{t-1}) \approx \frac{\Delta y_t}{y_{t-1}}
*/

gen g = (y-l.y)/l.y
tsline dlny g, xlabel(1980(10)2010)


corrgram dlny
ac dlny, lags(20) //自相关图

* 一阶自相关
reg dlny l.dlny if year < 2013, r
predict dlny1
list dlny1 if year == 2013
dis exp(lny[35]+dlny1[36])
dis y[36]
dis y[36]-exp(lny[35]+dlny1[36])

* 高阶自回归
/* 序贯 t 规则
信息准则确定滞后阶数 p
*/
qui reg dlny l.dlny if year<2013, r
estat ic 
reg dlny l(1/2).dlny if year<2013, r
estat ic
reg dlny l(1/3).dlny if year<2013, r


qui reg dlny l(1/2).dlny if year<2013, r 
predict dlny2
dis exp(lny[35]+dlny2[36])
dis y[36]-exp(lny[35]+dlny2[36])

* 自回归分布滞后模型
use border.dta, replace
tsset decade

reg border l(1/2).border l.bought diff age rival wall unified, r
dis -.6333046/(1-1.518284+.5586965)



