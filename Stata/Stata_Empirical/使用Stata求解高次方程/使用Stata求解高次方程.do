/*
正以stata为工具学习统计学，其中在平均发展速度计算中有一个高次方程，如
x+x^2+x^3+x^4+x^5=100
求解x
*/

/* 可以使用Stata绘图，很粗浅地看一下x在实数上的可能解.函数与水平线交叉的那一点对到的x 即x在实数上的可能解
*/

graph tw function x^5+x^4+x^3+x^2+x-100,range(-3 3) yline(0, lstyle(foreground))



clear
set obs 1000000
gen d = .
gen x = .
local j = 1
forvalues x = 2(0.000001)3{
  qui replace x = `x' in `j'
  local d = `x' +`x'^2 +`x'^3 +`x'^4 +`x'^5 - 100
  qui replace d = abs(`d') in `j++'
  *dis in y "." _c
}
sort d
br
sort x
line d x   //有点动画的效果



/*
易知f(x)=x^5+x^4+x^3+x^2+x-100在正实数区间上是增函数，且其零解属于(2.239, 2.24)。可使用mata：
*/

mata
for (i=2.239;i<=2.24;i=i+.0000001) {
if (abs(i+i^2+i^3+i^4+i^5-100)<0.00001) i
}
end


/*
可利用命令nl，编写程序解决之

假设要求方程：1.47/(1+X)+2.56/(1+X)^2+3.19/(1+X)^3-7=0  的解，求解步骤如下：
*/

*第一步
clear all
program nlfaq
syntax varlist(min=1 max=1) [if], at(name)
tempname X A B C
scalar `X' = `at'[1, 1]
scalar `A' = `at'[1, 2]
scalar `B' = `at'[1, 3]
scalar `C' = `at'[1, 4]
tempvar yh
gen double `yh' = 1.47/(1+`X')+2.56/(1+`X')^2+3.19/(1+`X')^3-6 in 1
replace `yh' = `A'- (1+`X') in 2
replace `yh' = `B'-(1+`X')^2 in 3
replace `yh' = `C'-(1+`X')^3 in 4
replace `varlist' = `yh'
end

*第二步
clear
set obs 4
generate y = 0
replace y = 1 in 1

*最后求解
nl faq @ y, parameters(X A B C) initial(X 1 A 1 B 1 C 1)

/*
计算结果如下所示：
 
(obs = 4)

Iteration 0:  residual SS =  76.58403
Iteration 1:  residual SS =  32.03028
Iteration 2:  residual SS =   .011014
Iteration 3:  residual SS =  1.44e-06
Iteration 4:  residual SS =  2.56e-14
Iteration 5:  residual SS =  4.44e-31

      Source |       SS       df       MS
-------------+------------------------------         Number of obs =         4
       Model |           1     4         .25         R-squared     =    1.0000
    Residual |  4.4373e-31     0           .         Adj R-squared =         .
-------------+------------------------------         Root MSE      =         .
       Total |           1     4         .25         Res. dev.     =  -273.754

------------------------------------------------------------------------------
           y |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
          /X |   .0139472          .        .       .            .           .
          /A |   1.013947          .        .       .            .           .
          /B |   1.028089          .        .       .            .           .
          /C |   1.042428          .        .       .            .           .
------------------------------------------------------------------------------

可以看出，方程的解 X＝.0139472
*/



*我记得经济研究有一篇论文就是做这个，他也是用这个stata程序写的NLS估计

*-----------------   
* 模型的基本架构
*    program define nlfcn
*      version 8.0  
*      if "`1'" == "?"{
*          global S_1 "参数名称"
*          (global... 设定参数的初始值)
*          exit
*      replace `1' = ...定义模型的形式
*    end
* 执行：
*   nl 程序名称 被解释变量
*一下举个例子说明

capt prog drop nligmm  //检查已有程序名，发现与nlequ同名的则删去
program define nligmm  
if "`1'"== "?" {
global S_1 " rho sigma2 " //设定输入项
global rho=1
global sigma2=1
exit
}
replace `1'=gx1*rho+gx2∗rho^2 +gx3*$sigma2  // 要估计的方程，你可以吧你的方程依据r精简改造一下写出即可。
end
