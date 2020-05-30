# 目录

[TOC]

# 0. 写在前面

本文围绕 Stata 与 Python 的对照与交互，适合有 Stata 基础，想过渡学习 Python 的读者。其中，Python 数据管理主要使用的 Pandas 库。本文主要包括两部分：

1. Stata 和 Python 的等效操作，降低从 Stata 到 Python 的学习跨度和门槛。
2. Stata16.0 之后 Python 模块的使用，在 Stata 中实现交互，提高效率。

推荐阅读：

[Python - Comparison with Stata — pandas 0.24.2 documentation](https://pandas.pydata.org/pandas-docs/version/0.24/getting_started/comparison/comparison_with_stata.html "Python - Comparison with Stata — pandas 0.24.2 documentation")

[10 minutes to pandas](https://pandas.pydata.org/pandas-docs/stable/getting_started/10min.html "10 minutes to pandas")

[Python for Data Analysis, 2nd Edition](https://github.com/wesm/pydata-book "Python for Data Analysis, 2nd Edition")

# 1. Stata 与 Python 等效操作

## 1.1 数据结构

在 Stata16.0 未提供 Frame 功能之前，Stata 的逻辑是将数据集 (data set) 加载到内存进行操作，只能对当前内存中数据进行处理。Stata 的数据格式以 `.dta` 为后缀，一份数据最基本的要素包括变量名( variable) 、变量标签 (variable label) 和观测值(observation) 。

Python 拥有比 Stata 更灵活的数据结构，数据集 (data set) 对应到 Python 中最贴合的是 DtataFrame，变量名对应 column ，观测值对应 row 。Python 中没有类似 Stata 的变量标签 (value label) 。

Series 是 Python 中另外一种数据结构，Series 可以理解为 DataFrame 中其中一列。DataFrame 和 Series 都有索引 (Index)，如果不特殊指定，默认的索引为从 0 到 n 的整数，类似 Stata 中的 `_n` 。

因此，二者的数据结构对应如下：
| Stata | pandas |
| :---------- | :-------- |
| data set | DataFrame |
| variable | column |
| observation | row |
|groupby |bysort|
|NaN |.|

## 1.2 路径操作

Stata 中，切换路径使用 `cd` 命令，Python 则使用 `os` 模块中的 `chdir()` 方法。

```Stata
* Stata
pwd
cd "c:/..."
```

```Python
# Python
import os
os.getcwd() # 获取当前路径
os.chdir(r"c:/...")
```

## 1.3 数据导入与导出

Stata 和 Python 都能处理多种格式的数据，如`.dta`，`.xls/.xslx`，`.csv` 和 `.txt` 等。Stata 使用不同的命令导入数据， Python 则主要使用 `read_*()`(\*代表数据格式) 方法。数据导出方面，Stata 主要使用 `save` 和 `export excel` 等命令，Python 则是使用 `to_*()` 系列方法。**其逻辑都是针对不同的数据格式，选用不同的方式。**二者常见对等操作如下：

| 数据格式   | Stata                                                                   | pandas                                                                                |
| :--------- | :---------------------------------------------------------------------- | :------------------------------------------------------------------------------------ |
| .dta       | `use <dtafile>`<br>`save <dtafile>`                                     | `import pandas as pd`<br>`df =pd.read_stata('<dtafile>')`<br>`df.to_dta('<dtafile>')` |
| .xls/.xslx | `import excel using <excelfile>` <br> `export excel using <excelfile>`  | `df = pd.read_excel('<excelfile>')` <br> `df.to_excel('<excelfile>')`                 |
| .csv       | `import delimited using <csvfile>`<br>`outsheet using <csvfile>, comma` | `df = pd.read_csv('<csvfile>')`<br>`df.to_csv('<csvfile>')`                           |
| .txt       | tab 分隔：`insheet`<br>空格分隔：`infile`                               | `df = pd.read_table('<txtfile>')`<br>`df.to_csv('<txtfile>')`                         |

## 1.4 样本筛选

数据处理过程中，常需要挑选样本，主要涉及数据的保留和剔除。Stata 中 `keep` 和 `drop` 命令，再附加 `if` 和 `in` 限定范围，能够满足绝大多数需求。对应到 Python ，可以使用 `fliter()` 和 `del`，二者常用的对应操作如下：
| Stata | Python |
| :-------------------- | :-------------------------------------------------------- |
| `keep if <condition>` | `df = df[<condition>]` |
| `drop if <condition>` | `df = df[~(<condition>)`] |
| `keep <var>` | `df = df[<var>]` |
| `keep varstem*` | `df = df.filter(like='varstem*')` |
| `drop <var>` | `del df[<var>]` 或者 `df = df.drop(<var>, axis=1)` |
| `drop varstem*` | `df = df.drop(df.filter(like='varstem*').columns,axis=1)` |

## 1.5 数据清理

对数据样本进行挑选之后，需要对数据进行整理以待后续分析。常规的数据整理包括变量增、删和改、重命名和排序等操作。处理过程中，针对数值型和字符型不同的数据类型，有不同的处理方法。

数值型变量主要是简单的计算，生成新的变量。如生成最大值、最小值、均值，或者是求和、平方和取对数等。在 Stata 中，最基本的是使用 `replace` 和 `generate` 命令，另外 `egen` 提供了大量的函数能便捷的处理数据。此外，还有 `collapse` 和 `post` 等更灵活的命令。

字符型变量更多涉及字符串清理，如字符串截取、多余字符清理等。在处理字符型变量时，Stata 中使用频率较高的是`substr()` 、`subinstr()`，以及用于正则表达式的`regexm()` 等函数， Stata 提供了丰富的字符串函数，熟悉它们的使用会让字符串清理事半功倍，更详细的内容 `help string function` 查阅。

在 Python 中，也可以较为方便的对文本数据进行清理。熟悉字符串操作和正则表达式会让文本数据处理更加高效。

### 1.5.1 常规清理

| Stata                                         | Python                                                                                                            |
| :-------------------------------------------- | :---------------------------------------------------------------------------------------------------------------- |
| `rename <var> <newvar>`                       | `df =df.rename(columns={<var>:<newvar>})`，也可以像列表一样直接操作 `df.columns`，如 `df.columns = ['a','b','c']` |
| `sort <var1> <var2>`                          | `df.sort_values([var1, var2])`                                                                                    |
| `gen <nwevar> = <expression>`                 | `df[<newvar>] = <expression>`                                                                                     |
| `gen <newvar> = <expression> if <condition>`  | `df.loc[<condition>, <newvar>] = <expression>`，不同于 Stata ，Python 中不符合条件的 df 行会变成缺失值(numpy.nan) |
| `replace <var> = <expression> if <condition>` | `df.loc[<condition>, <var>] = <expression>`                                                                       |

### 1.5.2 数值型变量

| Stata                                     | Python                                                                                                                                                     |
| :---------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `egen <newvar> = count(<var>)`            | `<newvar> = df[<var>].notnull().sum()`，需要注意的是，Stata 中`egen` 命令的这些函数，生成的 newvar 在 Stata 中是完整（常量）列，而在 Python 中是 scalar 。 |
| `egen <newvar> = max(<var>)`              | `<newvar> = df[<var>].max()`                                                                                                                               |
| `egen <newvar> = mean(<var>)`             | `<newvar> = df[<var>].mean()`                                                                                                                              |
| `egen <newvar> = total(<var>)`            | `<newvar> = df[<var>].sum()`                                                                                                                               |
| `recode <var> (1/5 = 1)`                  | 不适用                                                                                                                                                     |
| `recode <var> (1/5 = 1), gen(<newvar>)`   | 不适用                                                                                                                                                     |
| `label var <var> <label>`                 | 不适用                                                                                                                                                     |
| `label define <labelname> 1 <labelvalue>` | 不适用，见下方说明                                                                                                                                         |
| `label values <var> <labelname>`          | 不适用                                                                                                                                                     |
| `label list <labelname>`                  | 不适用                                                                                                                                                     |

因为 Python 的 DataFrame 里面没有 Stata 中 label 的概念，所以不能像 Stata 添加值标签。必要时，可以通过定义字典映射变量取值和标签。

```Python
variabel_labels = {
    1: "First Category"
    2: "Second Category"
    3: "Last Category"
}
```

### 1.5.3 字符型变量

| Stata                 | Python                             |
| :-------------------- | :--------------------------------- |
| `length(<var>)`       | `df[<var>].str.len()`              |
| `ustrlen(<var>)`      | `df[<var>].str.rstrip().str.len()` |
| `strpos(<var>,"sub")` | `df[<var>].str.find("sub")`        |
| `strupper(<str>)`     | `df[<str>].str.upper()`            |
| `strlower(<str>)`     | `df[<str>].str.lower()`            |
| `strproper(<str>)`    | `df[<str>].str.title()`            |

## 1.6 描述性统计

| Stata                        | Python                                                                                                                  |
| :--------------------------- | :---------------------------------------------------------------------------------------------------------------------- |
| `describe`                   | `df.describe()`、`df.info()` 或者 `df.types` 只能获取数据类型，Python 中没有 Stata 中的数据标签 ( value label )         |
| `describe <var>`             | `df[<var>].dtype`                                                                                                       |
| `count`                      | `df.shape[0]` 或者 `len[df]`，`df.shape`会返回一个具有 DtataFrame 长度和宽度的元组                                      |
| `count if <condition>`       | `df[<condition>].shape[0]` ，如果条件包含于 DataFrame ，可以通过`(<condition>).sum()` 实现，比如`df.['age'] > 2).sum()` |
| `summ <var>`                 | `df['<var>'].describe()`                                                                                                |
| `summ <var> if <condition>`  | `df[<condition][<var>].describe()` 或者 `df.loc[<condition>],[<var>].describe()`                                        |
| `summ <var> [aw = <weight>]` | 目前暂时需要手动计算权重信息，不过，`Statsmodels`包提供了一些工具                                                       |
| `summ <var>, detail`         | `df[<var>].describe()` 或者 `df[<var>].quantile([.1, .25, .5, .75, .9])` 等其他所需要的信息                             |
| `list in 1/5`                | `df.head()`                                                                                                             |

## 1.7 数据合并与匹配

| Stata                               | Python                                                                                                                                                                                        |
| :---------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `append using <filename>`           | `df_joint = df1.append(df2)`                                                                                                                                                                  |
| `merge 1:1 <vars> using <filename>` | 如果 `<vars>` 是 DataFrame 的索引，则 `df_joint = df1.joint(df2)`；否则，`df_joint = pd.merge(df1, df2, on=<vars>)`。注意，`pd.merge` 不会保留原数据集的索引，Python 中的合并就像 R，SQL 等。 |

Pandas DataFrames 匹配不需要指定“多对一”或“一对多”。Pandas 会根据要合并的变量是否唯一来自动确定。但是，可以使用关键字参数 how 来指定要保留的合并子样本，例如 `df_joint = df1.join(df2,how='left')`是 `join` 的默认值，而 `how ='inner'` 是 `pd.merge` 的默认值。
| Pandas how | Stata, keep() | Intuition |
| :------------ | :------------ | :---------------------------------- |
| `how='left'` | `keep(1, 3)` | 保留 DataFrame "left" 所有的观测值 |
| `how='right'` | `keep(2, 3)` | 保留 DataFrame "right" 所有的观测值 |
| `how='inner'` | `keep(3)` | 保留匹配上的观测值 |
| `how='outer'` | `keep(1 2 3)` | 保留所有观测值 |

## 1.8 长宽转换

与 merge 一样，在 Python 中 DataFrame 的 reshape 方式也有所不同，因为 Stata 的数据是“内存中唯一数据表”，而 DtataFrame 在 Python 只是另一个对象/变量，这种区别也使得在 Python 中进行 reshape 变得更加容易。
Python/Pandas 中最基本的 reshape 命令是`stack` 和 `unstack`。

```Python
import pandas as pd
import numpy as np
# 输入数据
long = pd.DataFrame(np.arange(8),
                    columns=['some_variable'],
                    index=pd.MultiIndex.from_tuples([('a',1),('a',2),('b',1),('b',2),('c',1),('c',2),('d',1),('d',2)])
                   )

# 定义为长数据
long.index.names = ['unit_id', 'time']
long.columns.name = 'varname'
long

# 长数据 转 宽数据
wide = long.unstack('time')
wide

# 宽数据 转 长数据
long2 = wide.stack('time')
long2
```

上述代码中，首先创建一个 DataFrame ，然后为每个索引列指定一个名称，为该列命名。对应到 Stata ，可能觉得列名本身就有 "name" 有点难理解，但列名也只是像行名一样的索引。
当认识到列不必是字符串时会更好理解。列名可以是整数，例如年份或 FIPS 代码。在这些情况下，给列起一个名字很有意义，这样就知道要处理的内容。`long.unstack('time')` 进行 reshape ，它使用索引 'time' 并创建一个新的它具有的每个唯一值的列。请注意，这些列现在具有多个级别，就像以前的索引一样。这是标记索引和列的另一个理由。**如果要访问这些列中的任何一列，则可以照常执行操作，使用元组在两个级别之间进行区分。**

```Python
wide[('some_variable', 1)]
'''
unit_id
a 0
b 2
c 4
d 6
Name: (some_variable, 1), dtype: int32
'''
```

如果要结合两个层级（像 Stata 默认的一样），可以重命名 columns：

```Python
wide_single_level_column = wide.copy()
wide_single_level_column.columns = ['{}_{}.format(var, time) for var,time in wide_single_level_columns.columns']

wide_single_level_columns
'''
 unit_id some_variable_1 some_variable_2
a 0 1
b 2 3
c 4 5
d 6 7
'''
```

`pivot` 命令也比有用，但是会比 `stack` 和 `unstack` 更加复杂一些，熟悉 DataFrame 的 index 和 columns 之后， `pivot` 用起来会更加顺手。

| Stata                                             | Python                                                                            |
| :------------------------------------------------ | :-------------------------------------------------------------------------------- |
| `reshape <wide/long> <stubs>, i(<vars>) j(<var>)` | wide: `df.unstack(<level>)`;long: `df.stack(<column_level>)`; 也可参照 `df.pivot` |

## 1.9 面板数据

在 Python 中，没有与 `tsset` 等效的常规方法。但是可以使用 DataFrame 的索引（行的等效列）来完成大多数（但不是全部）相同的任务。在 Stata 中，内存中的 “DataFrame” 始终具有观察行号，由 Stata 内置变量 `_n` 表示。在 Python 和 Pandas 中，DataFrame 索引可以是任何值（尽管您也可以通过行号引用行；参见 .loc 与 iloc ）。它也可以具有多个级别的层次结构，这是比 `tsset` 更通用的工具 。
| Stata | Python |
| :--------------------------- | :--------------------------------------------------- |
| `xtset <panemvar> <timevar>` | `df = df.set_index([<panelvar>, <timevar>])` |
| `L.<var>` | `df.shift()`，索引必须正确排序才能使`shift` 正确使用 |
| `L2.<var>` | `df.shift(2)` |
| `F.<var>` | `df.shift(-1)` |

```Python
import numpy as np
import pandas as pd

df0 = pd.DataFrame({'var1':np.arange(6),'id':[1, 1, 2, 2, 3, 3],'period':[0, 1]*3})
print(df0)

#定义面板
df = df0.set_index(['id','period'])
print(df)

#滞后一期
df['var1_lag'] = df.groupby(level='id')['var1'].shift()
print(df)

#向前一期
df['var1_for'] = df.groupby(level='id')['var1'].shift(-1)
print(df)
```

## 1.10 计量

| Stata                                                         | Python                                                                                                          |
| :------------------------------------------------------------ | :-------------------------------------------------------------------------------------------------------------- |
| `ttset <var>, by(<var>)`                                      | `from scipy.stats import ttest_ind` <br> `ttset_ind(<array1>, <array2>)`                                        |
| `xi: i.<var>`                                                 | `pd.get_dummies(df[<var>])`                                                                                     |
| `i.<var2>#c.<var1>`                                           | `pd.get_dummies(df[<var2>]).multiply(df[<var1>])`                                                               |
| `reg <yvar> <xvar> if <condition>, r`                         | `import econtools.metrics as mt` <br> `results = mt.reg(df[<condition>], <yvar>, <xvar>, robust = True)`        |
| `reg <yvar> <xvar> if <condition>, vce(cluster <clustervar>)` | `import econtools.metrics as mt` <br> `results = mt.reg(df[<condition>], <yvar>, <xvar>, cluster=<clustervar>)` |
| `areg <yvar> <xvar>, absorb(<fe_var>)`                        | `result = mt/reg(df, <yvar> <xvar>, a_name=<fe_var>)`                                                           |
| `predict <newvar>, resid`                                     | `<newvar> = result.resid`                                                                                       |
| `predict <newvar>, xb`                                        | `<newvar> = result.yhat`                                                                                        |
| `_b[<var>], _se[<var>]`                                       | `result.beta[<var>], result.se[<var>]`                                                                          |
| `test <varlist>`                                              | `result.Ftest(<varlist>)`                                                                                       |
| `test <varlist>, equal`                                       | `result.Ftest(<varlist>, equal=True)`                                                                           |
| `lincom <var1> + <var2>`                                      | `econtools.metrics.f_test` with appropriate parameters                                                          |
| `ivreg2`                                                      | `econtools.metrics.ivreg`                                                                                       |
| `outreg2`                                                     | `econtools.outreg`                                                                                              |
| `reghdfe`                                                     | None(hope to add it ro Econtools soon)                                                                          |

## 1.11 数据可视化

在 Python 中，推荐使用 `Matplotlib`和 `Seaborn` 两个包对数据进行可视化。
| Stata | Python |
| :------------------------------ | :----------------------------------------------------------- |
| `binscatter` | `econtools.binscatter` |
| `maptile` | Not quick tool, but easy to do with Cartopy. |
| `coefplot` | `ax.scatter(result.beta.index, result.beta)` often works. Depends on context. |
| `two way scatter <var1> <var2>` | `df.scatter(<var2>, <var1>)` |

## 1.12 网络爬虫(待更新)

## 1.13 其他方面

### 1.13.1 缺失值

在 Python 中，缺失值由 NumPy “非数字” 对象 np.nan 表示。在 Stata，缺失值（.）大于每个数字，所以 10 < . 为 True 。在 Python 中，np.nan 不等于任何东西。任何涉及 np.nan 的比较都始终为 False ，即使 `np.nan == np.nan` 。
要在 DataFrame 列中查找缺失值，使用以下任何一种：

- `df[<varname>].isnull()` 返回一个每行值为 True 和 False 值的向量 `df[<varname>]`。
- `df [<varname>].notnull()` 是`.isnull()` 的补充。
- `np.isnan(<arraylike>)`函数接受一个数组数组（DataFrame 是数组的一种特殊类型）并为每个元素返回 True 或 False 。
  另一个重要的区别是 np.nan 是浮点数据类型，因此 DataFrame 的任何列包含缺失数字的将是浮点型的。如果一列整型数据改变了，即使只有一行 np.nan ，整列将被转换为浮点型。

### 1.13.2 浮点数

在 Stata 中，小数和任何值都不相等，比如 3.0==3 是 False 。而在 Python 会返回 True 。

# 2. Stata 与 Python 交互

Stata16.0 提供了 Python 模块，能够在 Stata 中调用 Python ，交互功能的拓展对 Stata 和 Python 都是好消息，因为给双方都提供了一种便利的选择。一方面， Stata 可以利用 Python 胶水语言的灵活性和延展性；另一方面，通过调用 `sfi`(Stata Function Interface) 模块， Python 能够利用 Stata 在计量方面的优势。
但要注意，这项功能要在 Stata16.0 及以上的版本中才能使用，可以输入 `version` 查看 Stata 当前版本。

## 2.1 环境配置

当前，Python 主要有 Python 2.x 和 Python 3.x 两个版本，二者的区别可参阅 [Key differences between Python 2.7.x and Python 3.x](https://nbviewer.jupyter.org/github/rasbt/python_reference/blob/master/tutorials/key_differences_between_python_2_and_3.ipynb?create=1 "Key differences between Python 2.7.x and Python 3.x") 。从 2020 年 1 月 1 日开始，Python 2.x 已经停止维护。如果是刚接触 Python ，建议直接学习 Python 3.x 。

Stata 支持 Python 2.7 及以上的版本，第一次调用时，Stata 会自动搜索系统中通过官网、Anconda 或 Miniconda 安装的 Python 。安装路径下必须含有 Python 相应的动态链接库 ( [Dynamic-link library](https://en.wikipedia.org/wiki/Dynamic-link_library "Dynamic-link library") ) 才能被 Stata 识别到（还要注意 Python 版本与系统位数一致）。何为 DLL ？简而言之，是一个包含可由多个程序同时使用的代码和数据的库（[微软支持-何为 DLL ?](https://support.microsoft.com/zh-cn/help/815065/what-is-a-dll "微软支持-何为 DLL ?")）。以 Python 3.6 为例，Windows 上应该有 `python36.dll`；Linux 上应有 `libpython3.6.so` ；Mac 上应有 `libpython3.6.dylib` 。

### 2.1.1 Python 安装

如果电脑上还未安装 Python ，可以从 [Python 官网](https://www.python.org/ "Python 官网") 或者 [Anaconda](https://www.anaconda.com/distribution/ "Anaconda") 进行下载安装。
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

# 3. 参考资料

[Stata to Python Equivalents](http://www.danielmsullivan.com/pages/tutorial_stata_to_python.html#id2 "Stata to Python Equivalents")

[Comparison with Stata](https://pandas.pydata.org/pandas-docs/stable/getting_started/comparison/comparison_with_stata.html "Comparison with Stata")

[Stata Manual_P_Python](https://www.stata.com/manuals/ppython.pdf "Stata Manual_P_Python")

[Stata's Python API](https://www.stata.com/python/api16/ "Stata's Python API")
