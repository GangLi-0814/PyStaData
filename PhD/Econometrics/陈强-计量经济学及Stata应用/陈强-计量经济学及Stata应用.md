## 1. 导论

什么是计量经济学

经济数据的特点和类型

## 2. Stata 入门

## 3. 数学回顾

## 4. 一元线性回顾

### 4.1 一元线性回归模型

总体回归函数（PRF）与样本回归函数（SRF）

计量经济学的主要任务之一就是通过数据$\{x_i,y_i\}_{i=1}^n$来获取关于总体参数$(\alpha, \beta)$的信息。

### 4.2 OLS估计量的推导

目标：残差平方和最小
$$
\min_{\hat \alpha, \hat \beta} \sum_{i=1}^n e_{i}^2 = \sum_{i=1}^n (y_i-\hat \alpha -\hat \beta x_i)^2
$$
最后，求得：
$$
\hat \alpha = \bar y - \hat \beta \bar x \\
\hat \beta = \frac{\sum_{i=1}^n(x_i-\bar x)(y_i-\bar y)}{\sum_{i=1}^n(x_i-\bar x )^2}
$$

### 4.3 OLS 的正交性

正交：若内积空间中两向量的内积为0，则称它们是正交的。

OLS**残差与解释变量及拟合值的正交性**是OLS的重要特征，为推导证明提供了方便。

### 4.4 平方和分解公式

平方和分解公式能够成立，正是由于OLS的正交性。
$$
\sum _{i=1}^n (y_i- \bar y)^2 = \sum _{i=1}^n (\hat y_i - \bar y)^2 + \sum_{i=1}^n e_{i}^2
$$


### 4.5 拟合优度

$$
R^2 = \frac{\sum _{i=1}^n ( \hat y_i-\bar y)^2}{\sum_{i=1}^n (y_i-\bar y)^2} = 1- \frac{\sum_{i=1}^n e_{i}^2}{\sum _{i=1}^n (\hat y_i - \bar y)^2}
$$

在有常数项的情况下，拟合优度等于被解释变量$y_i$与拟合值$\hat y_i$之间相关系数的平方，即$R^2 = [Corr(y_i,\hat y_i)]^2$，故记为$R^2$。

### 4.6 无常数项的回归

### 4.7 一元回归的Stata实例

```Stata
use grilic.dta, clear
reg lnw s
reg lnw s, noc // 无常数项回归
```

### 4.8PRF与SRF: 蒙特卡洛法

```Stata
clear
set obs 30
set seed 10101

gen x = rnormal(3, 4)
gen e = rnormal(0, 9)
gen y = 1*x + e
reg y x

tw function PRF = 1+2*x, range(-5 15) || \\\
scatter y x || lfit y x, lp(dash)
```

## 5. 多元线性回归

### 5.1 二元线性回归

使用一元线性回归会存在遗漏变量的问题，所以需要纳入更多的解释变量。先来看二元线性回归：

最优化问题：残差平方和最小
$$
\min_{\hat \alpha, \hat \beta, \hat \gamma} \sum_{i=1}^n e_{i}^2 = \sum_{i=1}^n (y_i -\hat \alpha-\hat \beta x_{i1} -\hat \gamma x_{i2})^2
$$
寻找一个回归平面$\hat y_{i} = \hat \alpha + \hat \beta x_{1i} + \hat \gamma x_{2i}$，即估计参数$\hat \alpha, \hat \beta, \hat \gamma$，使得所有样本点$\{(x_{i1},x_{2i},y_i)\}_{i=1}^n$离此回归平面最近。

求解：分别对$\hat \alpha, \hat \beta, \hat \gamma$求偏导数，可得最小化的一阶条件，求解可得$\hat \alpha, \hat \beta, \hat \gamma$的 OLS 估计量。

### 5.2 多元线性回归

基本形式：
$$
y_i = \beta_1 + \beta_2 x_{i2} + ... +\beta_Kx_{iK} + \epsilon_{i}
$$


**采用矩阵形式**，可将原模型写成：
$$
y_i = (\begin{matrix} 1 & x_{i2} & ... & x_{ik} \end{matrix}) \begin{Bmatrix} \beta_1 \\ \beta_2 \\ ... \\ \beta_K \end{Bmatrix} + \epsilon_i = \mathbf{X_{i}^\mathrm{'}} \mathbf{\beta} + \epsilon_i
$$


叠放后，将共同的参数向量$\mathbf{\beta}$向右边提出：
$$
\mathbf{y} = ... =\mathbf{X \beta + \epsilon}
$$
其中，$\mathbf{X}$为$n \times K$数据矩阵。

### 5.3 OLS 估计量的推导

$$
\mathbf{\hat \beta = (X^\mathrm{'}X)^{-1}X^\mathrm{'}y}
$$

### 5.4 OLS 的几何解释

![](./images/5-1.png)

拟合值$\mathbf{\hat y}$可视为被解释变量 $\mathbf{y}$ 向解释变量超平面 $\mathbf{X}$ 的投影 (projection)。**由于拟合值为解释变量的线性组合，即 $\mathbf{\hat y  = X \hat β}$ ，故拟合值向量 $\mathbf{\hat y}$正好在超平面 $\mathbf{X}$ 上**。根据 OLS 的正交性，残差向量$\mathbf{e}$与 $\mathbf{\hat y}$正交 。
### 5.5 拟合优度

#### 5.5.1 拟合优度

由于OLS的正交性，平方和分解公式依然成立。

拟合优度的缺点是：如果增加解释变量的数目，则$R^2$只增不减，因为至少可让新增解释变量的系数为0而保持$R^2$不变。

#### 5.5.2 调整拟合优度

引入调整$R^2$对解释变量过多（模型不够简洁）进行惩罚。

定义调整$\bar R^2$为：
$$
\bar R^2 = 1 - \frac{\sum_{i=1}^n e_{i}^2/(n-K)}{\sum_{i=1}^n(y_i-\bar y)^2/(n-1)}
$$

$\sum_{i=1}^n e_{i}^2$的自由度（degree of freedom）为$(n-K)$。

如果让$K$增多，有两个相反方向的变动。

$\bar R^2$的缺点是可能为负。

### 5.6 古典线性回归模型的假定

SLR.1 线性假定：每个解释变量对$y_i$的边际效应为常数。线性是指回归函数是参数（$\beta_1, ...,\beta_k$）的线性函数。

在现实中，如果边际效应可变，可以加入平方项或交叉项。

SLR.2 严格外生性：意味着在给定数据矩阵$\mathbf{X}$的情况下，扰动项$\epsilon_{i}$的条件期望为0。

SLR.3 不存在严格多重共线性

SLR.4 同方差性



### 5.7 OLS 的小样本性质

高斯-马尔克夫定理：在SLR.1~SLR.4之下，最小二乘法是最佳无偏估计量（Best Linear Unbiased Estimator, 简记BLUE），即在所有线性的无偏估计中，最小二乘法的方差最小。

- 线性性：OLS 估计量 $\mathbf{\hat \beta}$为线性估计量

- 无偏性
- 





### 5.8 对单个系数 t 检验

### 5.9 对线性假设的 F 检验

### 5.10  

### 用 Stata 进行多元回归的实例

用Stata进行二元回归：

```Stata
* 柯布道格拉斯生产函数
use cobb_douglas.dta, clear
list

regress lny lnk lnl
predict lny1
predict e, res

list lny lny1 e
line lny lny1 year, lp(solid dash)
```

### 



