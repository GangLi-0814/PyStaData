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





