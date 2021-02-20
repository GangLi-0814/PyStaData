

* 定义路径
global prog "/Users/gangli/PyStaData/PhD/Econometrics/陈强-计量经济学及Stata应用/program"
global d ${prog}/data
global o ${prog}/outputs 

* 安装外部命令
* 常用统计量表格
net install probtabl, replace ///
from(https://stats.idre.ucla.edu/stat/stata/ado/teach)
* 汇报回归结果
ssc install estout, replace

************************
* 第 4 章 一元线性回归
************************
* 一元回归
use grilic.dta, clear
reg lnw s
reg lnw s, noc // 无常数项回归

* PRF 和 SRF：蒙特卡罗模拟
clear
set obs 30
set seed 10101

gen x = rnormal(3, 4)
gen e = rnormal(0, 9)
gen y = 1*x + e
reg y x

tw function PRF = 1+2*x, range(-5 15) || ///
scatter y x || lfit y x, lp(dash)

* 一元回归实例
use ${d}/grilic.dta, clear
/*
数据说明：此数据集包括 758 位美国年轻男 子的教育投资回报率数据
*/
reg lnw s
reg lnw s, noc // 无常数项回归
************************
* 第 5 章 多元线性回归
************************

* 柯布道格拉斯生产函数
use ${d}/cobb_douglas.dta, clear
/*
数据说明：
Cobb and Douglas (1928)使用美国 1899-1922 年制造业产出( y )、
资本(k )与劳动力(l )的数据。
*/
list
regress lny lnk lnl
predict lny1
predict e, res
list lny lny1 e
line lny lny1 year, lp(solid dash)

* 多元回归
use ${d}/grilic.dta, clear

/*
数据说明：
该数据集包括 758 名美国年轻男子的数据。
被解释变量为 lnw (工资对数)，主要解释变量包括 s (教育年限)、expr (工龄)、tenure (在现单位工作年限)、smsa (是否住在大城市) 以及 rns (是否住在美国南方)。
*/
、
reg lnw s expr tenure smsa rns

vce // 回归系数的协方差矩阵
reg lnw s expr tenure smsa rns, noc //无常数项回归
reg lnw s expr tenure smsa if rns // only rns == 1
reg lnw s expr tenure smsa if ～rns // only rns == 0
reg lnw s expr tenure smsa rns if s>=12 // only 中学以上
reg lnw s expr tenure smsa if s>=12 & rns // 中学以上且住在南方

quietly reg lnw s expr tenure smsa rns
predict lnw1 // 拟合值
predict e, residual //残差


* t 检验
test s = 0.1 // H_0: \beta_2 = 0.1
/*
 ( 1)  s = .1

       F(  1,   752) =    0.20
            Prob > F =    0.6515

解读：由于 t 分布的平方为 F 分布，故 Stata 统一汇报 F 统计量及其 p 值。 上表显示，p 值 = 0.6515 ，故无法拒绝原假设。
*/


*手工计算 t 统计量
/*
t = \frac{估计值 - 假想值}{估计值的标准误} = \frac{0.102643 - 0.1}{0.0058488} = 0.45188757 \sim t(n-K) = t
*/

dis (0.102643 - 0.1)/0.0058488 // 0.45188757
ttable 752 // ttable [df]
/*
       Critical Values of Student's t
       .10     .05     .025    .01     .005    .0005  1-tail
 df    .20     .10     .050    .02     .010    .0010  2-tail
752   1.283   1.647   1.963   2.331   2.582    3.304

在 5% 的显著性水平下，0.45188757 < 1.963 ，落入接受域，接受原假设。
*/


/*
由于默认为双边检验，故可计算此 t 统计量对应的 p 值如下:
*/

dis ttail(752,0.45188757)*2 // 0.65148029

/*
表示自由度为 752 的 t 分布比 0.45188757 更大的右侧尾部概率，正好是反向累积分布函数。
*/

*单边检验

dis ttail(752, 0.45188757) // .32574014
/*
如果已知双边检验的p值，在做单边检验时(假设t统计量的符号 与替代假设的方向相同)，一般只需将双边检验的p值除以 2，即 可得到单边检验的 p 值，然后得到单边检验的结果。
*/

test expr = tenure // H_0: \beta_3 = \beta_4
/*
由于p值 = 0.8208，可轻松接受原假设。
*/

test expr + tenure = s // H_0: \beta_3 + \beta_4 = \beta_2
/*
由于 p 值 = 0.0031，故可在 1%的显著性水平上拒绝原假设，即认为\beta_3 + \beta_4 \neq \beta_2。
*/


*****************
* 第 7 章 异方差
*****************

use ${d}/nerlove.dta, clear
/*
数据说明：此数据集包括以下变量:
tc (总成本)，q (总产量)，pl (工资率)， pk (资本的使用成本) 与 pf (燃料价格)；
以及相应的对数值 lntc， lnq，lnpl，lnpk 与 lnpf。
*/

reg lntc lnq lnpl lnpk lnpf

* 1.残差图 -rvfplot- (residual-versus-fitted plot)
rvfplot //残差与拟合值的散点图
rvpplot lnq // 残差与解释变量 lnq 的散点图


* 2.BP 检验
estat hettest, iid rhs 
/*
其中：
- “estat”指 post-estimation statistics(估计后统计量)，即在完成估计后所计算的后续统计量。 
- “hettest” 表示 heteroskedasticity test。
- 选择项 “iid” 表示仅假定数据为 iid，而无须正态假定。
- 选择项 “rhs” 表示，使用方程右边的全部解释变量进行辅助回归，默认使用拟合值 \hat y 进行辅助回归。

estat hettest [varlist], iid //指定使用 varlist 进行辅助回归
*/

quietly reg lntc lnq lnpl lnpk lnpf
estat hettest, iid  // 使用拟合值进行 BP 检验
estat hettest, iid rhs // 使用所有解释变量进行 BP 检验
estat hettest lnq, iid // 使用变量 lnq 进行 BP 检验
/*
结果解读：
各种形式 BP 检验的 p 值都等于 0.0000，故强烈拒绝同方差的原假设，认为存在异方差。
*/



* 3.怀特检验

estat imtest, white // imtest:  information matrix test(信息矩阵检验)
/*结果解读：
p值(Prob>chi2)等于 0.0000，强烈拒绝同方差的原假设，认 为存在异方差。
*/

* 4.WLS
/*
得到扰动项方差的估计值 ${\hat \sigma_{i}^2}_{i=1}^n$ 后，可作为权重进行 WLS 估计。
假设已把 ${\hat \sigma_{i}^2}_{i=1}^n$ 存储在变量 var 上，可通过如下 Stata 命令来实现 WLS ：
reg y x1 x2 x3 [aw=1/var]
其中，“aw”表示 analytical weight，为扰动项方差(不是标准差)的倒数。
*/

quietly reg lntc lnq lnql lnpk lnpf
predict e1, residual
gen e2 = e1^2
gen lne2 = log(e2)
reg lne2 lnq // 假设 $\ln{\hat \sigma_{i}^2}$ 为变量 `lnq' 的线性函数进行辅助回归

/*
结果解读：变量lnq在1%水平上显著，但R2仅为0.1309，且常数项不显著 ( p值为 0.26)。
*/

reg lne2 lnq, noc //去掉常数项重新进行辅助回归

/*
结果解读：
R2上升为 0.7447(尽管无常数项的R2与有常数项的R2不可比)， 残差平方的变动与 lnq 高度相关。
*/

predict lne2f // 计算辅助回归的拟合值
gen e2f = exp(lne2f) //去掉对数后，即得到方差的估计值
reg lntc lnq lnpl lnpk lnpf [aw=1/e2f] // 使用方差估计值的倒数作为权重,WLS
/*
结果解读：
WLS 回归的结果显示，lnpk 的系数估计值由“-0.22”(OLS 估 计值)改进为“-0.09”(其理论值应为正数)。
使用 OLS 时，变量 lnpl 的 p 值为 0.13，在 10%的水平上也不显 著;使用 WLS 后，该变量的 p 值变为 0.002，在 1%的水平上显著 不为 0。
由于 Nerlove(1963)数据存在明显的异方差，使用 WLS 后提高了 估计效率。
*/

/*
如担心条件方差函数的设定不准确，导致加权后的新扰动项仍 有异方差，可使用稳健标准误进行 WLS 估计:
*/
reg lntc lnq lnpl lnpk lnpf [aw=1/e2f],r

/*
结果解读：
无论是否使用稳健标准误，WLS 的回归系数都相同，但标准误有所不同。
*/

* WLS for Nerlove(1963)
capture log close
log using wls_nerlove,replace
set more off
use nerlove.dta, clear
reg lntc lnq lnpl lnpk lnpf
predict e1,r
gen e2=e1^2
gen lne2=log(e2)
reg lne2 lnq,noc
predict lne2f
gen e2f=exp(lne2f)

* Weighted least square regression
reg lntc lnq lnpl lnpk lnpf [aw=1/e2f]
reg lntc lnq lnpl lnpk lnpf [aw=1/e2f],r
log close
exit

******************
* 第 8 章 自相关
******************

* 时间序列算子

help tsvarlist

L. // 滞后 lag
D. // 差分 difference
L2. // 二阶滞后
L(1/4). //同时表示一阶至四阶滞后
L(0/1). // 表示当前值和一阶滞后
D2. // 二阶差分
LD. // 一阶差分的滞后值

* 画残差图
scatter e1 L.e1
ac e1 // 残差自相关图 ac: autocorrelation

* BG 检验
estat bgodfrey, lags(p) nomiss0
/*
- 选择项“lags(p)”用来指定 BG 检验的滞后阶数p，默认
“lags(1)”，即 p = 1;
- 选择项“nomiss0”表示进行不添加 0 的 BG 检验，默认以
0 代替缺失值，即 Davidson-MacKinnon 的方法。
*/

/*
如何确定滞后阶数 p ?一个简单方法是，看自相关图。
在使用 Stata 命令 ac 画自相关图时，所有落在 95%的置信区 域(以阴影表示)以外的自相关系数均显著地不等于 0。

确定滞后阶数 p 的另一方法是，设定一个较大的 p 值，作回归。然后看最后一个系数的显著性;如果不显著，考虑滞后期，以此类推，直至显著为止。
*/


* Q 检验
wntestq e1, lags(p)
/*
其中，“wntestq”指 white noise test Q，因为白噪声没有自相 关。选择项“lags(p)”用来指定滞后阶数，默认滞后阶数为
min{floor(n / 2)  -2, 40}。
*/
corrgram e1, lags(p)
/*
其中，“corrgram”表示 correlogram，即画自相关图。选择项 “lags(p)”用来指定滞后阶数，而默认滞后阶数也是
min{floor(n / 2)  2, 40}。
*/

* DW检验
estat dwatson
/*
作完 OLS 回归后可使用命令“estat dwatson”显示 DW 统
计量。由于 DW 检验的局限性，Stata 并不提供其临界值。
*/

* HAC 稳健标准误
newey y x1 x2 x3, lags(p)

/*
其中，必选项“lag(p)”用来指定截断参数 p ，即用于计算
HAC 标准误的最高滞后阶数。
*/

* 处理一阶自相关的 FGLS
prais y x1 x2 x3, corc
/*
选择项“corc ”表示使用 CO 估计法，默认为 PW 估计法。
*/


use ${d}/icecream.dta, clear
/*
数据说明：
数据集 icecream.dta 包含了下列变量的 30 个月度时间序列数据:consumption(人均冰淇淋消费量)，income(平均家庭收入)，price(冰淇淋价格)，temp(平均华氏气温)，time(时间)。
*/

tsset time
tw connect consumption time, msymbol(circle) yaxis(1) || connect temp time, msymbol(triangle) yaxis(2)

reg consumption temp price income
/*
气温(temp)与收入(income)均在 1%的水平上显著为正，表示气 温越高、收入越高，则冰淇淋的消费量越大;
价格(price)的系数为负，表明价格越高，则消费量越低，但并不 显著( p值为 0.222)。
由于这是时间序列，怀疑扰动项存在自相关。
*/
predict e1, residual
tw scatter e1 l.e1 || lfit e1 l.e1
/*
扰动项很可能存在一阶正自相关。
*/

tw scatter e1 l2.e1 || lfit e1 l2.e1
/*
扰动项不存在二阶正自相关。
*/

ac e1 // 残差自相关图
/*
阴影部分为置信度为 95%的置信区间(区域)。
各阶自相关系数的取值均在 95%的置信区间之内，故可接受各 阶自相关系数为 0 的原假设。
 但一阶自相关系数已很接近置信区间的边界，故仍怀疑存在
一阶自相关，而更高阶自相关可忽略。
*/

estat bgodfrey // BG 检验
/*
BG 检验的 p 值为 0.039 6，故可在 5%的显著性水平上拒绝“无 自相关”的原假设，而认为存在自相关。
*/

estat bgodfrey, nomiss0
/*
依然可在 5%水平上拒绝“无自相关”的原假设。
*/

wntestq e1
/*
其中，“Prob > chi2(13)= 0.016”表明默认的滞后阶数为
13 阶，且可在 5%水平上拒绝“无自相关”的原假设。
*/

corrgram e1
/*
上表汇报了从 1-13 阶的自相关系数(AC)，Q 统计量(Q)及其相应 p 值(Prob>Q)。
*/

estat dwatson
/*
由于 DW=1.02，离 2 较远而靠近 0，可大致判断存在正自相关。
*/

/*
由于扰动项存在自相关，故普通标准误不准确，应使用异方差
自相关稳健的 HAC 标准误。 由于 $n^{1/4} = 30^{1/4} \approx$ ，取Newey-West估计量滞后阶数为p=3:
*/
newey consumption temp price income, lag(3)
/*
Newey-West 标准误与 OLS 标准误相差无几(但略大)。
*/

/*
考察 Newey-West 标准误是否对于截断参数敏感，将滞后阶数
增大一倍，再重新估计。
*/
newey consumption temp price income,lag(6)
/*
无论截断参数为 3 还是 6，Newey-West 标准误变化不大。
*/

* 由于存在自相关，故考虑使用 FGLS，进行更有效率的估计。

prais consumption temp price income, corc //CO估计法
/*
使用 CO 估计法得到的系数估计值与 OLS 比较接近，但样本容 量降为 29(损失一个样本观测值)。
上表最后一行显示，经过模型转换后 DW 值改进为 1.55。
*/

prais consumption temp price income, nolog //PW估计法
/*
虽然 PW 法使 DW 统计量进一步改进为 1.85，但收入(income) 的系数估计值却变为负数(-0.0008)，似乎 PW 反而不如 OLS 稳健。
*/

/*
自相关可能由于模型设定不正确。 在解释变量中加入气温(temp)的滞后，然后进行 OLS 回归
*/

reg consumption temp L.temp price income
/*
气温的滞后项(L.temp)在 1%的水平上显著地不等于 0，但符号 为负(系数为-0.0022);
当期气温仍然显著地为正(系数为 0.0053)。这可能意味着，当气 温上升时，对冰淇淋的需求上升，但不会在当月全部消费完，而 增加冰箱中的冰淇淋库存，导致下期对冰淇淋的开支下降。
*/

estat bgodfrey
/*
由于 p 值为 0.73，故可放心接受“无自相关”的原假设。
*/

estat dwatson
/*DW 值也改进为 1.58。 通过修改模型设定，加入气温滞后项，扰动项不再存在自相关。
*/

/*究竟应使用哪种模型，在一定程度上取决于研究者的判断。
可在研究报告中同时列出各种模型的结果，以说明系数估计值 与标准误的稳健性(不依估计方法的改变而剧烈变化)，给读者自己 判断的机会。
*/



***************************
* 第 9 章 模型设定与数据问题 
***************************

* 解释变量个数的选择
*********************
use ${d}/icecream.dta,clear
quietly reg consumption temp price income
estat ic
/*
加入气温的一阶滞后项(L.temp)，重新估计。
*/

qui reg consumption temp L.temp price income
estat ic
/*
增加解释变量 L.temp 后，AIC 与 BIC 都下降了
*/
/*
加入气温的二阶滞后项(L2.temp)，重新估计。
*/
qui reg consumption temp L.temp L2.temp price income
estat ic
/*
加入气温的二阶滞后项后，AIC 与 BIC 比仅包括气温的滞后项上升了。
*/
reg consumption temp L.temp L2.temp price income
/*
L2.temp 的系数高度不显著( p 值为 0.556)。
令\hat p = p_{max}-1 (去掉L2.temp)，重新估计。
*/
reg consumption temp L.temp price income
/*
L.temp 的系数在 1%水平上显著( p值为 0.006)，故最终选择 \hat p = 1 ;此结果与信息准则的结果相同。
*/

* 对函数形式的检验
*********************
/*
estat ovtest,rhs
其中，“ovtest”表示 omitted variable test，因为遗漏高次项的 后果类似于遗漏解释变量。
选择项“rhs”表示使用解释变量的幂为非线性项，即方程(9.16); 默认使用yˆ2, yˆ3, yˆ4为非线性项，即方程(9.15)。
以数据集 grilic.dta 为例。
*/
use ${d}/grilic.dta, clear
qui reg lnw s expr tenure smsa rns
estat ovtest
estat ovtest,rhs // 直接使用解释变量的高次项进行 RESET 检验

gen expr2 = expr^2
reg lnw s expr expr2 tenure smsa rns
estat ovtest,rhs


* 多重共线性
*********************
twoway function VIF=1/(1-x),xtitle(R2) xline(0.9,lp(dash)) yline(10,lp(dash)) xlabel(0.1(0.1)1) ylabel(10 100 200 300)

/*
其中，选择项“xtitle(R2)”指示横轴的标题为 R2; “xline(0.9,lp(dash))”与“yline(10,lp(dash))” 分 别表示在横轴 0.9 与纵轴 10 的位置画一条虚线; “xlabel(0.1(0.1)1)”表示在横轴上，从 0.1 至 1，每隔 0.1 的位置给出标签;“ylabel(10 100 200 300)”表示在纵轴 上 10、100、200 与 300 的位置给出标签
*/

use ${d}/grilic.dta, clear
qui reg lnw s expr tenure iq smsa rns
estat vif
/*
最大的 VIF 为 1.12，远小于 10，不必担心多重共线性。
*/
gen s2=s^2
reg lnw s s2 expr tenure smsa rns
estat vif
/*
变量 s 与 s2 的 VIF 分别达到 167.07 与 166.30，远大于 10，存 在多重共线性。
*/
reg s2 s
/*
R2高达0.9939，说明s与s2所包含信息基本相同，导致严重的 多重共线性。
*/
sum s 
gen sd = (s - r(mean))/r(sd)
gen sd2 = sd^2
reg lnw sd sd2 expr tenure smsa rns
/*
标准化的线性项(sd)在 1%水平上显著为正，而标准化的平方项 (sd2)不显著;多重共线性似乎有所缓解。
*/
estat vif
/*
VIF 的最大值仅为 1.32，基本不存在多重共线性。
*/
reg sd2 sd //R2仅为0.1745
/*
由于 sd2 在上面的回归中不显著，去掉 sd2，再次回归
*/
reg lnw sd expr tenure smsa rns
/*
sd 的回归系数为 0.2291，似乎偏高。
但 sd 为标准化的变量，故 sd 变化一单位，等于 s 变化一个标 准差，即 2.231828 年
*/
* 以此推算 s 的系数，即教育投资的年回报率应为
dis .2290816/2.231828
* 再次对比未将变量 s 标准化的回归:
reg lnw s expr tenure smsa rns
/*
是否将变量 s 标准化，对于回归结果(回归系数、标准误)没有任 何实质性影响。
*/


* 极端数据
*********************
/*
predict lev,leverage
此命令将计算所有观测数据的影响力，并记为变量lev (可自行 命名)
*/
use ${d}/nerlove.dta, clear
qui reg lntc lnq lnpl lnpk lnpf
predict lev, leverage
sum lev
dis r(max)/r(mean)
*lev 的最大值是其平均值的 3.41 倍，似乎不大。
gsort -lev
list lev in 1/3

/*再次人为制造极端数据，将第一个观测值的产量对数(lnq)乘以100，然后计算 lev
*/
replace lnq=lnq*100 if _n==1
qui reg lntc lnq lnpl lnpk lnpf 
predict lev1,lev
sum lev1
dis r(max)/r(mean)
/* 
lev 的最大值是其平均值的 28.42 倍，故存在极端观测值。
*/

* 虚拟变量
**************
gen d=(year>=1978)
/*
其中，“( )”表示对括弧内的表达式“year>=1978”进行逻 辑判断。如果此表达式为真，则取值为 1;反之，取值为 0
*/
tabulate province, generate(prov)


* 经济结构变动
*************
use ${d}/consumption.dta,clear
* 先看中国 1978—2013 年“居民人均消费”(c)与“人均国内总产 值”(y)的年度(year)时间趋势图
twoway connect c y year,msymbol(circle) msymbol(triangle)
twoway connect c y year,msymbol(circle) msymbol(triangle) xlabel(1980(10)2010) xline(1992)

/*
考察简单的消费函数:c_t= \alpha + \beta x_1 + \epsilon_t
首先，使用传统的邹检验来检验消费函数是否在 1992 年发生结 构变动。
分别对整个样本、1992 年之前及之后的子样本进行回归，获得 其残差平方和:
*/
reg c y
scalar ssr=e(rss)
reg c y if year<1992
scalar ssr1=e(rss)
reg c y if year>=1992
scalar ssr2=e(rss)
* 由于n=36，K=2，n- 2K = 32，可计算F 统计量如下:
di ((ssr-ssr1-ssr2)/2)/((ssr1+ssr2)/32) //15.394558

/*
其次，使用虚拟变量法进行结构变动的检验。
生成虚拟变量 d (对于 1992 年及以后，d=1;反之，d=0);以及 虚拟变量 d 与人均收入 y 的互动项 yd:
*/
gen d=(year>1991)
gen yd=y*d
reg c y d yd
test d yd
/*
虚拟变量法所得 F 统计量为 15.39，与邹检验完全相同。 p值为 0.0000，可在 1%水平上拒绝“无结构变动”的原假设。
上述检验仅在球形扰动项(同方差、无自相关)的情况下才成立。
*/

* 下面进行异方差与自相关的检验
qui reg c y
estat imtest,white
tsset year
estat bgodfrey //BG 检验
/*
可在 5%的水平上拒绝“同方差”的原假设。
可在 1%水平上强烈拒绝“无自相关”的原假设。
*/
dis 36^(1/4) // 计算 HAC 标准误的截断参数
newey c y d yd,lag(3) //将截断参数设为 3，进行 Newey-West 回归。
test d yd
/*
p值为 0.0000，可在 1%水平上拒绝“无结构变动”的原假设， 认为中国的消费函数在 1992 年发生了结构变动。
*/


* 线性插值
**************
/*
ipolate y x,gen(newvar)
其中，“ipolate”表示 interpolate，即将变量 y 对变量 x 进行 线性插值，并将插值的结果记为新变量 newvar。
*/

use ${d}/consumption.dta,clear
* 假设 1980 年、1990 年、2000 年及 2010 年的人均 GDP 数据缺失。
gen y1=y
replace y1=. if year==1980 | year==1990 | year==2000 | year==2010

* 直接用 y1 对 year 进行线性插值，将结果记为 y2
ipolate y1 year,gen(y2)

/*
由于人均 GDP 有指数增长趋势，故更好的做法是，先对 y1 取
对数，进行线性插值，再取反对数，将结果记为 y3。
*/
gen lny1=log(y1)
ipolate lny1 year,gen(lny3)
gen y3=exp(lny3)


* 对比这两种方法的效果
list year y y2 y3 if year==1980 | year==1990 | year==2000 | year==2010
/*
对比结果：
直接插值的结果 y2 倾向于高估真实值 y，整体估计效果不如先 取对数再插值的结果 y3 (1980 年的结果是例外)。
*/

*********************
* 第 10 章 工具变量法
*********************

use ${d}/grilic.dta, clear

/*
数据说明：
此数据集的主要变量包括：lnw(工资对数)，s(教育年限)，expr(工 龄)，tenure(在现单位的工作年数)，iq(智商)，med(母亲的教育年 限)，kww(在“knowledge of the World of Work”测试中的成绩)， rns(美国南方虚拟变量，住在南方=1)，smsa(大城市虚拟变量，住 在大城市=1)。
*/

* 1.作为参照系，首先进行 OLS 回归，并使用稳健标准误
reg lnw s expr tenure rns smsa, r
/*
教育投资的年回报率高达 10.26%(似乎太高)，且在 1%的水 平上显著。可能遗漏“能力”，高估了教育的回报率
*/

* 2.引入智商(iq)作为“能力”的代理变量，再进行 OLS 回归
reg lnw s iq expr tenure rns smsa, r


* 3.由于用 iq 度量能力存在“测量误差”，故 iq 是内生变量。使用变量(med, kww)作为 iq 的工具变量。
/*
母亲的教育年限(med)与 KWW 测试成绩(kww)都与 iq 正相关; 并假设 med 与 kww 为外生
*/
ivregress 2sls lnw s expr tenure rns smsa (iq = med kww), r first
/*
教育投资回报率降为 6.08%，且在 1%水平上显著;比较合理。
*/

* 4.过度识别检验
estat overid
/*
p值为 0.697，故接受原假设，认为(med, kww)外生
*/

* 5.工具变量与内生变量的相关性
/*
从第一阶段的回归结果可知，工具变量(med, kww)对内生变量 iq 有较好解释力， p 值都小于 0.05。
正式检验须计算第一阶段回归的普通(非稳健) F 统计量
*/
// 使用普通标准误重新进行 2SLS 估计
quietly ivregress 2sls lnw s expr tenure rns smsa (iq=med kww)
estat firststage
/*
由于 F 统计量为 14.91，超过 10，故认为不存在弱工具变量
*/

* 6.使用对弱工具变量更不敏感的有限信息最大似然法(LIML)
ivregress liml lnw s expr tenure rns smsa (iq=med kww), r

/*
LIML 估计值与 2SLS 非常接近，侧面印证“不存在弱工具变量”
*/

* 7.使用工具变量法的前提是存在内生解释变量。为此进行豪斯 曼检验，原假设为“所有解释变量均为外生”
quietly reg lnw iq s expr tenure rns smsa
estimates store ols
quietly ivregress 2sls lnw s expr tenure rns smsa (iq=med kww)
estimates store iv
hausman iv ols,constant sigmamore
/*
传统的豪斯曼检验假定同方差，故在回归中未使用稳健标准误
p值(Prob>chi2)为 0.0499，可在 5%水平上拒绝“所有解释变 量均为外生”的原假设，认为 iq 内生
传统的豪斯曼检验在异方差下不成立，下面进行异方差稳健的 DWH 检验:
*/
estat endogenous
/*
根据 F 统计量与 \chi_2 统计量，二者在大样本下渐近等价。 二者的 p 值都小于 0.05，故认为 iq 内生
*/

* 8.汇报结果:将以上各种估计法的系数及标准误列在同一表格中，可使用以下命令
qui reg lnw s expr tenure rns smsa,r
est sto ols_no_iq
qui reg lnw iq s expr tenure rns smsa,r
est sto ols_with_iq
qui ivregress 2sls lnw s expr tenure rns smsa (iq=med kww),r
est sto tsls
qui ivregress liml lnw s expr tenure rns smsa (iq=med kww),r
est sto liml
estimates table ols_no_iq ols_with_iq tsls liml,b se
//用一颗星表示 10%的显著性，两颗星表示 5%的显著性，三 颗星表示 1%的显著性
estimates table ols_no_iq ols_with_iq tsls liml,star(0.1 0.05 0.01)

* ssc install estout, replace
esttab ols_no_iq ols_with_iq tsls liml using ${o}/iv.rtf,se r2 mtitle star(* 0.1 ** 0.05 *** 0.01)
/*
选择项“se”表示在括弧中显示标准误(默认显示t 统计量，如 果使用选择项“p”则显示 p 值)。
选择项“r2”表示显示R2。 选择项“mtitle”表示使用模型名称(model title)作为表中每列
的标题(默认使用被解释变量作为标题)
选择项“star(* 0.1 ** 0.05 *** 0.01)”表示以星号 表示显著性水平。
*/


*******************
* 11. 二值选择模型
*******************
* 1.二值模型的 Stata 命令

probit y x1 x2 x3,r //probit 模型 
logit y x1 x2 x3,r or // logit 模型 
/*
选择项“r”表示使用稳健标准误(默认为普通标准误);
选择项“or”表示显示几率比(odds ratio)，不显示回归系数。
*/

*完成 Probit 或 Logit 估计后，可进行预测，计算准确预测的百 分比，或计算边际效应:

predict y1 // 计算发生概率的预测值，记为y1 
estat clas  //计算准确预测的百分比，clas 表示classification
margins,dydx(*) //计算所有解释变量的平均边际效应,“*”代表所有解释变量
margins,dydx(*) atmeans //计算所有解释变量在样本均值处的边际效应 
margins,dydx(*) at(x1=0) // 计算所有解释变量在 x1 = 0 处的平均边际效应
margins,dydx(x1) //计算解释变量 x1 的平均边际效应
margins,eyex(*) //计算平均弹性，其中的两个“e”均
指 elasticity
margins,eydx(*) //计算平均半弹性， x 变化一单位引起y 变化几个单位 
margins,dyex(*) //计算平均半弹性，x 变化 1%引起 y 变化百分之几

* 2.实例
*********
use ${d}/titanic.dta, clear
/* 数据描述：
此数据集由 Dawson(1995)提供，原始数据来自英国贸易委员会 (British Board of Trade)在沉船之后的调查。
该数据集的被解释变量为 survive(存活=1，死亡=0);
解释变量包括 child(儿童=1，成年=0)，female(女性=1，男性=0)， class1(头等舱=1，其他=0)，class2(二等舱=1，其他=0)，class3(三 等舱=1，其他=0)，class4(船员=1，其他=0)。
*/
list 
/*
原始数据只有 24 个观测值，但每个观测值可能重复多次;其重 复次数以最后一列变量 freq 表示。
第一行数据显示，乘坐三等舱的男孩死亡者有 35 人;第二行数 据显示，乘坐三等舱的女孩死亡者有 17 人;以此类推。
对于观测值重复的数据，在估计时，须以重复次数(freq)作为 权重才能得到正确结果。
其效果相当于在数据文件中，将第一行数据重复 35 次，第二行 数据重复 17 次，以此类推 (不同于以方差倒数为权重的 WLS)

假设观测值的重复次数记录于变量 freq，在 Stata 中，可通过 在命令的最后加上“[fweight=freq]”来实现加权计算或估计; 其中“fweight”指“frequency weight”(频数权重)
*/
sum [fweight=freq]
/*
样本容量为 2201(旅客与船员总人数)，而非 24。从变量 survive 的平均值可知，平均存活率为 0.32。
*/

* 分别计算小孩、女士以及各等舱旅客的存活率
sum survive if child [fweight=freq]
sum survive if female [fweight=freq]
sum survive if class1 [fweight=freq]
sum survive if class2 [fweight=freq]
sum survive if class3 [fweight=freq]
sum survive if class4 [fweight=freq]
/*
小孩、女士、一等舱、二等舱的存活率分别为 0.52、0.73、0.62、 0.41，高于平均存活率;三等舱、船员的存活率分别为 0.25、0.24， 低于平均存活率。
*/

* LPM 模型
reg survive child female class1 class2 class3 [fweight=freq],r

/*
将虚拟变量 class4(船员)作为参照类别，不放入回归方程。

儿童(child)、妇女(female)与头等舱旅客(class1)的存活概率均显 著更高，三等舱旅客(class3)的存活概率显著更低，二等舱旅客 (class2)的存活概率与船员无显著差异。
*/

* Logit 模型
logit survive child female class1 class2 class3 [fweight=freq],nolog // 选择项“nolog”表示不显示 MLE 数值计算的迭代过程
/*
Logit 估计结果在显著性方面与 OLS 完全一致
准R2为 0.20。检验整个方程显著性的LR统计量(LR chi2(5)) 为 559.40， p 值为 0.000，整个方程高度显著
*/
logit survive child female class1 class2 class3 [fweight=freq],nolog r // 稳健标准误

logit survive child female class1 class2 class3 [fweight=freq],or nolog // 汇报几率比
/*
儿童的生存几率比是成年人的近3倍(几率比2.89)，妇女的存活 几率比是男人的 11 倍多(几率比 11.25)，头等舱旅客的存活几率比 是船员的 2.36 倍，三等舱旅客的存活几率比只是船员的 39.8%; 二等舱旅客的存活几率比也略低于船员(几率比 0.85)，但此差别不 显著
*/

* 计算平均边际效应
margins, dydx(*)
/*
Logit 模型的平均边际效应与 OLS 回归系数相差不大。
*/

*作为演示，计算在样本均值处的边际效应
margins, dydx(*) atmeans
/*
在样本均值处的边际效应与平均边际效应有所不同
*/

* 计算模型准确预测的比率
estat clas
/*
正确预测的比率为 (349 + 1364)/2201 = 77.83 %。
根据 Logit 回归结果，预测每位乘客的存活概率，记为变量 prob。
*/

predict prob
list prob survive freq if class1==1 & child==0 & female==1
/*
Ms. Rose(头等舱、成年、女性) 的存活概率高达 88.5%。从频率上看，在所有头等舱 的 144 位成年女性中，只有 4 位死亡。
*/

list prob survive freq if class3==1 & child==0 & female==0
/*
Mr. Jack (三等舱、成年、男性)的存活概率仅有 10.4%。从频率上看，在所有三等舱的 462 位成年男性中，只有 75 位生还。
*/

* Probit 模型
probit survive child female class1 class2 class3 [fweight=freq],nolog
margins,dydx(*)
estat clas
/*
Probit的平均边际效应、准R2与正确预测比率与Logit十分接近， 基本等价。
*/

predict prob1
corr prob prob1
/*
Probit 与 Logit 对个体存活概率的预测相关系数高达 0.9997，基 本无差异。
*/







