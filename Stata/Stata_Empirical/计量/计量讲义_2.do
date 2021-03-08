* ssc install regcheck, replace   
* ssc install aaplot, replace
* ssc install regfit, replace
* ssc install binscatter, replace
* ssc install reganat, replace
* ssc install partcorr, replace
* ssc install domin, replace
* ssc install moremata, replace
* ssc install grss, replace //并行显示多图
* ssc install avplots, replace
* ssc install chowtest, replace
* ssc install chowreg, replace
* ssc install ttable, replace


*************
* 导论
*************

* 第一节 计量经济学的任务
* PRF 和 SRF：蒙特卡罗模拟
clear
set obs 30
set seed 10101
gen x = rnormal(3, 4)
gen e = rnormal(0, 9)
gen y = 1*x + e //Data Generation Process
reg y x
tw function PRF = 1+2*x, range(-5 15) || ///
scatter y x || lfit y x, lp(dash)


* 第二节 计量经济学建模的一般流程

* 第三节 数据的类型

******************
* 第一章 知识预备
******************

* 第一节 统计学基础

* 第二节 Stata入门

******************
* 第二章 线性回归模型
******************

* 第一节 模型的设定

* 基本形式（矩阵形式）

* 基本假定
sysuse auto,clear
qui reg pr wei mpg rep78
regcheck 
/*
regcheck命令可以快速检验6个线性回归的假设：
同方差；
不存在严重的多重共线性；
随机误差项服从正态分布；
正确设定模型；
选择了适当的函数形式；
没有离群值的影响。
*/

aaplot price weight  // 图示拟合情况
regfit, f(%4.2f) tvalue  // 模型的公式表示

*-散点图示(考虑控制变量的影响)
help binscatter
binscatter price wei
binscatter price wei, controls(length i.foreign)  //增加控制变量

	
* 第二节 模型的估计

* OLS 推导
  
* 偏回归系数（Frisch-Waugh 定理）

/*分为两步：
1.将该解释变量对所有其他解释变量做回归，得到残差
2.用y对上一步的残差做回归
因为，第一步得到的残差是x1与其他变量不相关的部分，用这部分去做回归，得到的斜率就
是排除了其他解释变量的影响，该解释变量对被解释变量的影响。
*/

*example：
sysuse auto,clear
reg wei len mpg
predict u_hat1,re
reg price u_hat1
*系数为4.364

sysuse auto,clear
reg pr wei len mpg
*系数也为4.364

sysuse auto, clear
rename (price length weight) (Y X1 X2)
reg Y X1 X2
reg Y X2
predict ey2, res
reg X1 X2
predict e12, res
reg ey2 e12
twoway (scatter ey2 e12)(lfit ey2 e12)
reg Y X1 X2
avplot X1 // 控制 X2 后，观察 Y 与 X1 的关系

* 绘制所有变量的部分回归图
sysuse "auto.dta", clear
reg price weight mpg turn foreign
avplots 	

* 拟合优度
* TSS、ESS、RSS的计算以及相互关系（总离差平方和的分解）

*-{Brooks, 2008}, pp.32, Fig 2.3
preserve

clear
input x y  x1  y1  x2  y2  x3  y3  x4   y4  x5  y5  xf yf
	1 3  1   2   2   4   3   3   4    8   5   8   1  2
	2 6  1   3   2   6   3   6   4    9   5   10  2  4
	3 3  0.7 3   1.4 6   3.8 6   3.75 9   5.5 10  3  6
	4 9  0.7 2   1.4 4   3.8 3   3.75 8   5.5 8   4  8
	5 8  1   2   2   4   3   3   4    8   5   8   5  10
end

