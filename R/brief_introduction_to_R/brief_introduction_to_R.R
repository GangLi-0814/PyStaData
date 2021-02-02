# 计算器与赋值

## 计算器
2^0.5
sqrt(2)

## 赋值
x <- sqrt(2) # 赋值符号可通过：option + `-`; 或者 alt + `-`
print(x)

x = sqrt(2) # `=` 也可以赋值，但通常用 ` <- `

# R 是一种函数式语言，R 命令本质上都是一个函数。
# R 可以灵活使用复合函数

print(sqrt(1+1))

# 向量
# R 是一种面向对象的语言，R中常见的对象包括向量、矩阵、数组、数据框和列表等。
x <- c(1,2,3,4,5) # 使用`c()`函数来定义向量，`c`表示 concatenate 或者 combine

x <- 1:5 # 也可用冒号表示向量

x <- seq(from=1, to=5, by=1) # 生成等间隔序列（关键字匹配）
x <- seq(1,5,1) # 位置匹配
x <- seq(from = 1.1, to = 2, length.out = 10) # `length.out` 指定输出向量的长度

x[2] # 索引
x[1:3]
x[c(2,4)] 
x[-1]

### 计算向量
length(x)
mean(x)
sd(x)
sqrt(x)
mean(sqrt(x))

x - sqrt(x)
x + sqrt(x)
# 一般对两个向量加减乘除要求向量长度相同；如果不同则较短的将被“再循环”

y <- c("a", "b", "c", "d") # 字符向量
mode(y) #查看变量类型
mode(x)

paste("x",1:3,seq="") #使用`paste()`函数生成字符向量
paste("y",1:5,seq="M") # seq 指定粘贴符
paste("Today is",date())
cat("x",1:3,seq="") # concatenate and print，将各分量粘贴并打印，常用于显示输出

x <- 1:5
cat("Sum of squares is", sum(x^2), ".")
cat("Sum of squares is", sum(x^2), "\b.") # `\b` 去掉空格 b = backspace

z <- c(TRUE, FALSE, TRUE) 
mode(z) # 逻辑向量

z <- x < 3 # 逻辑向量一般由某种条件生成
x[z]
x[x<3]

w <- seq(from=1, to=9, by=2)
x[w>6] # 过滤或筛选

# 缺失值与空值
 
# 因子

# 矩阵

# 数组

# 列表

# 数据框

# 描述性统计
str(iris)
head(iris)
tail(iris)
View(iris)
fix(iris)
summary(iris)

# 画图

## 直方图
hist(iris$Sepal.Length)  

par(mfrow=c(1,4))
hist(iris[,1],main=names(iris)[1])
hist(iris[,2],main=names(iris)[2])
hist(iris[,3],main=names(iris)[3])
hist(iris[,4],main=names(iris)[4])
par(mfrow=c(1,1))

par(mfrow=c(1,4))
for (i in 1:4) hist(iris[,i],main=names(iris)[i])
par(mfrow=c(1,1))

## 核密度图

## 箱形图

## 散点图

## 柱状图

# 读写数据

# 随机抽样

# 条件语句

# 循环语句

# 函数

# 工作空间管理

# 帮助

# R 语言的更新
