view browse "https://www.dazhuanlan.com/2019/09/24/5d8a34c9ad406/"

clear all

* 1.定义矩阵
matrix 矩阵名 = (1,2,3 \ 4,5,6)  

* 2.管理矩阵

** 2.1 列示矩阵
matrix list 矩阵名 [, noblank nohalf noheader nonames format(%fmt) title(string) nodotz]       // 列示矩阵

* 更为细致地列示矩阵
#delimit ;
matrix Htest = ( 12.30,  2,  .00044642 \  
                  2.17,  1,  .35332874 \                     
                  8.81,  3,  .04022625 \ 
                 20.05,  6,  .00106763  ) ;
#delimit cr
matrix rownames Htest = trunk length weight overall  // 定义行名
matrix colnames Htest = chi2 df p                    // 定义列名
matlist Htest                                        // 添加边框
matrix rename 原矩阵名 新矩阵名    // 矩阵更名  

* 2.2 矩阵的行数和列数
matrix 矩阵名 = (1,2,3 \ 4,5,6)
scalar ra = rowsof(矩阵名)  // rows
scalar ca = colsof(矩阵名) // columns
dis in g "矩阵 矩阵名 的行数是: " in y ra 
dis in g "矩阵 矩阵名 的列数是: " in y ca  
matrix dir                   // 查找矩阵
matrix drop 矩阵名           // 删除矩阵       
display matmissing(矩阵名)   // 显示矩阵缺漏值个数

* 2.3 矩阵的行名和列名
matrix rownames 矩阵名 = 行名(空格分隔)       // 行名
matrix colnames 矩阵名 = 列名(空格分隔)       // 列名

* 2.4 矩阵的选择
matrix 新矩阵名 = 矩阵名[行索引,列索引]        // 中间省略：.. 全部省略：.... 尾部省略：...
matrix 矩阵中想要修改的元素 = 修改值           // 如果想要修改区域，只需在等号左侧填入修改区域左上角的元素位置即可
* 2.5 矩阵的合并
matrix aa  = [a1, a2]   // 横向合并两个矩阵 
matrix aaa = [a1  a2]  // 纵向追加两个矩阵

* 2.6 常用矩阵的定义
matrix I = I(n)         // 单位矩阵
matrix 矩阵名 = J(行数,列数,常数)
matrix r3 = matuniform(10,4)  // 生成一个10*4的随机数矩阵，随机数区间为(0,1)

* 2.7 将一维矩阵转换成对角矩阵
mat u = J(5,1,-0.5)
mat du = diag(u)  // 取出对角元素

*将变量转换为矩阵
mkmat varlist [if] [in] [, matrix(matname) nomissing   // 单变量：矩阵名默认为变量名，选项nomissing表示仅包含非缺漏值
* 将矩阵转化为变量
xsvmat 矩阵名, list(,)                                 // 以变量方式列示矩阵的内容
* 用矩阵存储统计结果
 makematrix [matrix_name], from(results_list) [production_options] [list_options]:["]command["] [varlist] ... [, options ]

 * 矩阵运算
 mgen exprlist , in(matname) out(matname) [ common(term) ]   // in-进行操作的矩阵 out-新矩阵 exprlist：数学表达式
 
 * 保存矩阵
 matsave matrix [, replace saving dropall path(path) type(type) ]  // 保存到dta中
 mat2txt , matrix(matrixname) saving(filename) [ title(text) note(text) format(formatlist) replace append ] // 保存为txt格式
 dataout <using filename> [, options]   // word:转成rtf格式的word文档 excel:转成xml格式的excel文档

* 3. 操作矩阵

* 3.1 基本运算
matrix A = (1,23,4)
matrix B = (5,79,2)
matrix C = A+B             // 加法
matrix B = A-B             // 减法
matrix X = (1,12,58,04,5)
matrix C = 3*X*A'*B        // 乘法
matrix D = (X'*X - A'*A)/4
matrix D = A#D               // 直乘
matrix E = hadamard(A,B)     // Hadamard乘法

* 3.2矩阵元素的数学变换
math B = function(A)         // 可供调用的function： help math functions
mgen exprlist , in(matname) out(matname) [ common(term) ]  // 分列变换："v1=ln(c1)" 不可以写为 "v1 = ln(c1)"

* 3.3 矩阵与单值的运算
scalar c = 5                 // 单值c
mat D = J(4,4,1)             // 矩阵D
mat Dc = D*c                 // mat cD = c*D   矩阵与单值相乘
mat D_c = D/c                // 矩阵与单值相除
* 矩阵的转置: 行列互换
matrix A = (-1, 2  3, 4 )
mat At = A'                  // 转置运算优先于乘法运算
* 3.4 矩阵的逆矩阵
scalar detA = det(A)         // 矩阵的行列式
dis issym(A)                 // 判断一个矩阵是否为对称矩阵
mat invA = inv(A)            // 求矩阵的逆矩阵
* 3.5矩阵的向量化
mat vA = vec(A)
mat dA = vecdiag(A)          // 向量化方阵的对角元素
* 3.6 矩阵的对角值(trace)
matrix Atr = trace(A)        // 方阵的对角元素之和

/*
2. 矩阵的进阶操作
2.1 交乘矩阵
  matrix accum 的定义：atrix accum (A) = A’*A，其中,A = (x1,x2,x3……)；matrix vecaccum 的定义：matrix vecaccum(A) = x1’*X, 其中，X = (x2,x3,……)。
*/

matrix accum A = varlist [if] [in] [weight] [, noconstant deviations means(M) absorb(varname)]  // matrix accum 语法
matrix vecaccum a = varlist [if] [in] [weight] [, noconstant]                                   // matrix vecaccum语法
*- 几个重要选项：
*  (1) noconstant 不在 X 矩阵中自动附加常数项；
*  (2) deviation  采用离差的形式

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
