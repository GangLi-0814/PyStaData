
Text Analysis Using Stata

# 前言

数据的丰富性大大增强，文本数据用于研究。但是 Stata 在文本分析方面的资料较少。从读取数据、数据清理到文本挖掘。

# 准备工作

## 环境配置
### 软件安装
####  Python 安装
如果电脑上还未安装 Python ，可以从 [Python 官网](https://www.python.org/ "Python 官网") 或者 [Anaconda](https://www.anaconda.com/distribution/ "Anaconda") 进行下载安装。
### Stata 配置 Python 和调用

Stata16.0 提供了 Python 模块，能够在 Stata 中调用 Python ，交互功能的拓展对 Stata 和 Python 都是好消息，因为给双方都提供了一种便利的选择。一方面， Stata 可以利用 Python 胶水语言的灵活性和延展性；另一方面，通过调用 `sfi`(Stata Function Interface) 模块， Python 能够利用 Stata 在计量方面的优势。
但要注意，这项功能要在 Stata16.0 及以上的版本中才能使用，可以输入 `version` 查看 Stata 当前版本。

当前，Python 主要有 Python 2.x 和 Python 3.x 两个版本，二者的区别可参阅 [Key differences between Python 2.7.x and Python 3.x](https://nbviewer.jupyter.org/github/rasbt/python_reference/blob/master/tutorials/key_differences_between_python_2_and_3.ipynb?create=1 "Key differences between Python 2.7.x and Python 3.x") 。从 2020 年 1 月 1 日开始，Python 2.x 已经停止维护。如果是刚接触 Python ，建议直接学习 Python 3.x 。

Stata 支持 Python 2.7 及以上的版本，第一次调用时，Stata 会自动搜索系统中通过官网、Anconda 或 Miniconda 安装的 Python 。安装路径下必须含有 Python 相应的动态链接库 ( [Dynamic-link library](https://en.wikipedia.org/wiki/Dynamic-link_library "Dynamic-link library") ) 才能被 Stata 识别到（还要注意 Python 版本与系统位数一致）。何为 DLL ？简而言之，是一个包含可由多个程序同时使用的代码和数据的库（[微软支持-何为 DLL ?](https://support.microsoft.com/zh-cn/help/815065/what-is-a-dll "微软支持-何为 DLL ?")）。以 Python 3.6 为例，Windows 上应该有 `python36.dll`；Linux 上应有 `libpython3.6.so` ；Mac 上应有 `libpython3.6.dylib` 。


如果已经安装，可以在 Stata 中输入 `python search` 搜索系统中所有可用的版本（。比如 Windows 系统，Stata 会搜索所有的 `python.exe`。**一旦搜索到符合条件的程序，它会自动配置成最高版本**。输入 `python query` 可以查看当前配置版本和系统信息。

```Stata
. python search
------------------------------------------------
 Python environments found:

C:\Users\mudaozi\AppData\Local\Programs\Python\Python35\python.exe

. python query
------------------------------------------------
    Python Settings
      set python_exec      C:\Users\mudaozi\AppData\Local\Programs\Python\Python35\python.exe
      set python_userpath

    Python system information
      initialized          yes
      version              3.5.3
      architecture         64-bit
      library path         C:\Users\mudaozi\AppData\Local\Programs\Python\Python35\python35.dll
```

### 2.1.2 Stata 设置

如果需要更换 Python 版本，输入 `python set exec` + _需要设置的 Python 程序_，设置完成之后会在 Result 窗口显示 `Python has been initialized. You need to restart Stata to set the Python executable` ，重启 Stata 才能生效。如果要永久设定，可以在命令后添加 `permanently` 选项。

简单总结环境配置过程：首先确保电脑上安装 Python 2.7 及以上的版本，之后输入如下命令：

```Stata
python search // 搜索系统已安装 Python 版本
python query  // 查询当前配置版本信息
*python set exec pyexecutable [, permanently] // 更换版本
```

## 2.2 调用方式

个人理解，目前的对 Python 的调用主要分为 **交互式** 和 **脚本式** 两类。其中，交互式分为窗口交互和代码内嵌（代码内嵌是指在 do-file 或 ado-file 中嵌入 Python 代码），两种方式都是遇见特定指令进入和退出环境；脚本式则是指运行 Python 脚本。

| 类别   | 包含                                       |
| :----- | :----------------------------------------- |
| 交互式 | 窗口交互<br>代码内嵌于 do-file 和 ado-file |
| 脚本式 | 执行 Python 脚本                           |

三种调用方式各有优劣，可以根据项目需要进行选择，**重点在于使流程精简化、模块化和自动化，同时注重可重复性**。

### 2.2.1 交互式

在 Command 窗口输入 `python` 或者 `python:` 即可进入 Python 环境。值得注意的是，`python` 和 `python:` 有所区别：

- `python` (不带冒号) 遇到错误会保留在 Python 环境。
- `python:` (带冒号) 遇到错误时会回到 Stata 环境。

Python 部分的代码写完之后，输入 `end` 退出 Python 环境。**但输入 `end` 只是退出 Python 环境，Python 环境并没有清除，下次输入 `python` 或者 `python:` 时会保留上次运行所产生的对象**。比如下例，先将 a 赋值为 3 ，退出 Python 环境后再进入，a 的值依旧为 3 。

```Stata
python
a = 3
end # 退出

python
print(a) # 3
end
```

这是因为交互式产生的所有对象都储存在 `__main__` 的命名空间内，退出 Python 环境再回来可以继续使用。在 Stata 中，可以通过 `python describe`, `python drop` 和 `python clear` 管理这些对象。

在交互式环境中，也可以把`stata:` 当成前缀来执行 Stata 代码，比如 `stata: display "hello, world"`。这种方式只能在窗口交互使用时调用，不能用于执行 Python 脚本中。 在 Python 脚本中，可以通过调用 `sfi` (Stata Function Interface) 包中的 `stata()` 函数运行 Stata 的代码。

也可以将 Python 代码嵌于 Stata 的 do-file 或 ado-file 中，如下例，只要在 Stata 代码中声明 `python` 或 `python:` ，就会进入 Python 环境，遇见 `end` 则会退出。嵌入代码其实和窗口交互的本质是相同的：当遇见 `python` 或 `python:` 时，会进入 python 交互环境，进而逐行执行 Python 代码，直到遇见 `end` 才跳出 Python 环境返回到 Stata 。同时， Python 环境下产生的对象都被存在了 `__main__` 的命名空间内，可以供 Python 或者 Stata 后续调用。

```Stata
version 16.0
local a = 2
local b = 3

python:
from sfi import Scalar
def calcsum(sum1, sum2):
    res = sum1 + sum2
    Scalar.setValue("result", res) //存入 scalar
calcsum('a', 'b')
end

display result
```

### 2.2.2 脚本式

> Be aware that Stata and Python use different syntax, data structures and types, language infrastructures, etc. They even have different rules for handling comments and indentations. (Stata Manual: [P] python)

Stata 和 Python 具有不同的语法、数据结构和注释等，所以建议将 Stata 和 Python 的代码分开 (isolate) 写。将 Python 代码存为 `.py` 的脚本文件，然后在 Stata 中通过 `python scripy pycodes.py` 命令来执行。

```Python
# saved as pyex.py
from sfi import Macro, Scalar
def calcsum(num1, num2):
    res = num1 + num2
    Scalar.setValue("result", res)
pya = int(Macro.getLocal("a"))
pyb = int(Macro.getLocal("b"))
calcsum(pya, pyb)
```

```Stata
version 16.0
local a = 2
local b = 3
python script pyex.py
display result
```

上面两段分别为 Python 和 Stata 代码，首先用 Python 定义求和的函数，然后使用 Stata 的 do-file 运行脚本。在 do-file 中，首先定义了两个暂元 `a` 和 `b`，然后执行 Python 脚本，在 Python 代码中，通过 sfi 模块将结果存为了 scalar，所以在 do-file 中可以直接 `display` 。

在脚本式调用中，可以通过 `args()` 选项在 Stata 中向 Python 脚本传递参数。要在脚本中接收参数，需要使用 `sys`模块中 `argv`列表来定义。比如下例：

```Python
# saved as pyex2.py
import sys
pya = int(sys.argv[1]) # 注意：为何不是 argv[0] ？
pyb = int(sys.argv[2])

from sfi import Macro, Scalar
def calcsum(num1, num2):
    res = num1 + num2
    Scalar.setValue("result", res)
calcsum(pya, pyb)
```

```Stata
version 16.0
local a = 2
local b = 3
python script pyex2.py, args('a', 'b')
display result
```

在 Python 脚本中，先引用了 `sys` 模块，然后通过 `sys.argv` 列表接收参数。上例中，因为要向脚本传入 2 个参数，所以通过 `sys.argv[1]` 和 `sys.argv[2]` 接收参数。**为何不从 `argv[0]` 开始？因为运行 Python 脚本时，`sys.argv[0]` 被用于储存脚本的名称，在上例中，`sys.argv[0]` 为 pyex2.py** 。在 do-file 中，通过 `python script` 的 `args()` 选项向 Python 脚本传入两个 macro 作为参数。

使用 `python script` 时，还有一个有用的选项 `userpaths()`, 它可以用来在指定路径中导入模块。默认情况下，指定的路径会位于列表的末端，但是可以通过 `prepend` 选项将它挪到前端，命令的写法为`userpaths(userpath, prepend)` 。但要注意，添加的路径只是临时的添加到了 `sys.path`，这意味着只有执行脚本的时候才会生效。在脚本运行完毕后，添加的路径会从列表中删除。要永久的添加路径，可以通过 `python set userpath` 进行设置。

### 2.2.3 交互式与脚本式的区别

不同于交互式，通过脚本执行的 Python 代码中所有对象在脚执行完之后不会保存，它们不会添加到 `__main__` 的命名空间。换言之，脚本执行产生的对象不与 `__main__` 共享命名空间，这意味着不能在 Python 脚本中调用在主模块中定义的对象。

要在脚本中使用 `__main__` 的对象，可以 通过 `import` 或者 `import - from` 调用。比如，可以在脚本中添加 `import __main__` 来使用 `__main__` 中定义的对象。

如果想在交互环境中调用脚本执行后的对象，可以在 `python script` 命令后面附加 `global` 选项。添加 `global` 选项之后，所有的对象都会被复制到 `__main__` 的命名空间之下，所以可以不需要 import 直接使用。**这在定义函数、类等时非常有用**。在脚本执行后产生的对象可以在交互环境或 do-file 中调用。**然而，要谨慎使用 `golbal` 选项，因为在同名的情况下，来自脚本对象会覆盖 (overwrite) `__main__` 命令空间下的对象。**

## 2.3 Stata Function Interface (sfi) 模块

可参阅 Stata 官方介绍 [Stata's Python API](https://www.stata.com/python/api16/ "Stata's Python API") 。


##  基础知识

# 文本获取

## 读取本地文件
读取本地 txt 文件
### txt 文件
### Excel/csv 表格
### Word 文档
调用 Python
Python可以利用python-docx模块处理word文档，处理方式是面向对象的。也就是说python-docx模块会把word文档，文档中的段落、文本、字体等都看做对象，对对象进行处理就是对word文档的内容处理。
###  PDF 文件

### 图片

## 从格式化文档中提取信息
有一批格式化的word，从中提取出信息

## 网络爬虫
爬取网站文本，如新闻文本、政策文本



# 文本清理

## 字符串函数

## 正则表达式
### 原理
### 常用正则表达式总结

## 调查问卷数据清理

### EpiData 软件使用

## 文本模糊匹配
## 中文时间表达词转换
## 中文数字转阿拉伯数字
## 根据姓名推断性别
## 从中文中提取信息

# 文本挖掘

## 分词
## 词频统计
moss命令与简单的词频统计
1)分词原理
2)分词的实现
    a)ustrwordcount()和ustrword()
    b)调用Python的jieba和pynlpir
    c)Bosonnlp的API
    d)词频统计
## 绘制词云图	
## 文本数据可视化
绘制动态图

## 重要文本高亮显示
分词、格式化、借助-putdocx- 高亮


## 计算文本相似度
https://warwick.ac.uk/fac/soc/economics/staff/crschwarz/lsa_stata.pdf

## 主题模型
LDA主题模型

## 情感分析






There is also a few commands for preparing string variables:
-ngram- and -txttool-

Supervised ML for text classification:
-svmachines-

Unsupervised topic modeling (cluster identification):
-ldagibbs-

Document similarity analysis:
-lsemantica-

If you Google using these specific keywords, you will find PDF documentation by the authors.

Hope you find these useful.

Xiaodong

# 参考资料
https://www.statalist.org/forums/forum/general-stata-discussion/general/1425274-efficiently-processing-textual-data-with-stata-s-unicode-features

https://www.statalist.org/forums/forum/general-stata-discussion/general/1512191-how-to-find-all-user-written-programs-related-to-text-mining-content-analysis/page2

https://www.tcd.ie/Political_Science/wordscores/software.html

https://www.statalist.org/forums/forum/general-stata-discussion/general/1293220-dealing-with-nasty-string-variables