*-graph set window fontface default
graph set window fontface "Times New Roman" 
global lp "lp(solid) lc(black*0.8)" //线型设定
#delimit ;
twoway (scatter y x,m(X) msize(*1.8)) (function y=2*x, range(0 6) lp(solid)) 
	 (line y1 x1,$lp) (line y2 x2,$lp) 
	 (line y3 x3,$lp) (line y4 x4,$lp) (line y5 x5,$lp) 
	 (scatter yf xf,m(D)), 
	 xlabel(0(1)7 , nogrid labsize(*1.2)) 
	 ylabel(0(2)14, nogrid labsize(*1.2) angle(0))
	 xtitle("x",size(*1.2)) ytitle("y",size(*1.2))
	 scheme(s2mono) legend(off) xsize(4) ysize(2.4)
	 text(4.3 2.74 "{it:e}{sub:{it:i}} {&larr}",size(*1.3) color(red))
	 text(6.9 3.04 "{it:y}{sub:{it:i_fit}}",size(*1.3) color(green*1.2))
	 text(2.4 3.00 "{it:y}{sub:{it:i}}",size(*1.3) color(blue*1.2))
	 ;
#delimit cr		  

restore 

*手工计算 R2
sysuse auto,clear
qui regress price weight length mpg rep78
predict y_hat
predict e,re
egen y_bar = mean(price)        
egen ess = total((y_hat - y_bar)^2)
egen rss = total((price - y_hat)^2)
gen tss = ess + rss
gen r2 = ess/tss
format tss ess rss %9.0f r2
list tss ess rss r2 in 1

*查看报告结果验证
sysuse auto,clear
regress price weight length mpg rep78

/* x 越多真的 r2 越大吗？
* 演示：在一个模型中逐步加入解释变量，并储存相应的 r2 。
当解释变量累计增加到200个时，R2的变化。
*/
clear
set obs 500
gen id = _n
gen r2 = .
gen y = int(10*runiform()) //生成被解释变量
forvalues i = 1/200 {
	gen x`i' = 10*runiform() //生成解释变量
}
forvalues c = 1/200{ //逐步加入解释变量
    if `c' == 1 {
        reg y x1
	}
    else{
        reg y x1-x`c'
    }
  replace  r2 = `e(r2)' in `c'
}
scatter r2 id if id < 200,xlabel(0(100)200) ///
ytitle("拟合系数") xtitle("解释变量个数")

* 自由度
/*
定义：自由度是指当以样本的统计量来估计总体的参数时，
样本中独立或能自由变化的数据的个数，
称为该统计量的自由度。通常为 df = n-k 。

例:若存在两个变量 a,b ，而a+b = 6 那么自由度为1 。
因为其实只有a才能真正的自由变化，b 会被 a 选值的不同所限制（b = 6 - a）。
*/

/*
k：解释变量个数

TSS：n-1
ESS: k
RSS:n-(k+1)

TSS 自由度： 
TSS = \sum (Y_i - \bar Y)^2
$n$ 已知，$\bar y$ 已知，如果 $n-1$ 个$Y_i$ 已知，那么最后一个也就不能随便变化了。
因此只有 $n-1$ 个 $Y_i - \bar Y$ 是可变化的，
最后一个则可以通过平均值与样本量确切的计算出来。所以 TSS 的自由度为 n-1 。 

ESS 自由度：
ESS = (\hat Y_i - \hat Y)^2
对于每个 \hat Y_i 可以有 k+1 个 \hat \beta。
但是 $\bar Y$ 平均值已知，正如一元线性回归中所看到的，
\bar Y = \beta_0 + \beta_1 \bar X ，这样又占据了一个自由度。
所以 ESS 的自由度是 k 。

RSS 自由度：
RSS = e_i^2
回忆正规方程组，给定 k+1 个方程，意味着 k+1 个残差固定，
所以对于残差平方和，自由度为 n-(k+1)
*/

* 方差分析

* 调整拟合优度
/*
adj_r2 = 1 - (RSS/df)/(TSS/df) 
= 1 - ((RSS/n-k-1)/(TSS/(n-1))
*/
sysuse auto, clear
reg pr wei len
dis  1- (414340116/(74-2-1))/(635065396/(74-1)) // adj_r2

