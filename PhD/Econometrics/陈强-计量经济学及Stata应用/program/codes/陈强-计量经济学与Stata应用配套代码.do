

* 定义路径
global prog "/Users/gangli/PyStaData/PhD/Econometrics/陈强-计量经济学及Stata应用/program"
global d ${prog}/data
global o ${prog}/outputs 

* 安装外部命令
* 常用统计量表格l
net install probtabl, replace ///
from(https://stats.idre.ucla.edu/stat/stata/ado/teach)


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
数据说明：此数据集包括以下变量:tc (总成本)，q (总产量)，pl (工资率)， pk (资本的使用成本) 与 pf (燃料价格)，以及相应的对数值 lntc， lnq，lnpl，lnpk 与 lnpf。
*/

reg lntc lnq lnpl lnpk lnpf


* 残差图 -rvfplot- (residual-versus-fitted plot)
rvfplot //残差与拟合值的散点图
rvpplot lnq // 残差与解释变量 lnq 的散点图

* BP 检验
estat hettest, iid rhs 
/*
其中：
- “estat”指 post-estimation statistics(估计后统计量)，即在完成估计后所计算的后续统计量。 
- “hettest”表示 heteroskedasticity test。
- 选择项“iid”表示仅假定数据为 iid，而无须正态假定。
- 选择项“rhs”表示，使用方程右边的全部解释变量进行辅助回 归，默认使用拟合值 yˆ 进行辅助回归。

estat hettest [varlist], iid //指定使用 varlist 进行辅助回归
*/

quietly reg lntc lnq lnpl lnpk lnpf
estat hettest, iid  // 使用拟合值进行 BP 检验
estat hettest, iid rhs // 使用所有解释变量进行 BP 检验
estat hettest lnq, iid // 使用变量 lnq 进行 BP 检验
/*
结果解读：
各种形式 BP 检验的 p 值都等于 0.0000，故强烈拒绝同方差的原 假设，认为存在异方差。
*/

* 怀特检验
estat imtest, white // imtest:  information matrix test(信息矩阵检验)
/*结果解读：
p值(Prob>chi2)等于 0.0000，强烈拒绝同方差的原假设，认 为存在异方差。
*/

* WLS
/*
得到扰动项方差的估计值 ${\hat \sigma_{i}^2}_{i=1}^n$ 后，可作为权重进行 WLS 估计。 假设已把 ${\hat \sigma_{i}^2}_{i=1}^n$ 存储在变量 var 上，可通过如下 Stata 命令来实现 WLS ：

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
























