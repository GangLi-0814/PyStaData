* ssc install ttable, replace
* ssc install grss, replace
* 快捷地计算分组回归统计量的三种方式：runby 、asreg、statsby
* ssc install chowtest, replace
* ssc install chowreg, replace
* ssc install avciplot, replace

/*
模型设定
* 模型的改写
PRF SRF
矩阵形式：Y = X \hat \beta + e
* 基本假定


模型的估计
* 最小二乘
** 推导
** 偏回归系数


* 拟合优度

** 拟合优度的计算
** 平方和分解公式的证明
** 调整拟合优度

*** 自由度
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

** F 检验

*** 方差分析
方差分析(analysis of variance)，简写为ANOVA，
指的是利用对多个样本的方差的分析，得出总体均值是否相等的判定。
当回归模型中包含的解释变量都是虚拟变量时，这种模型被称为方差分析模型。


* 估计量的统计性质
线性
无偏性
有效性
* 随机扰动方差（$\hat \sigma^2$）的估计

$$
\hat \sigma^2 = \frac{\\sum e_i^2}{n-k}
$$

模型的检验
* 回归系数的显著性
t 检验
* 回归方程的显著性检验
 F 检验
F = (ESS/k)/(RSS/(n-k-1)) ~ F(k, n-k-1)


预测
* 点预测
* 区间预测
*/




*※回归模型的基本假定:
/*1.解释变量x是确定的，不是随机变量；
2.零均值假定
3.同方差假定
4.随机误差项之间无自相关
5.随机扰动项ui与xi不相关
6.正态性假定 ui ~ normal（0，δ^2）*/

*regcheck 命令
* ssc install regcheck, replace   
sysuse auto,clear
qui reg pr wei mpg rep78
regcheck     //检验是否满足经典假设
/*
regcheck命令可以快速检验6个线性回归的假设：
同方差；
不存在严重的多重共线性；
随机误差项服从正态分布；
正确设定模型；
选择了适当的函数形式；
没有离群值的影响。

1) The assumption of homoskedasticity is examined using the Breusch-Pagan test (Gujarati, 2012, pp. 86-87). Since the Ho:homoskedastic residuals, p-value < 0.05 would show that there is a heterokedasticity problem in the model.5 }

2) The assumption of no severe multicollinearity is examined using VIF (Variance Inflation Factor)-values. A VIF value above 5.0 is used as a sign of severe multicollinearity in the model (Studenmund, 2006, p.271).

3) The assumption of normally-distributed residuals is examined using Shapiro-Wilk W test. Since the Ho:residuals are normmally distributed, p-value < 0.01 would indicate that residuals are not normally distributed. The reason why I propose 0.01 as a cutoff is that in almost every case, we reject the Ho at 0.05. Further, Shapiro-Wilk W test is, like any other, sensitive to large sample sizes. I still suggest that one additionnaly examines the residual plots.  

4) The assumption of correctly specified model is examined using the linktest (Stata Manual, pp. 1041-1044). A statistically significant _hatsq (p < 0.05) would show a specification problem.

5) The assumption of appropriate functional form is examined using Ramsey's regression specification error test (RESET) (Wooldridge, pp. 303-305). Since the Ho: appropriate functional form, p-value < 0.05 would indicate a functional form problem. 

6) Influence is based on both leverage and the extent to which the observation is an outlier. Cook's distance (D) is used to locate any influential observations. An observation with D > 1 would often be considered  an influential case and should thus be removed from the analysis (Pardoe, 2006, p. 171).
*/

*TSS、ESS、RSS的计算以及相互关系（总离差平方和的分解）
/*
************************************************************************
*一般的书写记号：                            *  在 Stata 中：              *             
*    y_bar = mean(y)                      *      MSS = ESS             * *                                                                      *
*    ESS = total(y_hat - y_bar)^2         *      RSS = RSS             *
*    RSS = total(y - y_hat)^2             *                            *
*    TSS = ESS + RSS = total(y - y_bar)^2 *                            *
*	 R^2 = ESS/TSS = 1 - RSS/TSS          *                            *           
************************************************************************	

*示例:                                                                        */																
*手工计算
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
*ereturn list
*两者结果是一样的吗？

*残差拟合图
*手工画
sysuse auto,clear
qui reg pr wei len mpg rep78
predict y_hat
predict e,re
*ssc install grss    //并行显示多图
grss scatter e y_hat,yline(0)

*自动生成
sysuse auto,clear
qui reg pr wei len mpg rep78
grss rvfplot,yline(0)                //residual-versus-fitted plot

