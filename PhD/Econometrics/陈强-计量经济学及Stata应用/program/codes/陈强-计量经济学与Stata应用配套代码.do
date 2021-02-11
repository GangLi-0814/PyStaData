

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
