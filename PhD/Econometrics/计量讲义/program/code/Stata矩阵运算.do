
matrix drop _all

sysuse auto,clear
mkmat price wei
mat dir

matrix rename price y
matrix rename weight X
mat list X

* b = (X'X)^{-1}X'y
mat b = inv(X'*X)*X'*y
mat list b

reg price wei // 验证系数


/*
2. 矩阵的进阶操作
2.1 交乘矩阵
matrix accum 的定义：
matrix accum (A) = A’*A，
其中,A = (x1,x2,x3……)；

matrix vecaccum 的定义：matrix vecaccum(A) = x1’*X, 
其中，X = (x2,x3,……)。
*/


*-eg1- 线性模型的 OLS 估计 
*-目的：求取 b = inv(X'X)*X'y
* 其中，y = price, 
*       X =(weight,mpg,Cons)

*-eg1- 线性模型的 OLS 估计 
*-目的：求取 b = inv(X'X)*X'y
* 其中，y = price, 
*       X =(weight,mpg,Cons)

sysuse auto, clear
* 方法1：仅使用 matrix accum 命令
* 思路: 若 A = (y, X)， 则
*
*                                       [ y'y  y'X ]
*   mat accum (A) = S = (y, X)'(y, X) = [          ]
*                                       [ X'y  X'X ]
matrix accum S = price weight mpg  // y=price, X=[weight mpg]
mat list S
matrix XX = S[2..., 2...] 
matrix Xy = S[2..., 1]
mat b = inv(XX)*Xy
mat list b
reg price weight mpg,nohead       // 检验上述结果

* 方法2：结合使用 matrix accum 和 matrix vecaccum
mat accum XX = weight mpg
mat vecaccum yX = price weight mpg
mat Xy = yX'
mat b = inv(XX)*Xy
mat list b
reg price weight mpg, noheader   // 检验上述结果
* -eg2- 获取变量的相关系数矩阵
sysuse auto, clear
corr price weight mpg length
* 加权交乘矩阵   -mat glsaccum-
matrix glsaccum A = varlist [if] [in] [weight], group(groupvar) glsmat(W|stringvar) row(rowvar) [noconstant]   // 基本语法
*-mat glsaccum 的定义：mat glsaccum(X) = S = X'BX
* 其中，B 为权重矩阵，定义如下：
*       [ W_1   0   ...   0  ]
*       |  0   W_2  ...   0  |
*   B = |  .    .    .    .  |    W_k(k=1,2,...,K) 表示第 k 组观察值的权重矩阵，是一个方阵
*       |  .    .     .   .  |
*       [  0    0   ...  W_k ]
*  若 X 也根据组别定义，则可表示为：
*        [ X_1 ]
*        | X_2 | 
*    X = |  .  |
*        |  .  | 
*        [ X_k ]
*  由此可以更为细致的了解到 glsaccum 的定义方式：X'BX = X1'W1X1 + X2'W2X2 + ... + X_k'*W_k*X_k 
*- 应用举例：White(1980) 异方差稳健性标准误的计算
*  
*  Var(b) = inv(X'X)*(X'WX)*inv(X'X)  // White(1980)稳健性方差-协方差矩阵 
*
*  其中，
*  
*       [ e1^2   0    ...    0  ]
*       |  0    e2^2  ...    0  |
*   W = |  .     .     .     .  |
*       |  .     .     .     .  |
*       [  0     0    ...  eN^2 ]  NXN 矩阵
*
*  ei 表示第 i 个观察值对应的残差
*
*  问题的关键：求得 (X'WX) 矩阵即可，可采用 -mat glsaccum- 命令  
sysuse auto, clear
*-1 获得OLS估计值
mat accum XX = weight mpg
mat vecaccum yX = price weight mpg
mat Xy = yX'
mat b = inv(XX)*Xy
mat list b
*-2 求取残差之平方向量：e2
mkmat price, mat(y)
gen cons = 1
mkmat wei len mpg cons, mat(X) // 注意附加常数项
mat e = y - X*b                // 残差向量