grss clear

*最小二乘估计量的性质及证明
view browse "https://wenku.baidu.com/view/b2f3cd0af78a6529647d530f.html"
/*1.线性
2.无偏性
3.有效性*/

*随机误差项方差的估计
*δ_hat^2 = total((e)^2)/n-k-1    //k为未知参数个数

*※系数的显著性检验
/*在一元线性回归模型中，已知关于beta1的枢轴量
                      t =(beta1_hat - beta)/se(beta1_hat) ~ t(n-2)
假设检验的步骤：
1.提出假设。H1：beeta1 = 0 ；beta1 != 0
2.在原假设成立的条件下，利用样本数据计算t = beta1_hat/se(beta1_hat)
3.根据给定的显著性水平alpha，查表得临界值t_alpha/2(n- 2)
在stata中，可以利用display  invttail(df,p) ; ttail(df,t) = p
help Statistical functions
4.比较并判断：
若|t| > t_alpha/2 (n-2)，则拒绝H0；
若|t| <= t_alpha/2 (n-2)，则不拒绝H0。*/

*※※方程的显著性检验
/*在一元回归模型中，方程的显著性检验与系数的显著性检验没有本质区别。检验的原假设
相同，但是所用的统计量不同，在方程的显著性检验中使用F检验，当原假设成成立时，可
以证明：    
                 F= （ESS/df1）/（RSS/df2） ~ F（df1,df2）
df1是指回归平方和的自由度，df2是指残差平方和的自由度，在一元线性回归模型中，df1等
于1，df2等于n-2。在给定的显著性水平alpha，可以得到临界值Falpha(1,n-2),如果模型计算
F值大于临界值，则拒绝原假设。*/

*chapter04  多元线性回归模型
*----------------------------------

*为什么要多元回归？（伍德里奇教材）
/*1.控制更多的解释变量；
2.使零条件均值假定更容易满足；
3.使模型的形式更加灵活。*/

*多元线性回归模型的矩阵形式

*多元线性回归模型的基本假定
/*1.（零条件均值假定）随机扰动项的期望为0；
2.（无异方差）随机扰动项具有同方差和不相关的特征；
3.随机扰动项与解释变量不相关，cov（xi，ui） = 0；
4.观测期数要远大于解释变量个数；
5.解释变量之间不存在完全共线性；
6.随机扰动项服从正态分布，ui ~ normal（0，δ^2）*/

*多元回归模型参数的最小二乘估计结果推导

*偏回归系数：在控制其他解释变量的取值条件下，特定解释变量对被解释变量的影响。

*如何求得偏回归系数？（伍德里奇）  Frisch-Waugh定理
view browse "https://wenku.baidu.com/view/56790afcdb38376baf1ffc4ffe4733687e21fc1b?pu="
/*分为两步：
1.将该解释变量对所有其他解释变量做回归，得到残差
2.用y对上一步的残差做回归
因为，第一步得到的残差是x1与其他变量不相关的部分，用这部分去做回归，得到的斜率就
是排除了其他解释变量的影响，该解释变量对被解释变量的影响。*/

*example：
sysuse auto,clear
reg wei len mpg
predict u_hat1,re
reg price u_hat1
*系数为4.364

sysuse auto,clear
reg pr wei len mpg
*系数也为4.364

****************************

sysuse auto, clear

$$
price = \beta_0 + \beta_1 weight + \beta_2 length 
$$

reg pr wei len

* 1.自由度
/*
定义：自由度是指当以样本的统计量来估计总体的参数时，
样本中独立或能自由变化的数据的个数，
称为该统计量的自由度。通常为 df = n-k

例:若存在两个变量 a,b ，而a+b = 6 那么自由度为1。
因为其实只有a才能真正的自由变化，b 会被 a 选值的不同所限制（b = 6 - a）。
*/


/*
为什么使用adj_r2？
样本容量一定的情况下，增加解释变量使得自由度减少。
所以调整思路是：分子分母同时除以自由度，以剔除个数对r2的影响。

TSS：n-1
ESS: k
RSS:n-(k+1)

TSS 自由度： 
TSS = (Y_i - \bar Y)^2

$n$ 已知，$\bar y$ 已知，如果 $n-1$ 个$Y_i$ 已知，那么最后一个也就不能随便变化了。
因此只有 $n-1$ 个 $Y_i - \bar Y$ 是可变化的，
最后一个则可以通过平均值与样本量确切的计算出来。所以 TSS 的自由度为 n-1 。 

ESS 自由度：
ESS = (Y_i - \hat Y)^2
对于每个 \hat Y_i 可以有 k+1 个 \hat \beta。
但是 $\bar Y$ 平均值已知，正如一元线性回归中所看到的，
\bar Y = \beta_0 + \beta_1 \bar X ，这样又占据了一个自由度。
所以 ESS 的自由度是 k 。

RSS 自由度：
RSS = (Y_i - )
回忆正规方程组，给定 K+1 个方程，意味着 K+1 个残差固定，
所以对于残差平方和，自由度为 n-(k+1)

https://zhuanlan.zhihu.com/p/92200112
*/


