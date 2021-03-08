对于一元线性回归模型

![[公式]](https://www.zhihu.com/equation?tex=Y_i%3D%5Cbeta_0%2B%5Cbeta_1X_i%2Bu_i)

**普通最小二乘法（OLS, ordinary least squares）**给出其拟合标准，即应使被解释变量的估计值与实际观测值之差的平方和

![[公式]](https://www.zhihu.com/equation?tex=Q+%3D+%5Csum+_+%7B+i+%3D+1+%7D+%5E+%7B+n+%7D+%5Cleft%28+Y+_+%7B+i+%7D+-+%5Chat+%7B+Y+%7D+_+%7B+i+%7D+%5Cright%29+%5E+%7B+2+%7D+%3D+%5Csum+_+%7B+i+%3D+1+%7D+%5E+%7B+n+%7D+%5Cleft%5B+Y+_+%7B+i+%7D+-+%5Cleft%28+%5Chat+%7B+%5Cbeta+%7D+_+%7B+0+%7D+%2B+%5Chat+%7B+%5Cbeta+%7D+_+%7B+1+%7D+X+_+%7B+i+%7D+%5Cright%29+%5Cright%5D+%5E+%7B+2+%7D)

最小。此时得到的 ![[公式]](https://www.zhihu.com/equation?tex=%5Chat+%5Cbeta_0%2C%5C+%5Chat+%5Cbeta_1) 被称为**普通最小二乘估计量（OLS estimators）**。

为求两估计量，使上式一阶偏导数为零：

![[公式]](https://www.zhihu.com/equation?tex=%5Cleft%5C%7B+%5Cbegin%7Barray%7D+%7B+l+%7D+%7B+%5Cfrac+%7B+%5Cpartial+Q+%7D+%7B+%5Cpartial+%5Chat+%7B+%5Cbeta+%7D+_+%7B+0+%7D+%7D+%3D+0+%7D+%5C%5C+%7B+%5Cfrac+%7B+%5Cpartial+Q+%7D+%7B+%5Cpartial+%5Chat+%7B+%5Cbeta+%7D+_+%7B+1+%7D+%7D+%3D+0+%7D+%5Cend%7Barray%7D+%5Cright.) ，可推得 ![[公式]](https://www.zhihu.com/equation?tex=%5Cleft%5C%7B+%5Cbegin%7Barray%7D+%7B+l+%7D+%7B+%5Csum+%5Cleft%28+Y+_+%7B+i+%7D+-+%5Chat+%7B+%5Cbeta+%7D+_+%7B+0+%7D+-+%5Chat+%7B+%5Cbeta+%7D+_+%7B+1+%7D+X+_+%7B+i+%7D+%5Cright%29+%3D+0+%7D+%5C%5C+%7B+%5Csum+%5Cleft%28+Y+_+%7B+i+%7D+-+%5Chat+%7B+%5Cbeta+%7D+_+%7B+0+%7D+-+%5Chat+%7B+%5Cbeta+%7D+_+%7B+1+%7D+X+_+%7B+i+%7D+%5Cright%29+X+_+%7B+i+%7D+%3D+0+%7D+%5Cend%7Barray%7D+%5Cright.) ，解得

![[公式]](https://www.zhihu.com/equation?tex=%5Cleft%5C%7B+%5Cbegin%7Barray%7D+%7B+l+%7D+%7B+%5Chat+%7B+%5Cbeta+%7D+_+%7B+1+%7D+%3D+%5Cfrac+%7B+%5Csum+x+_+%7B+i+%7D+y+_+%7B+i+%7D+%7D+%7B+%5Csum+x+_+%7B+i+%7D+%5E+%7B+2+%7D+%7D+%7D+%5C%5C+%7B+%5Chat+%7B+%5Cbeta+%7D+_+%7B+0+%7D+%3D+%5Coverline+%7B+Y+%7D+-+%5Chat+%7B+%5Cbeta+%7D+_+%7B+1+%7D+%5Coverline+%7B+X+%7D+%7D+%5Cend%7Barray%7D+%5Cright.)

在这里我们习惯用小写字母表示对均值的离差，也就是

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Baligned%7D+++%5Csum+x+_+%7B+i+%7D+y+_+%7B+i+%7D+%26+%3D+%5Csum+%5Cleft%28+X+_+%7B+i+%7D+-+%5Coverline+%7B+X+%7D+%5Cright%29+%5Cleft%28+Y+_+%7B+i+%7D+-+%5Coverline+%7B+Y+%7D+%5Cright%29+%5C%5C+%26+%3D+%5Csum+X+_+%7B+i+%7D+Y+_+%7B+i+%7D+-+%5Cfrac+%7B+1+%7D+%7B+n+%7D+%5Csum+X+_+%7B+i+%7D+%5Csum+Y+_+%7B+i+%7D++%5C%5C%5C%5C++%5Csum+x+_+%7B+i+%7D+%5E+%7B+2+%7D+%26+%3D+%5Csum+%5Cleft%28+X+_+%7B+i+%7D+-+%5Coverline+%7B+X+%7D+%5Cright%29+%5E+%7B+2+%7D+%5C%5C+%26+%3D+%5Csum+X+_+%7B+i+%7D+%5E+%7B+2+%7D+-+%5Cfrac+%7B+1+%7D+%7B+n+%7D+%5Cleft%28+%5Csum+X+_+%7B+i+%7D+%5Cright%29+%5E+%7B+2+%7D++%5Cend%7Baligned%7D)

------

关于线性回归方程，我们给出三个**最小二乘假设（least squares assumptions）**。

假设一：

![[公式]](https://www.zhihu.com/equation?tex=%5Coperatorname+E%28u_i+%5C%2C+%7C%5C%2C++X_i%29%3D0)

假设二：

![[公式]](https://www.zhihu.com/equation?tex=%28X_i%2C+Y_i%29%2C%5C+i%3D1%2C%5Ccdots+%2Cn%5C++%5C+%5Crm+is+%5C+%5C+i.i.d.)

假设三：

![[公式]](https://www.zhihu.com/equation?tex=0%3C%5Coperatorname+E%28X_i%5E4%29%3C+%5Cinfty%2C%5C+0%3C%5Coperatorname+E%28Y_i%5E4%29%3C+%5Cinfty)



这些假设的成立可用于说明 OLS 方法的有效性。

------

为导出一些有用的性质，在这里介绍**同方差（homoskedastic）**的概念：

对每一 ![[公式]](https://www.zhihu.com/equation?tex=i%3D1%2C%5Ccdots%2Cn) ，给定 ![[公式]](https://www.zhihu.com/equation?tex=X_i) 时有 ![[公式]](https://www.zhihu.com/equation?tex=%5Coperatorname+%7BVar%7D%28u_i%5C%2C+%7C%5C%2C+X_i%29) 总为相同常数，则称误差项 ![[公式]](https://www.zhihu.com/equation?tex=u_i) 为同方差的；否则，是**异方差的（heteroskedastic）**。

当我们说**同方差假设**是指，认为误差项是同方差的。

------

**高斯 - 马尔可夫（Gauss-Markov）条件**为

1 . ![[公式]](https://www.zhihu.com/equation?tex=%5Coperatorname+%7B+E+%7D+%5Cleft%28+u+_+%7B+i+%7D%5C%2C+%7C+X+_+%7B+1+%7D+%2C+%5Ccdots+%2C+X+_+%7B+n+%7D+%5Cright%29+%3D+0)

2 . ![[公式]](https://www.zhihu.com/equation?tex=%5Coperatorname+%7B+Var+%7D+%5Cleft%28+u+_+%7B+i+%7D%5C%2C+%7C%5C%2C+X+_+%7B+1+%7D%2C+%5Ccdots+%2C+X+_+%7B+n+%7D+%5Cright%29+%3D+%5Csigma+_+%7B+u+%7D+%5E+%7B+2+%7D+%2C%5C+0+%3C+%5Csigma+_+%7B+u+%7D+%5E+%7B+2+%7D+%3C+%5Cinfty)

3 . ![[公式]](https://www.zhihu.com/equation?tex=%5Coperatorname+%7B+E+%7D+%5Cleft%28+u+_+%7B+i+%7D+u+_+%7B+j+%7D+%5C%2C+%7C+%5C%2C+X+_+%7B+1+%7D++%2C+%5Ccdots+%2C+X+_+%7B+n+%7D+%5Cright%29+%3D+0+%2C%5C+i+%5Cneq+j)

由最小二乘假设一，易得条件一成立；

由同方差假设与最小二乘假设三，易得条件二成立；

由最小二乘假设二，得 ![[公式]](https://www.zhihu.com/equation?tex=%5Coperatorname+%7B+E+%7D+%5Cleft%28+u+_+%7B+i+%7D+u+_+%7B+j+%7D+%5C%2C+%7C+%5C%2C+X+_+%7B+1+%7D++%2C+%5Ccdots+%2C+X+_+%7B+n+%7D+%5Cright%29%3D%5Coperatorname+%7B+E+%7D+%5Cleft%28+u+_+%7B+i+%7D+%5C%2C+%7C+%5C%2C+X+_+%7B+i+%7D++%5Cright%29%5Coperatorname+%7B+E+%7D+%5Cleft%28+u+_+%7B+j+%7D+%5C%2C+%7C+%5C%2C+X+_+%7B+j+%7D++%5Cright%29) ，

再由假设一，有 ![[公式]](https://www.zhihu.com/equation?tex=%5Coperatorname+%7B+E+%7D+%5Cleft%28+u+_+%7B+i+%7D+%5C%2C+%7C+%5C%2C+X+_+%7B+i+%7D++%5Cright%29%3D%5Coperatorname+%7B+E+%7D+%5Cleft%28+u+_+%7B+j+%7D+%5C%2C+%7C+%5C%2C+X+_+%7B+j+%7D++%5Cright%29%3D0) ，便得条件三成立。

故可知，当最小二乘三假设和同方差假设成立时，有**高斯 - 马尔可夫条件**成立。



**高斯 - 马尔可夫定理（Gauss-Markov Theorem）**指出，在**高斯 - 马尔可夫条件**成立时，OLS 估计量 ![[公式]](https://www.zhihu.com/equation?tex=%5Chat+%5Cbeta) 是**最佳线性无偏估计量（BLUE, Best Linear unbiased estimator）**。



证明如下：

### **线性**

在这里是指 ![[公式]](https://www.zhihu.com/equation?tex=%5Chat+%5Cbeta_0%2C%5C+%5Chat+%5Cbeta_1) 是 ![[公式]](https://www.zhihu.com/equation?tex=Y_i) 的线性组合。由上文出发开始推导，有

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Baligned%7D+%5Chat+%7B+%5Cbeta+%7D+_+%7B+1+%7D+%26+%3D+%5Cfrac+%7B+%5Csum+x+_+%7B+i+%7D+y+_+%7B+i+%7D+%7D+%7B+%5Csum+x+_+%7B+i+%7D+%5E+%7B+2+%7D+%7D+%3D+%5Cfrac+%7B+%5Csum+x+_+%7B+i+%7D+%28+Y+_+%7B+i+%7D+-+%5Coverline+%7B+Y+%7D+%29+%7D+%7B+%5Csum+x+_+%7B+i+%7D+%5E+%7B+2+%7D+%7D+%5C%5C+%26+%3D+%5Cfrac+%7B+%5Csum+x+_+%7B+i+%7D+Y+_+%7B+i+%7D+%7D+%7B+%5Csum+x+_+%7B+i+%7D+%5E+%7B+2+%7D+%7D+-+%5Cfrac+%7B+%5Coverline+%7B+Y+%7D+%5Csum+x+_+%7B+i+%7D+%7D+%7B+%5Csum+x+_+%7B+i+%7D+%5E+%7B+2+%7D+%7D++%5Cend%7Baligned%7D)

对于离差 ![[公式]](https://www.zhihu.com/equation?tex=x_i) ，注意有

![[公式]](https://www.zhihu.com/equation?tex=%5Csum+x_i%3D%5Csum+%7B%28X_i-%5Coverline+X%29%7D%3D%5Csum+X_i-n%5Coverline+X%3D0)

所以有

![[公式]](https://www.zhihu.com/equation?tex=+%5Chat+%7B+%5Cbeta+%7D+_+%7B+1+%7D++%3D+%5Cfrac+%7B+%5Csum+x+_+%7B+i+%7D+Y+_+%7B+i+%7D+%7D+%7B+%5Csum+x+_+%7B+i+%7D+%5E+%7B+2+%7D+%7D%3D%5Csum+k+_+%7B+i+%7D+Y+_+%7B+i+%7D) ，其中 ![[公式]](https://www.zhihu.com/equation?tex=k+_+%7B+i+%7D+%3D+%5Cfrac+%7B+x+_+%7B+i+%7D+%7D+%7B+%5Csum+x+_+%7B+i+%7D+%5E+%7B+2+%7D+%7D) ，

**![[公式]](https://www.zhihu.com/equation?tex=+%5Chat+%7B+%5Cbeta+%7D+_+%7B+1+%7D+) 的线性得证。**同样可得

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Baligned%7D+%5Chat+%7B+%5Cbeta+%7D+_+%7B+0+%7D+%26+%3D+%5Coverline+%7B+Y+%7D+-+%5Chat+%7B+%5Cbeta+%7D+_+%7B+1+%7D+%5Coverline+%7B+X+%7D+%3D+%5Cfrac+%7B+1+%7D+%7B+n+%7D+%5Csum+Y+_+%7B+i+%7D+-+%5Csum+k+_+%7B+i+%7D+Y+_+%7B+i+%7D+%5Coverline+%7B+X+%7D+%5C%5C+%26+%3D+%5Csum+%28+%5Cfrac+%7B+1+%7D+%7B+n+%7D+-+%5Coverline+%7B+X+%7D+k+_+%7B+i+%7D+%29+Y+_+%7B+i+%7D+%3D+%5Csum+w+_+%7B+i+%7D+Y+_+%7B+i+%7D+%5Cend%7Baligned%7D)

其中 ![[公式]](https://www.zhihu.com/equation?tex=w+_+%7B+i+%7D+%3D+%5Cfrac+%7B+1+%7D+%7B+n+%7D+-+%5Coverline+%7B+X+%7D+k+_+%7B+i+%7D) ，

**![[公式]](https://www.zhihu.com/equation?tex=+%5Chat+%7B+%5Cbeta+%7D+_+%7B+0+%7D+) 的线性得证。**



### **无偏性**

是指估计量 ![[公式]](https://www.zhihu.com/equation?tex=%5Chat+%5Cbeta_0%2C%5C+%5Chat+%5Cbeta_1) 的均值（期望）等于总体回归参数真值 ![[公式]](https://www.zhihu.com/equation?tex=+%5Cbeta_0%2C%5C++%5Cbeta_1) 。由线性的性质得

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Baligned%7D+%5Chat+%7B+%5Cbeta+%7D+_+%7B+1+%7D+%26+%3D+%5Csum+k+_+%7B+i+%7D+Y+_+%7B+i+%7D+%3D+%5Csum+k+_+%7B+i+%7D+%5Cleft%28+%5Cbeta+_+%7B+0+%7D+%2B+%5Cbeta+_+%7B+1+%7D+X+_+%7B+i+%7D+%2B+u+_+%7B+i+%7D+%5Cright%29+%5C%5C+%26+%3D+%5Cbeta+_+%7B+0+%7D+%5Csum+k+_+%7B+i+%7D+%2B+%5Cbeta+_+%7B+1+%7D+%5Csum+k+_+%7B+i+%7D+X+_+%7B+i+%7D+%2B+%5Csum+k+_+%7B+i+%7D+u+_+%7B+i+%7D+%5Cend%7Baligned%7D)

其中易得 ![[公式]](https://www.zhihu.com/equation?tex=%5Csum+k+_+%7B+i+%7D+%3D+%5Cfrac+%7B+%5Csum+x+_+%7B+i+%7D+%7D+%7B+%5Csum+x+_+%7B+i+%7D+%5E+%7B+2+%7D+%7D+%3D+0) ，以及

![[公式]](https://www.zhihu.com/equation?tex=%5Csum+k+_+%7B+i+%7D+X+_+%7B+i+%7D%3D+%5Cfrac+%7B%5Csum+x+_+%7B+i+%7DX_i+%7D+%7B+%5Csum+x+_+%7B+i+%7D+%5E+%7B+2+%7D+%7D+%3D%5Cfrac+%7B%5Csum+%7B%28X_i-%5Coverline+X%29%7DX_i+%7D+%7B%5Csum+%28+X+_+%7B+i+%7D+-+%5Coverline+%7B+X+%7D+%29+%5E+%7B+2+%7D+%7D+%3D%5Cfrac+%7B%5Csum+X+_+%7B+i+%7D+%5E+%7B+2+%7D+-+n%5Coverline+X%5E2+%7D+%7B%5Csum+X+_+%7B+i+%7D+%5E+%7B+2+%7D+-+%5Cfrac+%7B+1+%7D+%7B+n+%7D+%5Cleft%28+%5Csum+X+_+%7B+i+%7D+%5Cright%29+%5E+%7B+2+%7D++%7D+%3D+1)

故有 ![[公式]](https://www.zhihu.com/equation?tex=%5Chat+%7B+%5Cbeta+%7D+_+%7B+1+%7D+%3D+%5Cbeta+_+%7B+1+%7D+%2B+%5Csum+k+_+%7B+i+%7D+u+_+%7B+i+%7D) ，考察期望：

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Baligned%7D+%5Cmathrm+%7B+E+%7D+%28+%5Chat+%7B+%5Cbeta+%7D+_+%7B+1+%7D+%29+%26+%3D+%5Cmathrm+%7B+E+%7D+%5Cleft%28+%5Cbeta+_+%7B+1+%7D+%2B+%5Csum+k+_+%7B+i+%7D+u+_+%7B+i+%7D+%5Cright+%29+%5C%5C+%26+%3D+%5Cbeta+_+%7B+1+%7D+%2B+%5Csum_%7Bi%3D1%7D%5En+k+_+%7B+i+%7D%5Coperatorname+%7B+E+%7D+%5Cleft%28+u+_+%7B+i+%7D%5C%2C+%7C+X+_+%7B+1+%7D+%2C+%5Ccdots+%2C+X+_+%7B+n+%7D+%5Cright%29++%5C%5C%26%3D+%5Cbeta+_+%7B+1+%7D+%5Cend%7Baligned%7D)

这里已使用了高斯 - 马尔可夫条件一。类似地，就有

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Baligned%7D+%5Cmathrm+%7B+E+%7D%28+%5Chat+%7B+%5Cbeta+%7D+_+%7B+0+%7D+%29+%26+%3D+%5Cmathrm+%7B+E+%7D+%5Cleft%28+%5Cbeta+_+%7B+0+%7D+%2B+%5Csum+w+_+%7B+i+%7D+u+_+%7B+i+%7D+%5Cright%29+%5C%5C+%26+%3D+%5Cmathrm+%7B+E+%7D+%5Cleft%28+%5Cbeta+_+%7B+0+%7D+%5Cright%29+%2B+%5Csum_%7Bi%3D1%7D%5En+w+_+%7B+i+%7D+%5Coperatorname+%7B+E+%7D+%5Cleft%28+u+_+%7B+i+%7D%5C%2C+%7C+X+_+%7B+1+%7D+%2C+%5Ccdots+%2C+X+_+%7B+n+%7D+%5Cright%29%5C%5C%26%3D+%5Cbeta+_+%7B+0+%7D+%5Cend%7Baligned%7D)

**至此，无偏性得证。**



### **有效性（最佳方差）**

有效性，是指在所有的线性无偏估计量中，OLS 估计量具有最小方差。

首先计算方差

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Baligned%7D+%5Coperatorname+%7BVar%7D%28%5Chat+%5Cbeta_1%29%26%3D%5Coperatorname+%7BVar%7D%5Cleft%28%5Cbeta_1%2B%5Csum+k+_+%7B+i+%7D+u+_+%7B+i+%7D%5Cright+%29%5C%5C+%26%3D%5Coperatorname+%7BVar%7D%5Cleft%28%5Csum+k+_+%7B+i+%7D+u+_+%7B+i+%7D%5Cright+%29%5C%5C+%26%3D%5Csum_%7Bi%3D1%7D%5En%5Csum_%7Bj%3D1%5C%5Cj%5Cneq+i+%7D%5Enk_ik_j%5Coperatorname%7BCov%7D+%5Cleft%28+u+_+%7B+i+%7D+%2Cu+_+%7B+j+%7D+%5C%2C+%7C+%5C%2C+X+_+%7B+1+%7D++%2C+%5Ccdots+%2C+X+_+%7B+n+%7D+%5Cright%29+%2B%5Csum_%7Bi%3D1%7D%5Enk_i%5E2%5Coperatorname+%7B+Var+%7D+%5Cleft%28+u+_+%7B+i+%7D%5C%2C+%7C%5C%2C+X+_+%7B+1+%7D+%2C+%5Ccdots+%2C+X+_+%7B+n+%7D+%5Cright%29++%5Cend%7Baligned%7D)

上式中

![[公式]](https://www.zhihu.com/equation?tex=%5Coperatorname%7BCov%7D+%5Cleft%28+u+_+%7B+i+%7D+%2Cu+_+%7B+j+%7D+%5Cright%29%3D%5Coperatorname%7BE%7D%28u+_+%7B+i+%7D+u+_+%7B+j+%7D+%29+-%5Coperatorname%7BE%7D%28u+_+%7B+i+%7D+%29%5Coperatorname%7BE%7D%28u+_+%7B+j%7D+%29)

由高斯 - 马尔可夫条件三， ![[公式]](https://www.zhihu.com/equation?tex=%5Coperatorname%7BE%7D%28u+_+%7B+i+%7D+u+_+%7B+j+%7D+%29+%3D+0) ；

由高斯 - 马尔可夫条件一， ![[公式]](https://www.zhihu.com/equation?tex=%5Coperatorname%7BE%7D%28u+_+%7B+i+%7D+%29%3D%5Coperatorname%7BE%7D%28u+_+%7B+j%7D+%29%3D0) ，故有

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Baligned%7D+%5Coperatorname+%7BVar%7D%28%5Chat+%5Cbeta_1%29%26%3D%5Csum_%7Bi%3D1%7D%5Enk_i%5E2%5Coperatorname+%7B+Var+%7D+%5Cleft%28+u+_+%7B+i+%7D%5C%2C+%7C%5C%2C+X+_+%7B+1+%7D+%2C+%5Ccdots+%2C+X+_+%7B+n+%7D+%5Cright%29++%5Cend%7Baligned%7D)

又由高斯 - 马尔可夫条件二，有

![[公式]](https://www.zhihu.com/equation?tex=+%5Coperatorname+%7BVar%7D%28%5Chat+%5Cbeta_1%29%3D%5Csigma+_u%5E2%5Csum+k_i%5E2)

完全类似地，得到

![[公式]](https://www.zhihu.com/equation?tex=+%5Coperatorname+%7BVar%7D%28%5Chat+%5Cbeta_0%29%3D%5Csigma+_u%5E2%5Csum+w_i%5E2)



考察另一对线性无偏估计量

![[公式]](https://www.zhihu.com/equation?tex=%5Chat+%7B+%5Cbeta+%7D+_+%7B+1+%7D+%5E+%7B+%27+%7D+%3D+%5Csum+k%5E%7B%27%7D+_+%7B+i+%7D+Y+_+%7B+i+%7D%2C%5C+%5Chat+%7B+%5Cbeta+%7D+_+%7B+0+%7D+%5E+%7B+%27+%7D+%3D+%5Csum+w%5E%7B%27%7D+_+%7B+i+%7D+Y+_+%7B+i+%7D)

其中不妨令 ![[公式]](https://www.zhihu.com/equation?tex=k%5E%7B%27%7D+_+%7Bi%7D%3Dk_i%2Bd_i%2C%5C+w%5E%7B%27%7D+_+%7Bi%7D%3Dw_i%2Bd_i) ， ![[公式]](https://www.zhihu.com/equation?tex=d_i) 为任意常数。



考察其方差

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Baligned%7D+%5Coperatorname+%7BVar%7D%28%5Chat+%5Cbeta_1%5E%7B%27%7D%29%26%3D%5Csigma+_u%5E2+%7B%5Csum+%7Bk%5E%7B%27%7D_i%7D%5E2%7D%5C%5C+%26%3D%5Csigma+_u%5E2+%7B%5Csum+%28%7Bk_i%2Bd_i%7D%29%5E2%7D%5C%5C+%26%3D%5Csigma+_u%5E2%5Cleft%28+%5Csum+k_i%5E2%2B%5Csum+d_i%5E2%2B2%5Csum+k_id_i+%5Cright%29%5C%5C+%5Cend%7Baligned%7D)

其中

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Baligned%7D+%5Csum+k_id_i%26%3D%5Cfrac+%7B%5Csum+%7B%28X_i-%5Coverline+X%29%7Dd_i+%7D+%7B%5Csum+%28+X+_+%7B+i+%7D+-+%5Coverline+%7B+X+%7D+%29+%5E+%7B+2+%7D+%7D++%5C%5C%26%3D%5Cfrac+%7B%5Csum+%7Bd_iX_i-%5Coverline+X+%5Csum+d_i%7D+%7D+%7B%5Csum+%28+X+_+%7B+i+%7D+-+%5Coverline+%7B+X+%7D+%29+%5E+%7B+2+%7D+%7D++%5C%5C+%5Cend%7Baligned%7D)

其中

![[公式]](https://www.zhihu.com/equation?tex=%5Csum+d+_+%7B+i+%7DX_i+%3D%5Csum+k%5E%7B%27%7D+_+%7B+i+%7D+X_i+-%5Csum+k+_+%7B+i+%7D+X_i%3D1-1%3D+0)

![[公式]](https://www.zhihu.com/equation?tex=%5Csum+d+_+%7B+i+%7D+%3D%5Csum+k%5E%7B%27%7D+_+%7B+i+%7D+-%5Csum+k+_+%7B+i+%7D+%3D+0)

所以有

![[公式]](https://www.zhihu.com/equation?tex=%5Csum+k_id_i%3D0) ，故

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Baligned%7D+%5Coperatorname+%7BVar%7D%28%5Chat+%5Cbeta_1%5E%7B%27%7D%29+%26%3D%5Csigma+_u%5E2%5Cleft%28+%5Csum+k_i%5E2%2B%5Csum+d_i%5E2%5Cright%29%5C%5C+%26%3D%5Coperatorname+%7BVar%7D%28%5Chat+%5Cbeta_1%29%2B%5Csigma+_u%5E2%5Csum+d_i%5E2+%5Cend%7Baligned%7D)

**此式说明 ![[公式]](https://www.zhihu.com/equation?tex=+%5Coperatorname+%7BVar%7D%28%5Chat+%5Cbeta_1%5E%7B%27%7D%29+%5Cgeq+%5Coperatorname+%7BVar%7D%28%5Chat+%5Cbeta_1%29+)**



又有

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Baligned%7D+%5Coperatorname+%7BVar%7D%28%5Chat+%5Cbeta_0%5E%7B%27%7D%29%26%3D%5Csigma+_u%5E2+%7B%5Csum+%7Bw%5E%7B%27%7D_i%7D%5E2%7D%5C%5C+%26%3D%5Csigma+_u%5E2+%7B%5Csum+%28%7Bw_i%2Bd_i%7D%29%5E2%7D%5C%5C+%26%3D%5Csigma+_u%5E2%5Cleft%28+%5Csum+w_i%5E2%2B%5Csum+d_i%5E2%2B2%5Csum+w_id_i+%5Cright%29%5C%5C+%5Cend%7Baligned%7D)

其中

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Baligned%7D+%5Csum+w_id_i%26%3D%5Csum+%5Cleft%28+%7B1%5Cover+n%7D-%5Coverline+Xk_i%5Cright%29d_i+%5C%5C%26%3D%7B1%5Cover+n%7D%5Csum+d_i-%5Coverline+X%5Csum+k_i+d_i+%5C%5C%26%3D0+%5Cend%7Baligned%7D)

故

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Baligned%7D+%5Coperatorname+%7BVar%7D%28%5Chat+%5Cbeta_0%5E%7B%27%7D%29+%26%3D%5Csigma+_u%5E2%5Cleft%28+%5Csum+w_i%5E2%2B%5Csum+d_i%5E2%5Cright%29%5C%5C+%26%3D%5Coperatorname+%7BVar%7D%28%5Chat+%5Cbeta_0%29%2B%5Csigma+_u%5E2%5Csum+d_i%5E2+%5Cend%7Baligned%7D)

**此式说明 ![[公式]](https://www.zhihu.com/equation?tex=+%5Coperatorname+%7BVar%7D%28%5Chat+%5Cbeta_0%5E%7B%27%7D%29+%5Cgeq+%5Coperatorname+%7BVar%7D%28%5Chat+%5Cbeta_0%29+)**

**于是 OLS 估计量的有效性得证。**

------

至此我们已在高斯 - 马尔可夫条件下导出 OLS 估计量的线性、无偏性、有效性，也就是**高斯 - 马尔可夫定理（Gauss-Markov Theorem）**得证**：**

在**高斯 - 马尔可夫条件**成立时，OLS 估计量 ![[公式]](https://www.zhihu.com/equation?tex=%5Chat+%5Cbeta) 是**最佳线性无偏估计量（BLUE）**。