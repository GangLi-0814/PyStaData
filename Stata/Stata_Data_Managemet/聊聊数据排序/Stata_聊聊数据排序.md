# 前言

最近在忙着处理一些事情，公众号好久没有更新。虽然后面事情会越来越多，但还是希望能够坚持输出和更新。之前有朋友在后台留言希望有一些基础教程，所以最近打算有空就写点基础文章。如果大家有啥主题或者想了解的方面，欢迎在后台留言，我如果有时间也可以写写。

今天，就一起来看看使用 Stata 实现数据排序的几种方式，分别是：正序、逆序、乱序和自定义排序。

# 实现过程

## 正序

```
sysuse auto, clear

* 单个变量
sort price

*多个变量
sort price rep78
```

## 逆序

```
sysuse auto, clear

* 单个变量
gsort -price

*多个变量
gsort -price rep78 // price逆序，rep78正序
```

## 乱序

### 方式一：-rsort- 命令

使用外部命名 `rsort`，需要先输入 `ssc install rsort, replace` 进行安装，其基本语法如下：

```Stata

        rsort [, options]

    options                 Description
    -----------------------------------------------------------

    Required for reproducible sorting
      id(varlist)           ID variable/s uniquely identifying observations
      seed(#)               random number seed to use

    Convenience
      by(varlist)           sort within groups defined by varlist
      generate(sortorder)   create variable containing new observation number
      replace               replace existing sortorder

```

用法示例：

```Stata
sysuse auto, clear

rsort, id(price) seed(100) // 按price排序，随机数种子为100
rsort, id(price) seed(100) by(rep78) // 按照rep78分组，并按price排序
```

### 方式二：利用随机数

可以先生成随机数，之后按照生成的随机数进行排序，示例如下：

```Stata
sysuse auto,clear

set seed 100
gen temp = runiform()
sort temp // 按照随机数排序
drop temp
```

## 自定义排序

使用外部命令 `sortobs` 实现按照指定顺序排列观测值，使用前先 `ssc install sortobs, replace` 进行安装，其基本语法如下:

```Stata
 Sort observations according to a variable's specific values

        sortobs varname , values(stringlist) [first last before(string) after(string)]

    Sort observations by observation numbers

        sortobs , values(numlist) [first last before(#) after(#)]

```

基本用法示例：

```Stata
help sortobs

sysuse auto.dta, clear
keep in 1/5
list in 1/5

* 按照make的值，将Buick Electra排在AMC Pacer之后
sortobs make, values("Buick Electra") after("AMC Pacer")

list in 1/5
```