* 2.拟合系数与调整拟合系数
/*
R^2 = ESS/TSS = 220725280/635065396 = .34756307
R^2 = 1 - RSS/TSS = 1- 414340116/635065396 = .34756307
*/

* 2.1 计算 r2

/* x 越多真的 r2 越大吗？
* 演示：在一个模型中逐步加入解释变量，并储存相应的 r2 。
当解释变量累计增加到200个时，R2的变化。
*/
clear
set obs 500
gen id = _n
gen r2 = .
* 生成被解释变量
gen y = int(10*runiform())

* 生成解释变量
forvalues i = 1/200 {
	gen x`i' = 10*runiform()
}
* 逐步加入解释变量
forvalues c = 1/200{
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


* 2.2 计算调整r2
/*
为什么使用adj_r2？
样本容量一定的情况下，增加解释变量使得自由度减少，所以调整思路是：分子分母同时除以自由度，以剔除个数对r2的影响。

TSS：n-1
ESS: k
RSS:n-(k+1)


TSS 自由度： 
TSS = (Y_i - \bar Y)^2

$n$ 已知，$\bar y$ 已知，如果 $n-1$ 个$Y_i$ 已知，那么最后一个也就不能随便变化了。因此只有 $n-1$ 个 $Y_i - \bar Y$ 是可变化的，最后一个则可以通过平均值与样本量确切的计算出来。所以 TSS 的自由度为 n-1 。 

ESS 自由度：
ESS = (Y_i - \hat Y)^2
对于每个 \hat Y_i 可以有 k+1 个 \hat \beta。但是 $\bar Y$ 平均值已知，正如一元线性回归中所看到的，\bar Y = \beta_0 + \beta_1 \bar X ，这样又占据了一个自由度。所以 [公式] 的自由度是 k 。

RSS 自由度：
回忆正规方程组，给定 K+1 个方程，意味着 K+1 个残差固定，所以对于残差平方和，自由度为 n-(k+1)

https://zhuanlan.zhihu.com/p/92200112
*/


adj_r2 = 1 - (RSS/df)/(TSS/df) 
= 1 - ((RSS/n-k-1)/(TSS/(n-1))

sysuse auto, clear
reg pr wei len

/*
H_0: \beta_j = 0 \quad H_1: \beta_j \neq 0
t = \frac{\hat \beta_j - \beta_j}{Se(\hat \beta_j)} ~ t(n-k)
若 |t| > t_{\alpha/2}(n-k)，则拒绝原假设，认为解释变量对被解释变量的作用是显著的。
t-2 法则
*/

dis 4.699065/1.122339 // t 检验
ttable 2
/*
F = (ESS/k)/(RSS/(n-k-1)) ~ F(k, n-k-1)
*/
dis (220725280/2)/(414340116/71) // F 检验
dis (220725280/2)/(635065396/73)
dis  1- (414340116/(74-3-1))/(635065396/(74-1)) // adj_r2


F = (R^2/(k))/((1-R^2)/(n-k-1)) 
= [(0.3476/(3-1))] / [(1-0.3476)/(74-3-1)] 
= .00375213

**************************
* 1.过原点回归
/* 
拟合系数失效
非中心 r2 = \frac{\sum \hat y_i^2}{\sum_{i=1}^n y_i^2}
如果回归模型无常数项，则平方和分解公式不成立，不宜使用r2来度量拟合优度。
*/

sysuse auto, clear
reg pr wei len, noconstant
dis 2.9996e+09/3.4478e+09

* 2.标准化变量回归

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

* 3.双对数模型
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

* 4.多项式回归
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

* 5.虚拟变量与 ANOVA 模型
/*
方差分析模型主要是用于评价定性因素对被解释变量的量化影响。
单因素方差分析、多因素方差分析
协方差分析
*/
help anova

*6.邹至庄检验
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

****************************************
* 多重共线性