* 非中心拟合优度

* 拟合优度对变量的分解
view browse "https://zhuanlan.zhihu.com/p/75459438"

* 残差
* 残差拟合图
sysuse auto,clear
qui reg pr wei len mpg rep78
predict y_hat
predict e,re
grss scatter e y_hat,yline(0)

*自动生成
sysuse auto,clear
qui reg pr wei len mpg rep78
grss rvfplot,yline(0)                //residual-versus-fitted plot

grss clear


* 第三节 估计量的统计性质及证明

线性
无偏性
有效性

* 随机扰动项的估计


* 第四节 模型的检验

* 回归系数的检验
/* 系数的标准误与 t 值
OLS 的估计系数是一个随机变量, SE 衡量了其不确定程度;
异方差稳健标准误
*/
sysuse auto, clear
reg pr wei len

/*
$H_0: \beta_j = 0 \quad H_1: \beta_j \neq 0$
$t = \frac{\hat \beta_j - \beta_j}{Se(\hat \beta_j)} ~ t(n-k)$
若 $|t| > t_{\alpha/2}(n-k)$，则拒绝原假设，认为解释变量对被解释变量的作用是显著的。

t-2 法则（经验法则）
*/
dis 4.699065/1.122339 // t 检验
ttable 2

regress price weight
dis "t-value = " %4.2f _b[weight]/_se[weight]  // t = b/se
twoway function y=tden(72, x),   ///
	   rang(-6 6) xline(5.2, lp(dash) lc(red))

	
* 回归方程的显著性检验
/*
F = (ESS/k)/(RSS/(n-k-1)) ~ F(k, n-k-1)
*/
sysuse auto, clear
reg pr wei len
dis (220725280/2)/(414340116/71) // F 检验



第五节 预测

点预测

区间预测



* 第六节 线性回归模型的拓展

* 过原点回归
/* 
拟合系数失效
非中心 r2 = \frac{\sum \hat y_i^2}{\sum_{i=1}^n y_i^2}
如果回归模型无常数项，则平方和分解公式不成立，不宜使用r2来度量拟合优度。
*/

sysuse auto, clear
reg pr wei len, noconstant
dis 2.9996e+09/3.4478e+09


* 标准化变量回归
/*
标准化 = （原值-均值）/标准差
由于标准化后的变量均值为零，所以对应的回归模型中必然无截距项
标准化回归的系数被称为 beta 系数
在标准化回归中，系数的大小度量了解释变量的相对解释力，
如果一个标准化解释变量的系数比模型中另一个标准化解释变量的系数大，
那么前者就比后者更多的解释 Y_i 的变动。
*/
sysuse auto, clear
reg pr wei len, beta


* 手动计算 beta 系数
sysuse auto, clear
foreach v in "price" "weight" "length"{
	qui sum `v'
	scalar `v'_mean = r(mean)
	scalar `v'_se = r(sd)
	gen `v'_standard = (`v' - `v'_mean)/`v'_se
}
reg price_standard weight_standard length_standard, noconstant

* 传统模型系数与标准化模型系数
/*
传统模型系数与标准化模型系数之间的关系：
\beta_j^* = \beta_j(\frac{S_{X_j}}{S_Y})
\beta_j 为第 j 个解释变量的系数；
S_x_j 为第 j 个解释变量的样本标准差；
S_Y 为被解释变量的标准差。
*/
sysuse auto, clear
qui sum price
scalar price_se = r(sd)
foreach v in "weight" "length"{
	qui sum `v'
	scalar `v'_se = r(sd)
	gen `v'_temp = `v'_se/price_se
	qui reg pr weight length
	qui ereturn list
	gen `v'_standard2 = _b[`v']*`v'_temp
}
dis weight_standard2 
dis length_standard


* 双对数模型
/*
取对数：1.降低原始数据可能存在异方差的影响；2.解释为弹性。
log-lin：x 每变化一个单位，y 平均变化 \beta_1 个百分比；
lon-log：x 每变化一个单位，y 平均变化 0.01*\beta_1 个百分比
*/

