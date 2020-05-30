# 提出问题

- 生成 1-20 的列表 `a`。
- 挑出列表 `a` 中偶数，存为列表 `b`。
- 将列表 `b` 的所有元素平方，生成列表 `c` 。

# 分析问题

采用 `for` 循环，加条件判断，很轻松就可以实现。但有没有更简洁的实现方式？使用列表推导式（List Comprehension）。先来对比看看两者的实现过程。

# 实现过程

## for 循环

```python
# 生成列表
a = []
for i in range(20):
    a.append(i)

# 条件判断
b = []
for i in a:
    if i % 2 == 0:
        b.append(i)

# 计算
c = []
for i in b:
    c.append(i**2)

# 结果展示
print(a)
print(b)
print(c)

# [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]
# [0, 2, 4, 6, 8, 10, 12, 14, 16, 18]
# [0, 4, 16, 36, 64, 100, 144, 196, 256, 324]

```

## 列表推导式

```python
a = [i for i in range(20)]
b = [x for x in a if x % 2 == 0]
c = [x**2 for x in b]

# 结果展示
print(a)
print(b)
print(c)

# [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]
# [0, 2, 4, 6, 8, 10, 12, 14, 16, 18]
# [0, 4, 16, 36, 64, 100, 144, 196, 256, 324]
```

# 二者比较

## 语法

对比两段实现代码，语法差异一目了然。用 `for` 和 `if` 语法如下：

```Python
for (set of values to iterate):
    if (conditional filtering):
        output_expression()
```

写作列表推导式如下：

```Python
 [ output_expression() for(set of values to iterate) if(conditional filtering) ]
```

## 速度

> Do you know List Comprehensions are 35% faster than FOR loop and 45% faster than map function? (AARSHAY JAIN, JANUARY 19, 2016)

```python
import timeit
#  for 循环
def gen_lst(n):
    lst = []
    for i in range(n):
        lst.append(i)
    return lst

for_loop = timeit.timeit(stmt="gen_lst(1000)",
                         setup="from  __main__ import gen_lst", number=100000)
# stmt 需要测试的函数或语句，字符串形式
# setup 运行的环境，本例子中表示 if __name__ == '__main__':
# number 被测试的函数或语句，执行的次数，本例表示执行100000次 gen_lst()。省缺则默认是10000次
# 综上：此函数表示在if __name__ == '__main__'的条件下，执行100000次gen_lst()消耗的时间

# 列表推导式
lst_comp = timeit.timeit(stmt="[x for x in range(1000)]",
                         setup="from  __main__ import gen_lst", number=100000)  # 4.470719099999769

print("for循环耗时：{}\n列表推导式耗时：{}".format(
    for_loop, lst_comp))

# for 循环耗时：8.945164900000002
# 列表推导式耗时：4.339412200000002
```

为什么列表推导式比 `for` 循环更快呢？
由字节码决定的。在 `for` 循环中先要加载 `append` 方法，然后再执行后续运算；而列表推导式则直接调用了 `LIST_APPEND` 命令来添加元素。就是这个区别使列表推导式比循环更快，在嵌套多层循环和判断的情况下对比更明显。

## 实现 for 和 map() 函数

```python
# 需求：将列表所有元素除以 10
lst = [100,1000,10000,100000]

# for 循环
new_lst = map(lambda x:x/10,lst)

# 列表推导式
new_lst = [x/10 for x in lst]
```

# 列表推导式的应用

## 拉平矩阵

```python
matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
]

# for 循环
flattened = []
for row in matrix:
    for i in row:
        flattened.append(i)

# 列表推导式
flattened = [i for row in matrix for i in row]  # [1, 2, 3, 4, 5, 6, 7, 8, 9]
```

## 矩阵转置

```python
matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
]

# for 循环
transposed = []
for i in range(3):
    trans_row = []
    for row in matrix:
        trans_row.append(row[i])
    transposed.append(trans_row)


# 列表推导式
transposed = [[row[i] for row in matrix] for i in range(3)]

# NumPy
import numpy as np
arr = np.array(matrix)
arr.T
```

# 小结

本文由最简单的列表生成和计算入手，比较了 `for` 循环和列表推导式的语法和速度等方面的特点。并列举了列表推导式的运用，其实列表推导式还有更多的应用，有兴趣可以阅读这份 [Tutorial](https://www.analyticsvidhya.com/blog/2016/01/python-tutorial-list-comprehension-examples/ "Tutorial – Python List Comprehension With Examples") 。

总体来看，列表推导式比 for 循环更简洁和优雅，而且速度更快。但列表推导式写起来爽，读起来并不爽，代码的可读性没有用循环清晰。所以在使用列表推导式的时，需要注意代码的可读性。

在《流畅的 Python》中，作者建议通常的原则是，只用列表推导式来创建新的列表，并且尽量保持简短。如果列表推导式的代码超过了两行，看是否考虑用循环重写了。用循环还是列表推导式和写文章一样，没有硬性的规定，要自己把握好度。