* 比较残差：消除异方差
sysuse auto.dta,clear
reg pr wei
predict e,re
grss rvfplot

gen lpr  = ln(price) 
gen lwei = ln(wei)
reg lpr lwei
predict e2,re
grss rvfplot

twoway (scatter e wei,yaxis(1) xaxis(1))   ///
       (scatter e2 lwei,yaxis(2) xaxis(2)) ///
	   ,yline(0)
grss clear


* 多次项回归
*多项式模型
/*多项式的取值越高，对原函数关系逼近的越好，但是在实际建模过程中，K的取值
却不宜太大，一方面是没有必要，另一方面，k的取值过大，会带来模型自由度的损失。*/

*示例：观察他们的R^2有变化吗？
sysuse auto.dta,clear
gen wei2 = weig^2 
gen wei3 = weig^3
gen wei4 = weig^4
reg pr weig wei2              //二次项回归
reg pr weig wei2 wei3         //三次项回归
reg pr weig wei2 wei3 wei4    //四次项回归

*示例：提取五次项回归的r2进行对比
sysuse auto,clear
forvalues i = 1/5 {
  gen weight`i' = weight^`i'
  if `i' == 1 {
    reg pr weight
	ereturn list
	gen r2_`i' = `e(r2)'
	}
  else{
  reg pr weight - weight`i'
  ereturn list
  gen r2_`i' = `e(r2)'
  }
}
list r2_1 r2_2 r2_3 r2_4 r2_5 in 1


* 虚拟变量与 ANOVA 模型
/*
方差分析模型主要是用于评价定性因素对被解释变量的量化影响。
单因素方差分析、多因素方差分析
协方差分析
*/
help anova

* 邹至庄检验
/*
chow检验（Chow test）也叫邹氏检验、邹至庄检验，它是由邹至庄提出的，
用于判断结构在预先给定的时点是否发生了变化的一种方法。
它把时间序列数据分成两部分，其分界点就是检验是否已发生结构变化的检验时点。
然后利用F检验来检验由前一部分n个数据求得的参数与由后一部分m个数据求得的参数是否相等，
由此判断结构是否发生了变化。

检验方法：
选定时间段分别回归，得到两个子回归的 RSS_1 和 RSS_2，
记 RSS_{UR} = RSS_1 + RSS_2，称为无约束回归模型的残差平方和
再对所有的数据回归，得到 RSS_{R}，称为有约束回归模型的残差平方和
构造F 检验：
F = [(RSS_U - RSS_{UR})/k]/(RSS_{UR}/(n1+n2-2k))

*/
help chowreg
help chowtest

sysuse auto,clear
chowtest price wei mpg, group(foreign)
chowtest price wei mpg, group(foreign) restrict(headroom)
chowtest price wei mpg, group(foreign) het


***********************
* 第三章 违背经典假设的模型
***********************


第一节 多重共线性

概念

后果

检测

补救

- 增加样本
- 剔除变量
- 岭回归

第二节 异方差

概念

后果

检测

补救

第三节 自相关

概念

后果

检测

补救



**************************
* 第四章 模型的设定和诊断检验
**************************

模型选择的准则

设定误差的类型

- 遗漏重要解释变量——不足拟合
- 包含无关变量——过度拟合
- 错误的函数形式
- 测量误差

模型设定误差的后果

设定误差的检验



第五章 二值模型

引言

线性概率模型

Logit 模型

Probit 模型

三类模型的比较



第六章 时间序列模型



第七章 面板数据模型


第八章 RCT



参考资料：

古扎拉蒂《计量经济学基础》（第 5 版）

伍德里奇《计量经济学导论》

陈强《计量经济学及 Stata 应用》

陈强《高级计量经济学及 Stata 应用》

安格里斯特《基本无害的计量经济学》

安格里斯特《功夫计量》

赵西亮《基本有用的计量经济学》

