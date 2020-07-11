# 0. 写在前面

## Stata 常见误解
Stata != 编程语言 ==> 软件，但命令行操作方式更高效
Stata != 计量 ==> 擅长计量，但也可以用于数据处理和可视化等方面
Stata != commands ==> 掌握核心，补充外部，会看 help 和 Manual 是关键

## 写作缘由
之前也萌生过写一本讲义的想法，但想到前辈们已经提供了丰富的学习资料，自己的学习也得益于他们的贡献，所以想法很快被搁置了。随着学习逐渐深入，有以下三点理由说服我开始着手。

- 更新。知识是在不断更新的，对 Stata 的使用和数据处理的方法也在不断进化。即使对待同样的知识，每个人也会有不同的理解，努力补充他人忽略，自己又觉得有用的内容，作出“边际贡献”。
- 记录。自学的道路免不了“踩坑”，想起自己最初接触的时候，为了搞定某个问题查遍网页和资料的时候，所以想记录下学习的经验。
- 总结。查过的文档资料多了之后，也受 Stata 编程哲学"Document everything"的影响，愈发觉得只有写下来的东西才是自己的。及时总结记录，一方面可以避免遗忘，另一方面便于总结归纳、深化理解和完善知识框架。

## 提问的智慧
在 Stata 学习过程中，常常感到学习资源非常丰富，除了海量的文档，更重要的是有师友、社群和论坛等广阔的平台，遇见问题总是能从他人那里找到更好的解决办法。随之而来，如何提问能让自己获得满意的答案是成为了一个重要的问题。知名的 Hacker Eric S. Raymond 曾撰写过文档 [How To Ask Questions The Smart Way](http://www.catb.org/~esr/faqs/smart-questions.html) ，
专门谈这个话题， Github 上已经翻译成中文版 [提问的智慧](https://github.com/ryanhanwu/How-To-Ask-Questions-The-Smart-Way/blob/master/README-zh_CN.md) ，整个文档约 2 万字。如果有耐心的话，推荐认真读完，如果没有耐心，下面摘录了一些重要的观点：

>首先你应该明白，黑客们喜爱有挑战性的问题，或者能激发他们思维的好问题。如果我们并非如此，那我们也不会成为你想询问的对象。如果你给了我们一个值得反复咀嚼玩味的好问题，我们自会对你感激不尽。好问题是激励，是厚礼。
>所以，你不必在技术上很在行才能吸引我们的注意，但你必须表现出能引导你变得在行的特质--机敏、有想法、善于观察、乐于主动参与解决问题。

>提问前：
> 在你准备要通过电子邮件、新闻群组或者聊天室提出技术问题前，请先做到以下事情：
> 1. 尝试在你准备提问的论坛的旧文章中搜索答案。
> 2. 尝试上网搜索以找到答案。
> 3. 尝试阅读手册以找到答案。
> 4. 尝试阅读常见问题文件（FAQ）以找到答案。
> 5. 尝试自己检查或试验以找到答案。
> 6. 向你身边的强者朋友打听以找到答案。
> 7. 如果你是程序开发者，请尝试阅读源代码以找到答案。

> 提问时：
> 1. 慎选提问平台。
> 2. 用有意义且描述明确的标题
> 3. 用清晰、正确、精准并语法正确的语句
> 4. 使用易于读取且标准的文件格式发送问题
> 5. 精确地描述问题并言之有物
> 6. 话不在多而在精
> 7. 别动辄声称找到 Bug
> 8. 低声下气不能代替你的功课
> 9. 描述问题症状而非你的猜测
> 10. 按发生时间先后列出问题症状
> 11. 描述目标而不是过程
> 12. 别要求使用私人电邮回复
> 13. 清楚明确的表达你的问题以及需求
> 14. 询问有关代码的问题时，最有效描述程序问题的方法是提供最精简的 Bug 展示测试用例（bug-demonstrating test case）
> 15. 别把自己家庭作业的问题贴上来
> 16. 去掉无意义的提问句
> 17. 即使你很急也不要在标题写`紧急`
> 18. 礼多人不怪，而且有时还很有帮助

> 提问后：
> 1. 问题解决后，加个简短的补充说明
> 2. 被回复 RTFM (Read The Fucking Manual) 和  STFW (Search The Fucking Web) ： 意味着**你需要的信息非常容易获得**和**你自己去搜索这些信息比灌给你，能让你学到更多**
> 3. 如果还是搞不懂：别立刻要求对方解释。像你以前试着自己解决问题时那样（利用手册，FAQ，网络，身边的高手），先试着去搞懂他的回应。如果你真的需要对方解释，记得表现出你已经从中学到了点什么。
> 4. 得到无礼的回应：很多黑客圈子中看似无礼的行为并不是存心冒犯。相反，它是直接了当，一针见血式的交流风格，这种风格更注重解决问题，而不是使人感觉舒服而却模模糊糊。 

## 排版规范
本讲义采用 Markdown 编写
## 鸣谢

# 1. Stata 入门介绍
本章主要介绍 Stata 的发展历史、基本知识和环境搭建，本章目的：
- 了解 Stata 历史概况，以及和其他编程语言的对比；
- 熟悉 Stata 界面和 规范书写 do-file 的规则；
- 掌握基本语法结构；
- 设置自定义 profile，提高工作效率；
- 介绍自带新功能 Project Management ；
- 配置 Sublime Text 3 文本编辑器。

## 1.1 背景概述（内+外）
### 1.1.1 Stata 发展的历史
### 1.1.2 与其他语言对比

## 1.2 基本知识
### 1.2.1 操作方式
#### 1.2.1.1 窗口操作
窗口自定义，让界面“更加友好”
#### 1.2.1.2 命令操作
##### do-file
#####  log 文档
##### 注释和换行
##### 如何书写规范的 do 文档？
##### -display-
##### SMCL 语言
> Everything Stata displays on the screen is processed by SMCL.
> You can use SMCL to make your output look better.

SMCL 是 **S**tata **M**arkup and **C**ontrol **L**anguage 的简写，是 Stata 的一种输出语言。输入：
```SMCL
You can output {it:italics} using SMCL
```
输出为：
You can output *italics* using SMCL
Stata 所有的输出都可以使用 SMCL ，比如帮助文档 (help file) 、统计结果 (statistical result)，甚至是编写程序中 `display` 的输出格式。
SMCL 可以在`.smcl` 文件上重新排版，可以使用 `translate` 命令转换为其他格式文件。
```SMCL
display "this is SMCL"
display "{title: this is SMCL, too}"
display "now we will try {help summarize: clicking}"
display "You can also run commands by {stata summarize mpg: clicking}"
```
######  SMCL 模式
SMCL 有三种模式：
1. SMCL line mode
2. SMCL paragraph mode
3. As-is mode

第 1 种是其他两种模式的源头，最初始就 line mode ；第 2 种模式是在标记 `{p}` 和 `{p}` 之间的内容； 第 3 种是在括号内引用，比如 `{title: My Title}"`。当遇见空行的时，会回到 line mode 。
```SMCL
{p}
SMCL, which stands for Stata Markup and Control Language
and is pronounced "smickle", is Stata's output language.
SMCL directives, for example, the {c -(}it:...{c )-} in the following,
 One can output {it:italics} using SMCL
{p} affects how output appears: : : :
```
简单总结，当开始写 SMCL 时，推断从 line mode 开始，如果想使用 paragraph mode 模式，就使用 `{p}` 标记，当段落遇见空行的时候，就会回到 line mode ，再准备开始另一段，如果想使用 as-is mode ，使用 `{asis}` 标记。

###### 语法
####### 通用语法 
|语法|功能|
|:---|:---|
|`{xyz}`|do whatever it is that `{xyz}` does|
|`{xyz: text}`|do whatever it is that `{xyz}`does, do it on the text *text*, and then stop doing it|
|`{xyz args}`|do whatever it is that `{xyz}`does, as modified by args|
|`{xyz args: text}`|do whatever it is that`{xyz}` does, as modified by args, do it on the text text, and then stop doing it|

####### 显示设置
- 字体
`{sf}`, `{it}` 和 `{bf}` 遵循 语法1 和 语法2 分别表示标准字体、意大利斜体和加粗。
```SMCL
the value of {it}varlist {sf}may be specified...
the value of {it:varlist} may be specified...
```
- 颜色
`{input}`, `{error}`,`{result}` 和 `{text}` 遵循 语法1 和 语法2 。
`{inp}`, `{err}`, `{res}` 和 `{txt}` 是上面命令的简写。
```SMCL
{text}the variable mpg has mean {result:21.3} in the sample.
{text}mpg    {c |}{result}21.3
{text}mpg    {c |}{result:21.3}
{error:variable not found}
```
`{cmd}` 也是用于控制颜色，推荐用于显示 Stata commands 。不要混淆 `{cmd}` 和 `{inp}`，`{inp}` 用于显示**输入的内容**，而 `{cmd}` 用于显示**命令**。
写 help file 时，建议在 `{txt}` 的基础上，用 `{cmd}` 展示命令，使用 `{sf}`, `{it}` 或者 `{bf}` 其中之一。同时，不建议使用 `{inp}`,`{err}` 和 `{res}` 来定义颜色，除非的确需要展示 Stata 的输出。
`{cmdad:text1:text2}` 的语法由 语法2 演化而来（注意引号）。`{cmdad}` 推荐用于书写 Stata 命令的最简缩写，`text1` 表示最小缩写，`text2` 表示其他文本。
```SMCL
{cmdab:su:mmarize} [{it:varlist}] [{it:weight}] [{cmdab:if}{it:exp}]
the option {cmdab:ef:orm}{cmd:({it:varname})}...
```
`{opt option}`, `{opt option(arg)}`, `{opt option(a,b)}` 和 `{opt option(a|b)}` 遵循 语法3 ；也可以使用 `{cmd}` 实现。
`{opt option1: option2}`, `{opt option1: option2(arg)}`, `{opt option1:option2(a,b)}` 和 `{opt option1:option2(a|b)}` 遵循 语法3 和 语法4 ；也可以说使用 `{cmdab}` 实现。
`{opt}`推荐用于展示命令的选项。
|SMCL directive| is equivalent to typing...|
|:---|:---|
|{opt option} |{cmd:option}|
|{opt option(arg)} |{cmd:option(}{it:arg}{cmd:)}|
|{opt option(a,b)} |{cmd:option(}{it:a}{cmd:,}{it:b}{cmd:)}|
|{opt option(a|b)} {cmd:option(}{it:a}|{it:b}{cmd:)}|
|{opt option1:option2} |{cmd:option1:option2}|
|{opt option1:option2(arg)} |{cmd:option1:option2(}{it:arg}{cmd:)}|
|{opt option1:option2(a,b)} |{cmd:option1:option2(}{it:a}{cmd:,}{it:b}{cmd:)}|
|{opt option1:option2(a|b)} {cmd:option1:option2(}{it:a}|{it:b}{cmd:)}|

`{hilite}` 和 `{hi}` 遵循 语法1 和 语法2 。建议用于显示需要强调 (draw attention to) 的内容，可能会突出显示 for example, a reference to a manual, Stata Journal 或者其他参考书。
```SMCL
see {hilite:[R] anova} for more details.
se {hi:[R] anova} for more details.
```
`{ul}` 遵循 语法2 和 语法3 ,表示下划线。
```SCML
You can {ul on}underline{ul off} this way or
You can {ul:underline} this way
```
`{*}` 遵循 语法2 和 语法4 ，表示注释。
```SMCL
{* this text will be ignored}
{*: as will this}
```
`{hline}` 遵循 语法1 和 语法 3。
`{hline}` (语法1) 画直到页面末端的横线，`{hline #}` (语法3) 画 # 条横线。`{hline}`在 line mode 中常用。`{.-}` 是 `{hline}` 的同义操作。
```SMCL
{hline}
{hline 20}
```
`{dup #:text}`遵循 语法4 ，表示重复 `text` # 次。
```SMCL
{dup 20:A}
{dup 20:ABC}
```
`{char code}` 和 `{c code}` 是同义的，遵循 语法3 。表示显示指定的字符，否则可能很难在键盘上键入这些字符。参阅下面的使用ASCII和扩展ASCII代码显示字符。
```SMCL
C{c o'}rdoba es una joya arquitect{c o'}nica.
{c S|}57.20
The ASCII character 206 in the current font is {c 206}
The ASCII character 5a (hex) is {c 0x5a}
{c -(} is open brace and {c )-} is close brace
```
`{reset}` 遵循 语法1 ，是 `{txt}{sf}` 的同义操作。
####### 链接
###### 编写 help file 的建议
```Stata
viewsource assert.sthlp // simple example with a couple of options
viewsource centile.sthlp // example with an option table
viewsource regress.sthlp // example of an estimation command
viewsource regress_postestimation.sthlp // example of a postestimation entry
```

#### 1.2.1.3 快捷键

cheat sheet

### 1.2.2 基本语法
#### 1.2.2.1 语法结构

### 1.2.3 操作符号
#### 1.2.3.1 关系运算、逻辑运算、算术运算
#### 1.2.3.2 因子变量

###  1.2.4 外部命令安装

## 1.3 环境配置
### 1.3.1 路径定义
### 1.3.2 profile 设置
### 1.3.4 Do-file Editor
Stata16 中的新功能
### 1.3.5 Project Manager (after Stata15)
### 1.3.6 Sublime Text 3 环境配置 

# 2. Stata 数据管理
[Kohler_2012.pdf](D:\Stata16\ado\personal\PX_A_2020a\A2_data\refs\Kohler_2012.pdf)

## 2.1 数据处理
### 2.1.1 数据导入与导出
#### 2.1.1.1 不同格式的数据
|格式|命令|
|:---|:---|
|tab分隔|insheet|
|空格分隔|infile|
|逗号分隔|infile|
|csv|import,csvconvert|
|dta|系列命令|
|xls;xlsx|xmluse,import,xls2dta|
|spss|usespss|
|R||
|SAS||
[How do I convert among SAS, Stata and SPSS files?](http://www.ats.ucla.edu/stat/stata/faq/convert_pkg.htm)


#### 2.1.1.2 数据编码问题

### 2.1.2 变量修改
#### 2.1.2.1 重命名
```Stata
help rename
ssc install renvars, replace
```
#### 2.1.2.2 增、删和改
改包括 encode
```Stata
help generate
help egen
help egenmore
help drop
help replace
```
###  2.1.3 多种排序
```Stata
help sort
help gsort
help rsort
help sortobs
```
### 2.1.4 转置
```Stata
help xpose
ssc install sxpose, replace
help sxpose // string
```
### 2.1.5 重复值处理
```Stata
help duplicates
```
### 2.1.6 缺失值处理
```Stata
help missing values
```
#### 2.1.6.1 缺失值的形态
#### 2.1.6.2 查找缺失值
```Stata
help misstab
```
#### 2.1.6.3 删除缺失值
#### 2.1.6.4 填补缺失值
```Stata
help carryforward
```
### 2.1.7 离群值的处理
```Stata
help winsor
ssc install winsor2, replace
```
### 2.1.8 字符变量的处理
在第 3 大章专门讲
```Stata
help string function
```
### 2.1.9 日期和时间变量
## 2.2 数据集管理
### 2.2.1 数据集合并
```Stata
help append
ssc install openall, replace
help openall
```
### 2.2.2 数据集匹配
```Stata
help merge
```
### 2.2.3 Stata16 的 Data Frame
>Frames make doing lots of tasks more convenient, and you will find your own uses for them. Frames make code faster too. Manipulating objects stored in memory takes less computer time than manipulating disk files.

```Stata
help frame
```
Data Frame 可以同时在内存中储存多份数据集，可以在多个 Dtata Frame 之间切换，甚至相互链接，而且运行速度比较快。

#### 2.2.3.1 Frames 功能一览
1. 使用 Frame 进行多任务

  可以创建一个新的 Frame ，将另一个数据集加载到其中，做相同的处理，在去掉 Frame 。
```Stata
frame create interruption // 创建一个新 frame
frame change interruption // 转换
use another_dataset
frame change default  // 转换回去
frame drop interruption  // 删去新 frame
```
2. 使用框架执行工作中不可或缺的任务
设想，需要从数据中计算一个值并将其添加到数据中，计算的时候需要改动内存中调入的数据。最常规的操作是：先导入数据 data1 ，然后计算完成后保存为 data2，之后再导入 data1 ，合并进 data2 。
但使用 frame 就不需要再数据之前来回切换，比如下方的例子：
```Stata
frame copy default subtask // 创建，并复制数据到新 frame
frame change subtask // 切换到新 frame
sort weight foreign  // 开始计算
keep if mark1 | mark2 // 删除观测
regress dmpg dw if mod(_n,2)  // 计算 troublesome value
frame change default  // 切换回先前的 frame 
gen dwc = cond(foreign, _b[dw], 0) // 注意调用的是存在内存中的值 _b[dw]
frame drop subtask  // 删除创建的新 frame
```
也可以使用 `preserve` 和 `restore` 来实现上述需求，但是熟悉 frame 之后，会觉得 frame 更加方便，因为不需要来回导入数据、修改内存中的数据。注意上例中调用的 `_b[dw]` 是存在内存中的值。

3. 使用框架同时处理单独的数据集
同时处理单独数据集的意思是，数据集之间可以链接（linked）。链接数据是匹配数据的一种替代方案。
比如这个例子：现有两份数据，一份是微观层面的个体数据`person.dta`，另一份是国家层面的国家数据`uscounties.dta`，需要分析统计 person 的国别。在处理这个工作的时候，有几个地方需要注意：
- `person.dta` 数据中，很多 person 住在同一个 country;
- `uscountries.dta` 数据中的城市没有 person 住；
- 不能肯定 `uscountries.dta` 中的国家是否完整，也许 person 居住的城市不在其中；
- 除此之外，只需要 `uscountries,dta` 中的个别变量用于分析。

用 frame 来解决的思路是链接两份数据，首先加载 `person.dta` 数据到 一个  frame ，再加载到 `uscountries,dta` 到另一个 frame 。
```Stata
use person.dta, clear
frame create uscountries
frame uscountries: use uscountries
```
链接两份数据，需要进行如下操作：
```Stata
frlink m:1 countryid, frame(uscountries)
```
进行上述操作之后，这会根据变量 Countyid 相等的取值将 `person.dta` 中的观测值与 `uscounties.dta` 中的观测值匹配。两份数据并不是合并，而是链接在一起。没有来自`uscounties.dta` 的变量被复制到 `person.dta` 中 ，但是 Stata 已经知道了该如何复制变量。
```Stata
frget med_income nschools, from(uscountries)
```
通过 `frget` 命令可以将变量复制到 `person.dta` 数据，接下来就可以按照需求进行分析了：
```Stata
regress income med_income n_schools edu age
```
4. 使用框架记录从模拟收集的统计数据
> Simulations involve repeating a task—performing a simulation—each step of which produces statistics that are somehow recorded. After that, you analyze the recorded statistics.

模拟涉及重复任务（执行模拟），每个步骤都会产生以某种方式记录的统计信息。之后，您分析记录的统计信息。
模拟问题的框架解决方案是在另一个框架中收集统计信息。我们会
命名该框架 result 。首先创建一个新框架，并在其中记录变量
统计信息，例如 b1coverage 和 b2coverage ：
```Stata
frame create result b1coverage b2coverage
```
新框架 result 目前还没有观测值。接下来，可以编写 do 文件来创建要在每次迭代后存储的值。在每次迭代结束时，do文件要包含以下行：
```Stata
frame post result (exp1) (exp2)
```
exp1 和 exp2 为表达式，当  do 文档执行完毕之后，`frame post` 命令会将 exp1 和 exp2 的运行结果储存在 result 中。然后储存结果：
```Stata
frame resluts: save filename
```
然后切换到 result 框架，开始分析：
```Stata
frame change results
summarize
```
#### 2.2.3.2 Frame 使 Stata (preserve/restore) 运行速度更快
使用 `prerstore` 和 `restore` 的机制在于 Stata 将数据复制到了隐藏的 frame，隐藏的 frame 储存在内存中。将数据复制到储存在内存的 frame会快于复制到硬盘。
更准确的说法是，除非内存不足，否则 `preserve` 会将数据复制到隐藏的 frame 中。否则，`preserve` 会将其存储在磁盘上。这是暂时的，因为稍后在还原数据集时，内存将再次变为可用，并且 `preserve` 将恢复为将其保存在隐藏的 frame 中。
这都是 Stata 自动完成的，但可以通过设置 `max_preservemen` 的值进行控制。当隐藏 frame 中存储的数量超过最大保留容量时，Stata 将后续数据集保留在磁盘上。默认的最大 `preservemem` 为 1 GB。可以通过如下命令查询和设置设置最大内存。
```Stata
query memory
set max_preservemen 2g
set max_preservemen 2g, permanetly
```
#### 2.2.3.3 Frame 使用介绍
- 当前 frame 
```Stata
sysuse auto, clear // 加载数据即为当前 frame
frame // 查询 frame, 名称为 default
* (current frame is default) 
pwf // print working frame

*frame rename oldname newname // frame 重命名
frame rename default genesis 
```
- 创建新的 frames
```Stata
*frame create newframename
frame dir
*genesis 74 x 12; 1978 Automobile Data
```
上例 `frame dir` 输出结果表示名为 genesis 的 frame，包含 74 观测，12 变量；数据标签为 `1978 Automobile Data`。接下来，创建一个新的 frame：
```Stata
frame create second
frame dir
/*
genesis 74 x 12; 1978 Automobile Data
second 0 x 0
*/

mkf third // shorter synonym,make frame
```
上面代码的执行结果表示，现在内存中有两个 frame ,第二个 second 为空。

- `frame` 还是 `frames`? 
```Stata
frames dir
frame dir
```
答案：`frame` 和 `frames` 命令没有区别。
- 切换 frames 
```Stata
*frame change framename
*cwf // change working frame
frames change second
count // 0
cwf gensis
count // 74
```
- 复制 frames
有两种方式复制 frames：
```Stata
frame copy framename newframename // 方式1
frame put varlist, into(newframe) // 方式2
frame put if, into(newframe)
```
`frame copy` 复制整个数据集，`frame put` 复制数据的子集。

- 删除 frames
```Stata
frame drop framename
```
- 重置 frames
重置 frame 意味着:
1. 删除当前 frame 的所有数据，即使上次修改还未保存。
2. 删除所有 frames。
3. 创建一个名为 default 的新 frame，让其成为当前 frame。
可以通过以下三种方式实现：
```Stata
frames reset
clear frames
clear all
```
- Frame 命令前缀
命令的结构为 `frame framename: stata_command`，会实现如下三种操作：
1. 从当前 frame 切换到指定的 frame。
2. 执行 `stata_command`。
3. 返回到起初的 frame。
```Stata
frame second: sysuse auto, clear
*等价于以下：
frame change second
sysuse auto,clear
frame change default
```
用 frame prefix 相对分开执行好处在于，如果 `stata_command` 执行失败还是会停留在起初的 frame。
frame 也可以用于代码块，语法如下：
```Stata
frame framename{
    stata_command
    stata_command
}
````
- 链接 frames
```Stata
* 创建链接
frlink m:1 varlist, frame(framename)
frlink 1:1 varlist, frame(framename)
* 复制合要求的值和变量
frget varlist, from(linkagename)
frget newvar = varname, from(linkagename)
* 访问链接后数据中，链接上变量的观测值
... frval(linkagename, varname) ...
```
- post 数据到 frame
`post` 一般用于需要从一个 frame 中计算数据或者值，用于另外一个 frame 。

```Stata
*frame create newframename // syntax1
*frame create newframename newvarlist // syntax2

*创建一个新的 frame ，指定类型
frame create results strL(rngstate) double(blcoverage b2coverage)

*frame post
frame post framename (exp) (exp)...(exp)
```
#### 2.2.3.4 Frames 用于编程
- Ado 编程
1. `tempnames`
2. current frame
3. `preserve and restore`
- Mata 编程
1. `st_frame*()` funcations
2. `st_data()`, `st_sdata()`, `_st_data()`和 `_st_sdata()` 函数
3. `st_view()` 和 `st_sview()` 函数


# 3. 编程基础
## 3.1 基本元素 (scalar, local and macro)
## 3.2 返回值
## 3.3 条件语句与循环语句
### 3.2.1 条件语句
### 3.2.2 循环语句
## 3.4 示例

# 4. 报告自动化
```Stata
help dyndoc
help markdown
```

# 5. Stata 文本分析与正则表达式

# 6. Stata 数据爬取

# 7. Stata 可视化

# 8. Stata 程序开发

# 9. Stata 与 Python 
## 9.1  Stata 与 Python 等效操作
[Stata to Python Equivalents](http://www.danielmsullivan.com/pages/tutorial_stata_to_python.html#id2)
[Comparison with Stata](https://pandas.pydata.org/pandas-docs/stable/getting_started/comparison/comparison_with_stata.html)

###  9.1.1 数据结构
|Stata|pandas|
|:---|:---|
|data set|DataFrame|
|variable|column|
|observation|row|
|bysort|groupby|
|.|NaN|

Series 是 Python 中的另外一种数据结构，Series 只有 DataFrame 的一列。DataFarme 和 Series 都有 Index，如果不经特殊指定，每一行数据的标签默认为从 0 到 n 的整数，类似 Stata 中的 `_n` 。

### 9.1.2 输入输出数据
|Stata|Python|
|:---|:---|
|`log using <file>` |`print`或者用 jupyter notebook|
|`help <cmd>`|`help(<cmd>)` 或者 `<cmd>?`|
| `cd <directory>`|`import os` <br>`os.chdir(<directory>)`|
|`use <dtafile>`|`import pandas as pd `<br>`df = read_stata('<dtafile>')`|
|`use <varlist> using <dtafile>`| `df =read_stata('<dtafile>'), columns = <varlist>)`|
|`import excel using <excelfile>`|`df = pd.read_excel('excelfile')`|
|`import delimited using <csvfile>`|`df = read_csv('<csvfile>')`|
|`save <filename>, replace`|`df.to_stata('<filename>')`或者 `df.to_pickle('<filenme>')`|
|`outsheet using <csv_name>, comma`|`df.to_csv("<csv_name>")`|
|`export excel using <excel_name>`|`df.to_excel('<excel_name>')`|

### 9.1.3 样本筛选
|Stata|Python|
|:---|:---|
|`keep if <condition>`|`df = df[<condition>]`|
|`drop if <condition>`| ` df = df[~(<condition>)`]|
|`keep <var>`|`df = df[<var>]`|
|`keep varstem*`|`df = df.filter(like='varstem*')`|
|`drop <var>`| `del df[<var>]` 或者 `df = df.drop(<var>, axis=1)`|
|`drop varstem*`|`df = df.drop(df.filter(like='varstem*').columns,axis=1)`|

### 9.1.4 描述性统计
|Stata|Python|
|:---|:---|
|`describe`|`df.info()` 或者 `df.types` 只能获取数据类型，Python 中没有 Stata 中的数据标签 ( value label )|
|`describe <var>`|`df[<var>].dtype`|
|`count`|`df.shape[0]` 或者 `len[df]`，`df.shape`会返回一个具有 DtataFrame 长度和宽度的元组|
|`count if <condition>`|`df[<condition>].shape[0]` ，如果条件包含于 DataFrame ，可以通过`(<condition>).sum()` 实现，比如`df.['age'] > 2).sum()`|
|`summ <var>`|`df['<var>'].describe()`|
|`summ <var> if <condition>`|`df[<condition][<var>].describe()` 或者 `df.loc[<condition>],[<var>].describe()`|
|`summ <var> [aw = <weight>]`|目前暂时需要手动计算权重信息，`Statsmodels`包提供了一些工具|
|`summ <var>, detail`|`df[<var>].describe()` 或者 `df[<var>].quantile([.1, .25, .5, .75, .9])` 等其他所需要的信息|
|`list in 1/5`|`df.head()`|

### 9.1.5 数据管理
| Stata                                                        | Python                                                       |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| `gen <nwevar> = <expression>`                                | `df[<newvar>] = <expression>`                                |
| `gen <newvar> = <expression> if <condition>`                 | `df.loc[<condition>, <newvar>] = <expression>`，不同于 Stata ，Python 中不符合条件的 df 行将为缺失(numpy.nan) |
| `replace <var> = <expression> if <condition>`                | `df.loc[<condition>, <var>] = <expression>`                  |
| `rename <var> <newvar>`                                      | `df = df.rename(columns={<var>:<newvar>})`，也可以像列表一样直接操作 `df.columns`，比如 `df.columns = ['a','b','c']` |
| `inlist(<var>,<var1>,<var2>)`                                | `df[<var>].isin(<var1>,<var2>)`                              |
| `inrange(<var>,<var1>,<var2>)`                               | `df[<var>].between(<var1>,<var2>)`                           |
| `egen <newvar> = count(<var>)`                               | `<newvar> = df[<var>].notnull().sum()`，值得注意的是，Stata中`egen` 命令的这些函数，生成的 newvar 在 Stata 中是完整（常量）列，而在 Python 中是 scalar 。 |
| `egen <newvar> = group(<varlist>)`                           | `<newvar> = ecotools.group_id(df, cols=<varlist>)`           |
| `egen <newvar> = max(<var>)`                                 | `<newvar> = df[<var>].max()`                                 |
| `egen <newvar> = mean(<var>)`                                | `<newvar> = df[<var>].mean()`                                |
| `egen <newvar> = total(<var>)`                               | `<newvar> = df[<var>].sum()`                                 |
| `collapse (sd) <var> (median) <var> (max) <var> (min) <var>, by(<groupvars>)` | `df.groupby(<groupvars>)[<var>].agg(['std','median','min','max','sum'])` |
| `collapse (<stat>) <var> [iw = <weight>]`                    | 手工计算或通过调用 statamodels 包                            |
| `collapse (<stat>) <stat_vars>, by(<groupvars`               | `df.groupby(<groupvars>)[<stat_vars>],<stat>()`              |
| `sort <var1> <var2>`                                         | `df.sort_values([var1, var2])`                               |
| `subinstr(<str>," ","_",.)`                                  | `df[<var>].str.replace(' ','_')`                             |
| `substr(<str>, 1, 1)`                                        | `df[<var>].str[0:1]`                                         |
| `length(<var>)`                                              | `df[<var>].str.len()`                                        |
| `ustrlen(<var>)`                                             | `df[<var>].str.rstrip().str.len()`                           |
| `strpos(<var>, "sub")`                                       | `df[<var>].str.find("sub")`                                  |
| `strupper(<str>)`                                            | `df[<str>].str.upper()`                                      |
| `strlower(<str>)`                                            | `df[<str>].str.lower()`                                      |
| `strproper(<str>)`                                           | `df[<str>].str.title()`                                      |
| `recode <var> (1/5 = 1)`                                     | 不适用，见表格末尾说明                                       |
| `recode <var> (1/5 = 1),gen(<newvar>)`                       | 不适用                                                       |
| `label var <var> <label>`                                    | 不适用                                                       |
| `label define <labelname> 1 <labelvalue>`                    | 不适用                                                       |
| `label values <var> <labelname>`                             | 不适用                                                       |
| `label list <labelname>`                                     | 不适用                                                       |
说明：Python 的 DataFrame 里面没有 Stata 中 label 的概念，必要时，可以通过定义字典映射变量的取值和标签。 
```Python
variabel_labels = {
    1: "First Category"
    2: "Second Category"
    3: "Last Category"
}
```

### 9.1.6 面板数据
在 Python 中，没有与 `tsset` 等效的常规方法。但是可以使用 DataFrame 的索引（行的等效列）来完成大多数（但不是全部）相同的任务。在 Stata 中，内存中的 “DataFrame” 始终具有观察行号，由 Stata 内置变量 ` _n` 表示。在 Python 和 Pandas 中，DataFrame 索引可以是任何值（尽管您也可以通过行号引用行；参见 .loc 与 iloc ）。它也可以具有多个级别的层次结构，这是比 `tsset` 更通用的工具 。
|Stata|Python|
|:---|:---|
|`xtset <panemvar> <timevar>`|`df = df.set_index([<panelvar>, <timevar>])`|
|`L.<var>`|`df.shift()`，索引必须正确排序才能使`shift` 正确使用|
|`L2.<var>`|`df.shift(2)`|
|`F.<var>`|`df.shift(-1)`|

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
### 9.1.7 数据合并与匹配
|Stata|Python|
|:---|:---|
|`append using <filename>`|`df_joint = df1.append(df2)`|
|`merge 1:1 <vars> using <filename>`|如果 `<vars>` 是 DataFrame 的索引，则 `df_joint = df1.joint(df2)`；否则，`df_joint = pd.merge(df1, df2, on=<vars>)`。注意，`pd.merge` 不会保留原数据集的索引。注意：Python 中的合并就像 R，SQL 等。需要更可靠的解释。|
Pandas DataFrames 匹配不需要指定“多对一”或“一对多”。
Pandas 会根据要合并的变量是否唯一来自动确定。但是，可以使用关键字参数how来指定要保留的合并子样本，例如 `df_joint = df1.join(df2,how='left')`是 `join` 的默认值，而 `how ='inner'` 是 `pd.merge` 的默认值。
|Pandas how|Stata, keep()|Intuition|
|:---|:---|:---|
|`how='left'`|`keep(1, 3)`|保留 DataFrame "left" 所有的观测值|
|`how='right'`|`keep(2, 3)`|保留 DataFrame "right" 所有的观测值|
|`how='inner'`|`keep(3)`|保留匹配上的观测值|
|`how='outer'`|`keep(1 2 3)`|保留所有观测值|

### 9.1.8 长宽转换
与 merge 一样，在 Python 中 reshape DataFrame 的方式也有所不同，因为 Stata 的数据是“内存中唯一数据表”，而DtataFrame在 Python 只是另一个对象/变量，这种区别也使得在 Python 中进行reshape 变得更加容易。
Python/Pandas中最基本的 reshape 命令是`stack` 和 `unstack`。
```Python
import pandas as pd
import numpy as np
# 输入数据
long = pd.DataFrame(np.arange(8), columns=['some_variable'], index=pd.MultiIndex.from_tuples([('a',1),('a',2),('b',1),('b',2),('c',1),('c',2),('d',1),('d',2)]))
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
上文的代码中，首先创建一个 DataFrame ，然后为每个索引列指定一个名称，为该列命名。对应到 Stata ，可能觉得列名本身就有 "name" 有点难理解，但列名也只是像行名一样的索引。
当认识到列不必是字符串时会更好理解。列名可以是整数，例如年份或 FIPS 代码。在这些情况下，给列起一个名字很有意义，这样就知道要处理的内容。
`long.unstack('time')` 进行 reshape ，它使用索引 'time' 并创建一个新的它具有的每个唯一值的列。请注意，这些列现在具有多个级别，就像以前的索引一样。这是标记索引和列的另一个很好的理由。**如果要访问这些列中的任何一列，则可以照常执行操作，使用元组在两个级别之间进行区分。**

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
|Stata|Python|
|:---|:---|
|`reshape <wide/long> <stubs>, i(<vars>) j(<var>)`|wide: `df.unstack(<level>)`;long: `df.stack(<column_level>)`; 也可参照 `df.pivot`|

### 9.1.9 计量
|Stata|Python|
|:---|:---|
|`ttset <var>, by(<var>)`| `from scipy.stats import ttest_ind` <br> `ttset_ind(<array1>, <array2>)`|
|`xi: i.<var>`|`pd.get_dummies(df[<var>])`|
|`i.<var2>#c.<var1>`|`pd.get_dummies(df[<var2>]).multiply(df[<var1>])`|
|`reg <yvar> <xvar> if <condition>, r`|`import econtools.metrics as mt` <br> `results = mt.reg(df[<condition>], <yvar>, <xvar>, robust = True)`|
|`reg <yvar> <xvar> if <condition>, vce(cluster <clustervar>)`|`import econtools.metrics as mt` <br> `results = mt.reg(df[<condition>], <yvar>, <xvar>, cluster=<clustervar>)`|
|`areg <yvar> <xvar>, absorb(<fe_var>)`|`result = mt/reg(df, <yvar> <xvar>, a_name=<fe_var>)`|
|`predict <newvar>, resid`|`<newvar> = result.resid`|
|`predict <newvar>, xb`| `<newvar> = result.yhat`|
|`_b[<var>], _se[<var>]`|`result.beta[<var>], result.se[<var>]`|
|`test <varlist>`| `result.Ftest(<varlist>)`|
|`test <varlist>, equal`|`result.Ftest(<varlist>, equal=True)`|
|`lincom <var1> + <var2>`|`econtools.metrics.f_test` with appropriate parameters|
|`ivreg2`|`econtools.metrics.inreg`|
|`outreg2`|`econtools.outreg`|
|`reghdfe`|None(hope to add it ro Econtools soon)|

### 9.1.10 可视化
在 Python 中，可视化推荐 `Matplotlib`和 `Seaborn` 两个包。
|Stata|Python|
|:---|:---|
|`binscatter`|`econtools.binscatter`|
|`maptile`|Not quick tool, but easy to do with Cartopy.|
|`coefplot`|`ax.scatter(result.beta.index, result.beta)` often works. Depends on context.|
|`two way scatter <var1> <var2>`|`df.scatter(<var2>, <var1>)`|

### 9.1.11 其他方面
#### 9.1.11.1 缺失值
在 Python 中，缺失值由 NumPy “非数字” 对象 np.nan 表示。在Stata，缺失值（.）大于每个数字，所以10 < . 为 True 。在Python中，np.nan 不等于任何东西。任何涉及 np.nan 的比较都始终为False ，即使 `np.nan == np.nan` 。
要在DataFrame列中查找缺失值，使用以下任何一种：
- `df[<varname>].isnull()` 返回一个每行值为 True 和False值的向量 `df[<varname>]`。
- `df [<varname>].notnull()` 是`.isnull()` 的补充。
- `np.isnan(<arraylike>)`函数接受一个数组数组（DataFrame是数组的一种特殊类型）并为每个元素返回 True 或 False 。
另一个重要的区别是 np.nan 是浮点数据类型，因此 DataFrame 的任何列包含缺失数字的将是浮点型的。如果一列整型数据改变了，即使只有一行 np.nan ，整列将被转换为浮点型。
#### 9.1.11.2 浮点数相等
在 Stata 中，小数和任何值都不相等，比如 3.0==3 是 False 。而在 Python 会返回 True 。

## 9.2 Stata 中调用 Python
### 9.2.1 命令概览
|命令|用途|
|:---|:---|
|`python`|在 command 窗口输入，进入交互模式|
|`python: istmt`|执行一个 Python 简单语句或多个用分号分隔的简单语句|
|`python script`|运行后缀为`.py`的 Python 脚本，可以通过 `args()` 选项传入参数|
|`python set exec pyexecutable`|设置所使用 Python 的版本，路径为电脑上安装的可执行的 Python|
|`python set userpath path [path...]`|设置 modules 搜索路径以及系统搜索路径。可以指定多个路径。指定后，这些路径将在初始化Python环境时自动加载|
|`python describe`|列印`_main__`模块 namespace 中的对象|
|`python drop`|删除`_main__`模块 namespace 中的对象|
|`python clear`|从主模块的 namespace 中清除所有名称不带有`_`前缀的对象|
|`python query`|列印当前 Python 设置和系统信息|
|`python search`|查找当前操作系统中已安装的 Python 版本，只显示 Python2.7 及以上的|
|`python which`|显示可用的 Python 模块|
说明：通过`python search` 查找可用版本时，Windows系统中仅会搜索通过官方安装或 Anaconda 安装的版本；在 Unix 或 Mac 系统上，会搜索` /usr/bin/`, `/usr/local/bin/`, `/opt/local/python/bin/`, `~/anaconda/bin` 或 ` ~/anaconda3/bin`路径下安装的 Python 版本。

### 9.2.2 主要选项
|命令|用途|
|:---|:---|
|`arg(args_list)`|指定参数，可以是单个参数，或者用**空格**分隔的多个参数|
|`global`|指定将在 Python 脚本文件中创建的对象附加到主模块的 namespace ，以便可以全局访问|
|`userpaths(user_path[, prepend])`|指定将添加到内存中的其他模块搜索路径|
|`permanently`|在下次更改前，保存设定|
|`prepend`|指定将路径添加到系统路径的前面|
|`all`|设定列印`_main__`模块的 namespace 中的所有对象，默认只显示带下划线|

### 9.2.3 调用方式
#### 9.2.3.1 交互式调用
```Stata
/*--- 以下在 command 窗口输入 ---*/
python  // 进入 Python 环境
print("hello, world")
word = 'Python'
word[0], word[-1]
len(word)

from math import pi
[str(round(pi, i) for i in range(1,8))}

for i in range(3):
    print(i)

end // 退出 Python 环境
```
输入 `end` 只是退出 Python 环境，Python 环境并没有清除，下次输入 `python` 或者 `python:` 时又会回到 Python 环境。交互式调用产生的所有对象都储存在 `__main__` 的命名空间之中，退出 Python 环境又回来可以继续使用。在 Stata 中，可以通过 `python describe`, `python drop` 和 `python clear` 管理这些对象。

在交互式环境中，可以在 Python 中输入 `stata:` 前缀的命令执行 Stata 代码，比如 `stata: display "hello, world"`。但这种方式只能在交互调用中使用，不能在 Python 脚本中使用。 在 Python 脚本中，可以通过调用 `sfi` (Stata Function Interface) 包中的 `stata()` 函数运行 Stata 的代码。

##### 9.2.3.1.1  python 和 python: 的区别
- `python` (不带冒号) 遇见错误也会保留在 Python 环境中。
- `python:` (带冒号) 遇到 Python 错误时将会回到 Stata 。

##### 9.2.3.1.1 在 do-file 中内嵌 Python 代码
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
上例在 Stata do-file 中嵌入了 Python 代码，核心是理解进入和退出 Python 环境后代码运行的机制。当遇见 `python:` 会进入 python 交互环境，进而逐行执行 Python 代码，当遇见 `end` 的时候会跳出 Python 环境返回到 Stata 环境，但 Python 环境下的对象都被存在了 `__main__` 的命名空间下，所以可以供后续 Stata 调用。
#### 9.2.3.2 运行 Python 脚本
> Be aware that Stata and Python use different syntax, data structures and types, language infrastructures, etc. They even have different rules for handling comments and indentations. (Stata Manual)

Stata 和 Python 是两种不同的语言，具有不同的语法、数据结构和注释等，所以最好是将 Stata 和 Python 的代码分开（isolate）写。运行时，将 Python 代码存为 `.py` 后缀的脚本，然后在 Stata 中通过 `python scripy pycodes.py` 命令执行 Python 代码。
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
上面两段分别为 Python 和 Stata 代码，首先用 Python 写了求和的函数，然后使用 Stata 的 do-file 去执行脚本。在 do-file 中，首先定义了两个暂元 `a` 和 `b`，然后执行 Python 脚本，在 Python 代码中，通过 sfi 模块将结果存为了 scalar，所以在 do-file 中可以直接 `display` 。
但要注意，通过脚本执行的 Python 代码中所有对象在脚本执行完之后不会保存，它们不会添加到 `__main__` 的命名空间。换言之，脚本执行产生的对象不与 `__main__` 共享命名空间，这意味着不能在 Python 脚本中调用在主模块中定义的对象。
要在脚本中使用主模块的对象，可以 通过 `import` 或者 `import - from` 调用。比如，可以在脚本中添加 `import __main__` 来使用主模块中定义的对象。

另一方面，如果想在交互环境中调用脚本执行后的对象，可以在 `python script` 命令后面附加 `global` 选项。附加 `global` 选项之后，所有的对象都会被复制到 `__main__` 的命名空间之下，所以可以不需要 import 直接使用。**这在定义函数、类等时非常有用**。在脚本执行后产生的对象可以在交互环境或 do-file 中调用它们。**然而，要谨慎使用 `golbal` 选项，因为在同名的情况下，来自脚本对象会覆盖 (overwrite)  `__main__` 命令空间下的对象。**

可以通过 `args()` 选项在 Stata 中向 Python 脚本传参数，要在脚本中接收参数，使用 `sys`模块中 `argv`列表来定义。比如下例：
```Python
# saved as pyex2.py
import sys
pya = int(sys.argv[1])
pyb = int(sys.argv[0])

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
在 Python 脚本中，先引用了 `sys` 模块，然后通过 `sys.argv` 列表接收了参数。在上例中，因为要向脚本传入 2 个参数，所以通过 `sys.argv[1]` 和 `sys.argv[2]` 接收参数。**值得注意的是，运行 Python 脚本时，`sys.argv[0]` 被用来储存脚本的名称了，在上例中，`sys.argv[0]` 为 pyex2.py。**在 do-file 中，通过 `python script` 的 `args()` 选项向 Python 脚本传入了两个 macro 作为参数。

使用 `python script` 时，会发现还有一个有用的选项 `userpaths()`, 它可以用来在自定义的路径中导入模块。默认情况下，你指定的路径会位于列表的末端，但是可以通过 `prepend` 选项将它挪到前端，命令的写法为`userpaths(userpath, prepend)` 。
添加的路径只是临时的添加到了 `sys,path`，这意味着只有执行脚本的时候才会生效。在脚本运行完毕后，它们会从列表中删除。要永久的添加路径，可以通过 `python set userpath` 命令。

#### 9.2.3.2 在 ado-file 中内嵌 Python 代码
```Stata
program varsum
    version 16.0
    syntax varname [if] [in]
    marksample touse
    python: calcsum("`varlist'","`touse'")
    display as txt " sum of `varlit`:" as res r(sum)"
end

version 16.0
python:
from sfi import Data, Scalar
def calcsum(varname, touse):
    x = Data.get(varname, None, touse)
    Scalar.setValue("r(sum)", sum(x))
end
```
上面这段代码定义了名为 `varsum` 程序，实现报告变量和的功能。试着调入 auto.dta 数据然后运行程序：
```Stata
sysuse auto, clear
varsum price
* sum of price: 456229
```
逐步解读上面的代码：
1. ado-file 中既有 ado 代码，又有 Python 代码。
2. ado 代码解析并识别了要使用数据的子样本。
3. ado 代码使用 `python: istmt` 调用 Python 的 `calcsum()` 函数进行计算。 
4. Python 代码首先从sfi 包中 import 两个类：Data 和 Scalar。然后定义了 `calcsum()` 函数。`calcsum()` 函数首先接收数据中两个变量作为参数，分别是要用于求和的变量和用于子集的变量。

在上例这种运行方式中，主要注意两点：一是在 ado-file 中定义值传入 Python 的函数，二是将 Python 计算的结果返回给 ado 代码。上例中，ado 定义的值传入作为`calcsum()` 函数的参数，当运行下方代码调用函数时：
```Stata
python: calcsum("`varlist'": "`touse'")
```
代码会自动扩展，变成：
```Stata
python: calcsum("price", "__0001dc")
```
`___0001dc` 是由早先在 ado-file 中 `marksample` 创建的临时变量，`price` 是用户自定义的变量。拓展之后，参数都会转为字符串( After expansion, the arguments were nothing more than strings)，然后被传入至 `calcsum()` 函数。

>Macro substitution is the most common way values are passed from Stata to Python functions. When writing your Python function, keep in mind the arguments that Stata will find convenient to pass and that Python will make convenient to use：
>1. numbers, such as 2 and 3 ("\`a'"and  "\`b'" in pyex1.do)
>2. names of variables, macros, scalars, matrices, etc., such as `price` and `__0001dc`  ("\`varlist'"and "\`touse'")

**用 Macro 作为替代是将 Stata 值传入 Python 函数最常用的方式。在写 Python 函数的时候，牢记 Stata 便于寻找， Python 方便调用的参数特点:**

1. 数字，比如 2 和 3 （pyex1.do 中的 "\`a'" 和 "\`b'"）
2. 变量名，宏，标量，矩阵等，比如 `price` 和 `__0001dc` ("\`varlist'" 和 "\`touse'")

接收第 1 类的参数，需要在函数中声明参数为数值型，然后使用 Stata 的引用符号 (Stata's quotes notation) 传入参数。接收第 2 类参数，需要在函数中声明参数为字符型，然后使用 sfi 模块中所定义的类和函数提取参数中的内容。

另一方面，也会用到 sfi 模块中定义的类和函数将结果返回到 Stata 。比如，会用到 `r()` 返回值，或者使用 `e()` 和 `s()`。也可以在 Python 中创建 Stata 的宏 (mcros) 、标量 (Scalars) 、矩阵 (matrices) ，甚至是 Mata 对象。

此处提供一些 Stata 和 Python 互传值的准则：
1. 若处理变量名，请参阅在 Python 中通过 Dtata 和 Frame 定义的函数。
2. 若处理暂元 (local) 、全局宏 (global macro)、标量 (scalar) 或矩阵 (matrices)，请参阅 Macro, Scalar 和 Matrix 类。
3. 参阅 `sfi` 模块获取更详尽的描述和其他函数。

记住 ado-file 中定义的 Python 对象都是私有 (private) 的，不能在 ado-file 以外进行调用。所以 ado-file 中产生的对象，不能在交互模式下、do-file 或其他 ado-file 中调用。然而，可以在 `python[:]` 和 `end` 的代码块之间，使用 `import` 或者 `import-from` 将对象加入 `__main__`的命名空间，以调用这些对象（意思就是在 ado-file 内部可以通过添加到主模块的方式进行调用）。

上面的例子中，通过 `python[:]` 将 `calcsum()` 函数放入 ado-file 中，也可以另写为 Python 包，之后 import 进 ado-file。可以将上例改写为：
```python
# saved as pyex3.py
from sfi import Data, Scalar
def calcsum(num1, num2):
    x = Dtata.get(varname, None, touse)
    Scalar.setValue("r(sum)", sum(x))
```
上面实现了将计算部分写为 Python 的包，之后再在 ado-file 中进行调用：
```Stata
program varsum
    version 16.0
    syntax varname [if] [in]
    marksample touse
    python: calcsum("`varlist'", "`touse'")
    display as txt " sum of `varlist': " as res r(sum)
end

version 16.0
python:
from pyex3 import calasum
end
```
对比改写前后，可以发现：
1. 原来的 Python 代码移到了名为 pyex3.py 的包。
2. 现在 ado-file 中的 Python 代码仅有使用 `from-import` 调包，使用 `import` 调入整个包也可以。
3. 要正确的 `import`，需要确保 Stata 可以找到包的地址。

前后两种写法各有千秋，可以根据实际情况和个人习惯进行选择。两者的对比如下：
1. 将 Python 代码放在 ado-file 中更简单和方便。
2. 单独将 Python 代码另存，可以在其他 ado-file 也进行调用，如果要重复利用某项功能，这样更好用。
3. 在一些情况下，可以配合使用。比如，假设现有的模块文件中定义了一些实用程序函数 (比如，pyutil.py)，并且想在 `calcsum()` 函数中调用这些实用程序。您无需将这些实用程序复制到 ado-file 中即可在 `calcsum()` 中使用。相反，可以直接 从现有模块 `import`，并直接在 ado-file 中使用它们。

### 9.2.4 Stata Function Interface (sfi) 模块
#### 9.2.4.1 概览
`sfi` 模块将 Python 的灵活性与 Stata 的内核相结合。`sfi` 模块可以在交互式、do-file 和 ado-file 中使用。

此模块中，定义了提供 Stata 字符、当前数据集、数据和时间、宏、标量、矩阵、变量标签和 Mata 全局矩阵等的类。下表是这些类的概览：
|Class|Description|
|:---|:---|
|Characteristic|This class provides access to Stata characteristics.|
|Data |This class provides access to the Stata dataset in memory.|
|Datetime |This class provides access to Stata date and time values.|
|Frame |This class provides access to a Stata data frame.|
|FrameError |This class indicates that an exceptional condition has occurred within a frame.|
|Macro |This class provides access to Stata macros.|
|Mata |This class provides access to global Mata matrices.|
|Matrix |This class provides access to Stata matrices.|
|Missing |This class provides tools for handling Stata missing values.|
|Platform |A set of utilities for getting platform information.|
|Preference |A set of utilities for loading and saving preferences.|
|Scalar |This class provides access to Stata scalars.|
|SFIError |This class is the base class for other exceptions defined in this module.|
|SFIToolkit |This class provides a set of core tools for interacting with Stata.|
|StrLConnector| This class facilitates access to Stata’s strL datatype.|
|ValueLabel |This class provides access to Stata’s value labels.|

在 Python 中，可以通过 `import sfi` 或 `from sfi import *` 调用整个模块。或调入特定的类，比如调用 Dtata 和 Macro ，可以使用 `from sfi import Data, Macro`。
导入类之后，就可以使用其中的函数了。可参阅 [Stata's Python API](https://www.stata.com/python/api16/) ，提供了类和函数详细的使用文档。

#### 9.2.4.2 详解
[Stata's Python API](https://www.stata.com/python/api16/) 
##### 9.2.4.2.1 Characteristic
- 方法概览
|Method|Description|
|:---|:---|
|getDtaChar(name)|Get a characteristic for the current dataset.|
|getVariableChar(var, name)|Get a characteristic for a variable in the current dataset.|
|setDtaChar(name, value)|Set a characteristic for the current dataset.|
|setVariableChar(var, name, value)|Set a characteristic for a variable in the current dataset.|

- 使用详述
- 示例
```Stata
from sfi import Characteristic as char
stata: sysuse auto, clear
char.setDtaChar('one', 'this is the named one of _dta')
char.setDtaChar('two','this is the named two of _dta')
char.setVariableChar('mpg', 'one', 'this is char named one of mpg')
char.setVariableChar('mpg', 'two', 'this is char named two of pmg')
stata: char list
char.getDtaChar('one')
char.getDtaChar('two')
char.getVariableChar('mpg', 'one')
char.getVariableChar('mpg', 'two')
```
##### 9.2.4.2.2 Data
- 方法概览
|Method|Description|
|:---|:---|
|addObs(n[, nofill])|在当前数据集中新增 n 个观测值|
|addVarByte(name)|在当前数据中新增一个名为 name 的 **byte** 型变量|
|addVarDouble(name)|在当前数据中新增一个名为 name 的 **double** 型变量|
|addVarFloat(name)|在当前数据中新增一个名为 name 的**float** 型变量|
|addVarInt(name)|在当前数据中新增一个名为 name 的 **int** 变量|
|addVarLong(name)|在当前数据中新增一个名为 name 的 **long** 变量|
|addVarStr(name, length)|在当前数据中新增一个名为 name 的 **str** 变量|
|addVarStrL(name)|在当前数据中新增一个名为 name 的 **strL** 变量|
|allocateStrL(sc, size[, binary])|分配一个 strL ，以便可以使用 writeBytes() 存储缓冲区。 strL的内容将不会初始化。|
|dropVar(var)|删除当前数据中指定的变量|
|get([var, obs, selectvar, valuelabel, …])|从当前数据集中读取数据|
|getAsDict([var, obs, selectvar, valuelabel, …])|从当前数据集中读取数据并存为字典|
|getAt(var, obs)| 从当前数据集读取 1 个值                                      |
|getBestType(value)| 获取指定值的最佳数字数据类型                                 |
|getFormattedValue(var, obs, bValueLabel)|从当前数据集中读取1 个值，并沿用其显示格式 (format)|
|getMaxStrLength()|获取字符型变量的最大字符长度|
|getMaxVars()| 获取数值型变量的最大值                                       |
|getObsTotal()|获取当前数据观测值总个数|
|getStrVarWidth(var)|获取字符型变量的宽度|
|getVarCount()|获取当前数据集的变量个数|
|getVarFormat(var)| 获取指定变量的显示格式                                       |
|getVarIndex(name)|查找当前数据集中指定 name 的变量索引|
|getVarLabel(var)|获取数据变量标签|
|getVarName(index)|获取变量名|
|getVarType(var)|获取变量数据类型，如 byte, int, long, float, double, strL, str18 等|
|isVarTypeStr(var)| 测试变量是否是 **str** 型                                    |
|isVarTypeString(var)|测试变量是否是字符串类型|
|isVarTypeStrL(var)|测试变量是否是 **strL** 型|
|keepVar(var)|保留指定变量|
|list([var, obs])| 列出当前数据集中的值                                         |
|readBytes(sc, length)|从当前Stata数据集中的 **strL** 读取字节序列|
|renameVar(var, name)|变量重命名|
|setObsTotal(nobs)| 设置当前Stata数据集中的观测数量                              |
|setVarFormat(var, format)|设置 Stata 变量的显示格式|
|setVarLabel(var, label)|设置 Stata 变量的变量标签|
|store(var, obs, val[, selectvar])|将值存储在当前的Stata数据集中|
|storeAt(var, obs, val)| 将某个值储存在当前 Stata 数据集                              |
|storeBytes(sc, b, binary)|将字节缓冲区存储到当前 Stata 数据集中的 **strL** 中|
|writeBytes(sc, b[, off, length])| 从指定的字节缓冲区开始，从偏移量开始向当前 Stata 数据集中的 **strL** 写入长度字节；在调用此方法之前，必须使用 `allocateStrL()`分配 **strL** |

- 方法详述
- 示例
常规的使用方法：
```Python
from sfi import Data
stata: sysuse auto, clear
Data.getAt(0, 0)
Data.get(0, 0)
Data.get(var='price')
Data.get(obs=0)
Data.get([0,2,3], [0,2,4,6])
Data.get(var='foreign')
Data.get(var='foreign', valueslabel=True)

Data.getVarLabel(0)
Data.getVarLabel('price')
Data.setVarLabel(1, 'Retail Price')
Data.setVarLabel('mpg', 'Mileage per Gallon')
Data.renameVar(0, 'make2')
Data.renameVar("make2")
Data.dropVar("make2")
Data.dropVar("price2 mpg rep78")
Data.dropVar(0)
Data.dropVar([0,2,3])
```
```python
stata: sysuse auto, clear
Data.get(var='rep78')
Data.get(var='rep78', missingval=-100)
Data.get(var='rep78', missingval=None)

import numpy as np
Data.get(var='rep78', missingval = np.nan)
```
接下来，展示一些高级示例，以说明如何使用此类在 Stata 和 Python 之间进行通信。假设我们要使用 Python 计算当前数据集中指定变量的平均值，标准偏差，最小值和最大值，然后我们要根据结果，输出格式类似于 Stata 命令摘要产生的格式。

我们拥有包含各种汽车信息的数据，包括变量价格，汽车价格； mpg，里程等级； rep78 ，1978年的维修记录；headroom，以英寸为单位。
在 Stata 中获取变量的摘要统计信息，命令为：
```Stata
sysuse auto, clear
local varlist price mpg rep78 heandroom
summarize `varlist`
```
可以发现 rep78 只有 69 个观测值，因此缺失了一些观测值。要使用 Python 获得类似的输出，我们可以使用以下步骤处理每个变量：
- 确定变量是字符串还是数字变量。如果它是字符串变量，请跳过它。
- 对于变量的每次观察，确认是否缺失。如果缺失，请跳过它。
- 使用非缺失观测值计算汇总统计量。
考虑到上述几点，可以使用 Python 脚本中构造程序，例如dataex1.py ，如下所示：
```Python
# saved as dataex1.dta
from sfi import Data, Macro, Missing, SFIToolkit

#obtain list of the variables to summarize
varlist = Macro.getLocal("varlist")
vars = varlist.split(" ")
nobs = Data.getObsTotal()

#display the header
SFIToolkit.displayln("\n" +   "    " + "Variable {c |}        Obs        Mean    Std. Dev.       Min        Max")
SFIToolkit.displayln("{hline 13}{c +}{hline 57}")
for var in vars:
    sum = 0
    maxv = 0
    minv = Missing.getValue()
    avgv = 0
    stddev = 0
    count = 0

    #skip the variable if it is string
    if not Data.isVarTypeStr(var):

        #calculate mean, max, min
        for obs in range(nobs):
            #obtain the observation value
            value = Data.getAt(var, obs)

            #skip the missing observations
            if Missing.isMissing(value):
                continue

            if value > maxv:
                maxv = value
            if value < minv:
                minv = value

            sum += value
            count += 1

        avgv = sum / count

        #calculate std. dev.
        d2sum = 0
        for obs in range(nobs):
            value = Data.getAt(var, obs)
            if Missing.isMissing(value):
                continue

            d2sum += pow(value-avgv,2)

        stddev = pow(d2sum/(count-1), 0.5)

        #display the results
        out = "%12s {c |}%11s" % (var, SFIToolkit.formatValue(count, "%11.0gc"))
        if count>0:
            out += "   %9s" % (SFIToolkit.formatValue(avgv,  "%9.0g"))
            out += "   %9s" % (SFIToolkit.formatValue(stddev,"%9.0g"))
            out += "  %9s" % (SFIToolkit.formatValue(minv,   "%9.0g"))
            out += "  %9s" % (SFIToolkit.formatValue(maxv,   "%9.0g"))

            SFIToolkit.displayln(out)
```
再回到 Stata 中运行 Python 脚本：
```Stata
python script dataex1.py
```
上面的示例中，使用了 `getAt()` 方法遍历每个观察值，以获取每个变量的观察值，然后对这些值进行操作以计算汇总统计信息。我们还可以将每个变量的所有值存储在列表中，并对列表进行操作以计算这些统计信息。这也可以使用 `get()` 方法完成。我们在Python脚本文件 dataex2.py 中重建程序，如下所示：
```Python
# saved as dataex2.py
from sfi import Data, Macro, Missing, SFIToolkit
import numpy as np
import pandas as pd

#obtain list of the variables to summarize
varlist = Macro.getLocal("variable")
vars = vaerlist.split(" ")

# display the header
SFIToolkit.displayln("\n" +   "    " + "Variable {c |}        Obs        Mean    Std. Dev.       Min        Max")
SFIToolkit.displayln("{hline 13}{c +}{hline 57}")

for var in vars:

    #skip the variable if it is string
    if not Data.isVarTypeStr(var):

        #get the observation values in a list and construct a numpy array
        #using nonmissing observations
        vals = np.array(Data.get(var=var, selectvar=-1))

        #calculate summary statistics
        count = vals.size
        avgv = np.mean(vals)
        stddev = np.std(vals)*sqrt(count*1.0/(count-1))
        maxv = np.max(vals)
        minv = np.min(vals)

        #display the results
        out = "%12s {c |}%11s" % (var, SFIToolkit.formatValue(count, "%11.0gc"))
        if count>0:
            out += "   %9s" % (SFIToolkit.formatValue(avgv,  "%9.0g"))
            out += "   %9s" % (SFIToolkit.formatValue(stddev,"%9.0g"))
            out += "  %9s" % (SFIToolkit.formatValue(minv,   "%9.0g"))
            out += "  %9s" % (SFIToolkit.formatValue(maxv,   "%9.0g"))

            SFIToolkit.displayln(out) 
```
注意，当我们使用 `get()`将每个变量的观察值存储在列表中时，我们将 `selectvar`指定为 -1 。这导致遗漏缺少的值（如果有的话），以避免在进一步的计算中使用它们。否则，您需要自己将其从进一步的计算中删除。

之后，我们使用列表创建了一个 numpy 数组。然后，我们使用数组运算来计算摘要统计信息。运行上面的脚本文件将产生以下输出：
```Stata
python script dataex2.py
```
通常，可能需要根据某些条件来计算摘要统计信息，例如，里程额定值大于 25 mpg 的汽车的平均价格，或外国车的最小和最大里程数。
通常使用 Stata 命令的 if 和 in 选项，实现根据指定的标准获得计算结果，就像 summary 一样。也可以在 ado 文件 pysumm.ado 中编写命令 pysumm 实现，如下所示：
```Stata
program pysumm
    version 16
    syntax varlist [if] [in]

    //mark the observations for use
    marksample touse, novarlist

    //call the Python function for calculation
    python: pysummarize("`varlist'", "`touse'")
end

version 16
python:
from sfi import Data, SFIToolkit, Missing, Scalar
import numpy as np
from math import sqrt

def pysummarize(varlist, touse):
    vars = varlist.split(" ")

    #display the header
    SFIToolkit.display("\n" +   "    " + "Variable {c |}        Obs        Mean    Std. Dev.       Min        Max")
    SFIToolkit.display("{hline 13}{c +}{hline 57}")

    #clear the r() results
    SFIToolkit.rclear()

    for var in vars:

        #skip the variable if it is string
        if not Data.isVarTypeStr(var):

            #get the filtered observation values in a list and
            #construct a numpy array
            vals = np.array(Data.get(var=var, selectvar=touse))

            #skip missing observations
            vals = vals[vals < Missing.getValue()]

            #calculate summary statistics
            count = vals.size
            avgv = np.mean(vals)
            stddev = np.std(vals)*sqrt(count*1.0/(count-1))
            maxv = np.max(vals)
            minv = np.min(vals)

            #display the results
            out = "%12s {c |}%11s" % (var, SFIToolkit.formatValue(count, "%11.0gc"))
            if count>0:
                out += "   %9s" % (SFIToolkit.formatValue(avgv,  "%9.0g"))
                out += "   %9s" % (SFIToolkit.formatValue(stddev,"%9.0g"))
                out += "  %9s" % (SFIToolkit.formatValue(minv,   "%9.0g"))
                out += "  %9s" % (SFIToolkit.formatValue(maxv,   "%9.0g"))

                SFIToolkit.display(out)

                #store the mean of each variable in r()
                Scalar.setValue("r(mean_of_"+var+")", avgv)

end
```
上面的 ado 文件包含 ado 代码和 Python 代码。 ado 代码处理了所有解析和识别要使用的数据子样本的问题。Python 代码定义了一个函数 `pysummarize()` 来计算 summary statistic 。 ado 代码部分称为 Python 函数。
在ado代码中，我们使用marksample创建了一个 0/1 变量，该变量记录了将在后续代码中使用的观察值。默认情况下，如果 varlist 中的任何变量包含缺失值，或者相应的观察值不满足 if 和 in 限定符（如果已指定），则将使用变量设置为0。
在这个命令中，需要独立计算每个变量的 summary statistic ，因此我们不想跳过 varlist 中任何变量缺少值的观察。否则，如果变量列表中另一个变量的值缺失，则可以忽略一个变量的值无缺失的观测值。 novarlist 选项可以处理此问题。
到目前为止，使用变量仅将不满足 if 和 in 限定符的观察结果标记为0。

所有 Python 代码均在 `python:`和 `end` 块内定义。在这里，我们定义了一些导入语句和一个函数 `pysummarize()` 。Python 函数触发了 ado 代码来调用 Python 进行计算。作为 ado 代码和 Python 代码之间的连接，它接收了两个字符串作为参数：一个字符串包含要汇总的 Stata 数据集中的变量的名称，另一个字符串包含标识该变量的使用变量的名称。要使用的数据子样本。

在Python函数中，我们将满足条件的每个变量的观察值存储在列表中，并使用该列表构造一个 numpy 数组。我们跳过了数组中缺少的值。之后，我们计算了 summary statistic 并为每个变量显示了它们。另外，我们将每个变量的平均值存储在r类标量中。如果愿意，也可以将其他统计信息存储在Stata中。可以如下调用：
```Stata
pysumm `varlist`
return list

summarize `varlist` in 1/50 if mpg > 25
pysumm `varlist` in 1/50 if mog > 50
resturn list
```
##### 9.2.4.2.3 Frame
- 方法概览
|Method|Description|
|:---|:---|
|connect(name)|Connect to an existing frame in Stata and return a new Frame instance that can be used to access it.|
|create(name)|Create a new frame in Stata and return a new Frame instance that can be used to access it.|
|addObs(n[, nofill])|Add n observations to the frame.|
|addVarByte(name)|Add a variable of type byte to the frame.|
|addVarDouble(name)|Add a variable of type double to the frame.|
|addVarFloat(name)|Add a variable of type float to the frame.|
|addVarInt(name)|Add a variable of type int to the frame.|
|addVarLong(name)|Add a variable of type long to the frame.|
|addVarStr(name, length)|Add a variable of type str to the frame.|
|addVarStrL(name)|Add a variable of type strL to the frame.|
|allocateStrL(sc, size[, binary])|Allocate a strL so that a buffer can be stored using writeBytes(); the contents of the strL will not be initialized.|
|changeToCWF()|Set the Frame as the current working frame in Stata.|
|clone(newName)|Create a new Frame instance by cloning the current Frame and its contents.|
|drop()|Drop the frame in Stata.|
|dropVar(var)|Drop the specified variables from the frame.|
|get([var, obs, selectvar, valuelabel, …])|Read values from the frame.|
|getAsDict([var, obs, selectvar, valuelabel, …])|Read values from the frame and store them in a dictionary.|
|getAt(var, obs)|Read a value from the frame.|
|getFormattedValue(var, obs, bValueLabel)|Read a value from the frame, applying its display format.|
|getFrameAt(index)|Utility method for getting the name of a Stata frame at a given index.|
|getFrameCount()|Utility method for getting the number of frames in Stata.|
|getObsTotal()|Get the number of observations in the frame.|
|getStrVarWidth(var)|Get the width of the variable of type str.|
|getVarCount()|Get the number of variables in the frame.|
|getVarFormat(var)|Get the format for the variable in the frame.|
|getVarIndex(name)|Look up the variable index for the specified name in the frame.|
|getVarLabel(var)|Get the label for the Stata variable.|
|getVarName(index)|Get the name for the variable in the frame.|
|getVarType(var)|Get the storage type for the variable in the frame, such as byte, int, long, float, double, strL, str18, etc.|
|isVarTypeStr(var)|Test if a variable is of type str.|
|isVarTypeString(var)|Test if a variable is of type string.|
|isVarTypeStrL(var)|Test if a variable is of type strL.|
|keepVar(var)|Keep the specified variables in the frame.|
|list([var, obs])|List values from the frame.|
|readBytes(sc, length)|Read a sequence of bytes from a strL in the frame.|
|rename(newName)|Rename the frame in Stata.|
|renameVar(var, name)|Rename a variable.|
|setObsTotal(nobs)|Set the number of observations in the frame.|
|setVarFormat(var, format)|Set the format for a Stata variable.|
|setVarLabel(var, label)|Set the label for a Stata variable.|
|store(var, obs, val[, selectvar]) |Store values in the frame.|
|storeAt(var, obs, val)|Store a value in the frame.|
|storeBytes(sc, b, binary)|Store a byte buffer to a strL in the frame.|
|writeBytes(sc, b[, off, length])|Write length bytes from the specified byte buffer starting at offset off to a strL in the frame;the strL must be allocated using allocateStrL() before calling this method.|

- 方法详述
- 示例
```Stata
from sfi import Frame as fr
stata: sysuse auto, clear
d = fr.connect('default')
f = d.clone('myauto')
fr.getFrameCount()
fr.getFrameAt(0)
fr.getFrameAt(1)

f.get(0, 0)
f.getAt(0 ,0)
f.get(var = 'price')

f.get(obs=0)
f.get([0,2,3], [0,2,4,6])
f.getVarLabel(0)
f.getVarLabel('price')
f.setVarLabel(1, 'Retail Price')
f.setVarLabel('mpg', 'Mileage per Gallon')
f.renameVar(0, 'make2')
f.renameVar('price', 'price2')
f.dropVar('make2')
f.dropVar("price mpg rep78")
f.dropVar(0)
f.dropVar([0,2,3])
```
接下来，用一个进阶的示例说明如何使用此类在 Stata 和 Python 之间进行通信。假设我们在内存中有一个数据集，并且我们想在 Stata 中创建一个新框架，以从数据集中克隆变量和数据值。而不是使用上面的 `clone()` 方法。我们将使用此类中的各种功能从头开始创建框架。

首先，我们将包含各种汽车信息的数据加载到 Stata 中。
```Stata
webuse auto, clear
```
然后，我们编写 Python 脚本文件，例如 frameex.py ，它在 Stata 中创建一个名为 myauto 的新空框架，然后从内存中的当前数据集中克隆所有变量和数据值，并将其存储在该框架中。
```Python
# saved as frameex.py
import sys
from sfi import Data, Frame

#clone variables
def clone_var(f):
    nvar = Data.getVarCount() # Stata 数据变量个数
    
    for i in range(nvar):
        varname = Data.getVarName(i) # 获取变量名
        vattype = Data.getVarType(i) # 变量类型
        if vartype=="byte":
            f.addVarByte(varname)
        elif vartype=="double":
            f.addVarDouble(varname)
        elif vartype=="float":
            f.addVarFloat(varname)
        elif vartype=="int":
            f.addVarInt(varname)
        elif vartype=="long":
            f.addVarLong(varname)
        elif vartype=="strL":
            f.addVarStrL(varname)
        else:
            f.addVarStr(varname, 10) 
    
        f.setVarFormat(i, Data.getVarFormat(i)) # 显示格式
        f.setVarLabel(i, Data.getVarLabel(i)) # 变量标签

# clone data value
def clone_data(f):
    f.setObsTotal(Data.getObsTotal()) # 总观测值个数
    nvar = Data.getVarCount() # 变量个数

    for i in range(nvar):
        f.store(i, None, Data.get(var=i)) # 克隆数据

# create the new frame; the frame name is passed through the args() option of -python script-
newFrame = sys.argv[1]
fr = Frame.create(newFrame)

clone_var(fr)
clone_data(fr)
```
接下来，我们在 Stata 中运行此脚本文件，清除内存中的数据集，并将框架 myauto 作为当前工作数据集加载到 Stata 中。
```Stata
python script frameex.py, args('myauto')
clear
frames change myauto
describe
```
##### 9.2.4.2.4 Macro
- 方法概览
|Method|Description|
|:---|:---|
|getGlobal(name)|Get the contents of a global macro.|
|getLocal(name)|Get the contents of a local macro.|
|setGlobal(name, value[, vtype])|Set the value of a global macro.|
|setLocal(name, value)|Set the value of a local macro.|
- 方法详述
- 示例
```Python
from sfi import Macro as mco
stata: sysuse auto, clear
stata: regress mpg weight foreign
stata: ereturn list

mco.getGlobal('e(cmdline)')
mco.setGlobal('e(cmdline)', 'Cmd: regress mpg weight foreign')
mco.getGlobal('e(cmdline)')

mco.setLocal('lm', 'This is a local macro')
mco.getLocal('lm')
```
##### 9.2.4.2.5 Scalar
- 方法概览
|Method|Description|
|:---|:---|
|getString(name)|Get the contents of a Stata string scalar.|
|getValue(name)|Get the value of a Stata numeric scalar.|
|setString(name, value)|Set the contents of a Stata string scalar.|
|setValue(name, value[, vtype])|Set the value of a Stata numeric scalar.|
- 方法详述
- 示例
```Python
from sfi import Scalar as scl
stata: sysuse auto, clear
stata: regress mpg weight foreign
stata: ereturn list

slc.getValue('e(r2_a)')
slc.setValue('e(r2_a)', 0.3)
slc.getVlaue('e(r2_a)')
```
##### 9.2.4.2.6 SFIToolkit
>Set of core tools for interacting with Stata.

- 方法概览
|Method|Description|
|:---|:---|
|abbrev(s[, n])|Return s abbreviated to n display columns.|
|display(s[, asis])|Output a string to the Stata Results window.|
|displayln(s[, asis])|Output a string to the Stata Results window and automatically add a line terminator at the end.|
|eclear()|Clear Stata’s e() stored results.|
|error(rc)|Output the standard Stata error message associated with return code rc to the Stata Results window.|
|errprint(s[, asis])|Output a string to the Stata Results window as an error.|
|errprintDebug(s[, asis])|Output a string to the Stata Results window as an error if set debug on is enabled.|
|errprintln(s[, asis])|Output a string to the Stata Results window and automatically add a line terminator at the end.|
|errprintlnDebug(s[, asis])|Output a string to the Stata Results window as an error if set debug on is enabled, and automatically add a line terminator at the end.|
|exit([rc])|Terminate execution and set the overall return code to rc.|
|formatValue(value, format)|Format a value using a Stata format.|
|getCallerVersion()|Get the version number of the calling program.|
|getRealOfString(s)|Get the double representation of a string using Stata’s real() function.|
|getTempFile()|Get a valid Stata temporary filename.|
|getTempName()|Get a valid Stata temporary name.|
|getWorkingDir()|Get the current Stata working directory.|
|isFmt(fmt)|Test if a format is a valid Stata format.|
|isNumFmt(fmt)|Test if a format is a valid Stata numeric format.|
|isStrFmt(fmt)|Test if a format is a valid Stata string format.|
|isValidName(name)|Check if a string is a valid Stata name.|
|isValidVariableName(name)|Check if a string is a valid Stata variable name.|
|macroExpand(s)|Return s with any quoted or dollar sign–prefixed macros expanded.|
|makeVarName(s[, retainCase])|Attempt to form a valid variable name from a string.|
|pollnow()|Request that Stata poll its GUI immediately.|
|pollstd()|Request that Stata poll its GUI at the standard interval.|
|rclear()|Clear Stata’s r() stored results.|
|sclear()|Clear Stata’s s() stored results.|
|stata(s[, echo])|Execute a Stata command.|
|strToName(s[, prefix])|Convert a string to a Stata name.|

- 方法详述

##### 9.2.4.2.7 Preference
- 方法概览
|Method|Description|
|:---|:---|
|deleteSavedPref(section, key)|Delete a saved preference.|
|getSavedPref(section, key, defaultValue)|Get a saved preference.|
|setSavedPref(section, key, value)|Write a saved preference.|

- 方法详述
##### 9.2.4.2.8 ValueLabel
- 方法概览
|Method|Description|
|:---|:---|
|createLabel(name)|Create a new value-label name.|
|getLabel(name, value)|Get the label for a specified value-label value.|
|getLabels(name)|Get the labels for a specified value-label name.|
|getNames()|Get the names of all value labels in the current dataset.|
|getValueLabels(name)|Get the values and labels for a specified value-label name.|
|getValues(name)|Get the values associated with a single value-label name.|
|getVarValueLabel(var)|Get the value-label name associated with a variable.|
|removeLabel(name)|Remove a value-label name.|
|removeLabelValue(name, value)|Remove a value-label value.|
|removeVarValueLabel(var)|Remove a value-label name from a variable.|
|setLabelValue(name, value, label)|Set a value and label for a value-label name.|
|setVarValueLabel(var, labelName)|Set the value label for a variable.|
- 方法详述
- 示例
```Python
from sfi import ValueLabel
stata: sysuse auto, clear
ValueLabel.getNames()
ValueLabel.createLabel('repair')
ValueLabel.getName()
ValueLabel.setLabelValue('repair', 1, 'One')
ValueLabel.setLabelValue('repair', 2, 'Two')
ValueLabel.setLabelValue('repair', 3, 'Three')
ValueLabel.setLabelValue('repair', 4, 'Four')
ValueLabel.setLabelValue('repair', 5, 'Five')
ValueLabel.getValueLabels('repair')
ValueLabel.setVarValueLabel('rep78', 'repair')
ValueLabel.getVarValueLabel('rep78')
```
##### 9.2.4.2.9 StrLConnector
`sfi.strLConnector(argv*)` 很方便的链接 Stata 的 strL 数据类型，可以传入变量索引 `var` 和观测值索引 `obs` 两个参数。分别是：
$$
-nvar <= var < nvar
$$
和
$$
-nobs <= obs < nobs
$$
`nvar` 是 Stata 中指定的 frame 或者当前数据集中数据的变量个数，由 `getVarCount()` 方法返回。`nobs` , 是 Stata 中指定的 frame 或当前数据集中数据的观测值个数，由`getObsTotal()` 方法返回。

`var` 和 `obs` 可以是负值，并以 Python 索引的常用方式对其进行解释。**可以将 `var` 指定为变量名或索引。不过要注意，传递变量索引将更加有效，因为避免了在索引中查找指定的变量名。**

有两种方式创建 `strLConnectr` 实例：
- `StrLConnector(var, obs)`
- `StrLConnector(frame, var, obs)`
- 方法概览
|Method|Description|
|:---|:---|
|close()|Close the connection and release any resources.|
|getPosition()|Get the current access position.|
|getSize()|Get the total number of bytes available in the strL.|
|isBinary()|Determine if the attached strL has been marked as binary.|
|reset()|Reset the access position to its initial value.|
|setPosition(pos)|Set the access position.|

|Attribute|Description|
|:---|:---|
|obs|Return the observation number of the attached strL.|
|pos|Return the current position.|
|var|Return the variable index of the attached strL.|
- 方法详述
- 示例
```Stata
sysuse auto, clear
scatter mpg price
graph export sc1.png, replace
clear
```
```Python
# saved as strex1.py
from sfi import Data, StrLConnector, SFIToolkit
import sys
import os

#create a new dataset with one strL variable
#mystrl and one observation
Data.addVarStrL("mystrl")
Data.setObsTotal(1)

mpv = Data.getVarIndex("mystrl")
obs = 0

#create an instance of StrLConnector
sc = StrLConnector(mpv, obs)

filename = sys.argv[1]
flen = os.path.getsize(filename)

#allocate the strL variable
Data.allocateStrL(sc, flen, True)

#read the image file and store the contents
#in the strL variable
chunk_size = 2048
with open(filename, "rb") as fin:
    b = fin.read(chunk_size)
    while b:
        Data.writeBytes(sc, b)
        b = fin.read(chunk_size)

sc.close()
SFIToolkit.displayln(filename + " stored in dataset")
```
```Python
# saved as strex2.py
from sfi import Data, StrLConnector, SFIToolkit
import sys

filename = sys.argv[1]

#create an instance of StrLConnector
#to connect to the strL variable
var = Data.getVarIndex("mystrl")
obs = 0
sc = StrLConnector(var, obs)

#read the image file from the strL variable and
#store the contents in a new image file
chunk_size = 2048
with open(filename, "wb") as fout:
    b = Data.readBytes(sc, chunk_size)
    while b:
        fout.write(b)
        b = Data.readBytes(sc, chunk_size)

sc.close()
SFIToolkit.displayln(filename + " retrieved from dataset")
```
```Stata
python script strlex1.py, args(sc1.png)
*sc1.png stored in dataset
python script strlex2.py, args(sc2.png)
*sc2.png retrieved from dataset

checksum sc1.png
*Checksum for sc1.png = 1777154237, size = 37386
checksum sc2.png
*Checksum for sc2.png = 1777154237, size = 37386
```
##### 9.2.4.2.10 Platform
- 方法概览
|Method|Description|
|:---|:---|
|isLinux()|Determine if the platform is Linux.|
|isMac()|Determine if the platform is Mac OS.|
|isSolaris()|Determine if the platform is Solaris.|
|isUnix()|Determine if the platform is Unix or Linux.|
|isWindows([version])|Determine if the platform is Windows and the version number is **greater than or equal to** the version specified.|
- 示例
```Python
from sfi import Platform
Platform.isWindows() # True
Platform.isWindows(version=7) # True
Platform.isWindows(version=11) # False
```
#### 9.2.5 配置 Python
当前，Python 主要有 Python2 和 Python3 两个版本。Stata 支持 Python2.7 及以后的版本，第一次调用 Python 的时候，Stata 会自动搜索系统上通过官网、Anconda 或 Miniconda 安装的 Python 。安装包必须包含 Python 相应的动态链接库 (Installation must contain the conrresponding Python dynamically linked library) 。
以 Python3.6 为例，Windows  系统应该有 `python36.dll`；Linux 上应有 `libpython3.6.so` ；Mac 上应有 `libpython3.6.dylib` 。否则，Stata 将会搜素不到该版本。一旦 Stata 搜索到能搜到的最高版本，它会将信息储蓄以备后续使用。可以输入 `python query` 查询 Stata 会使用那些版本。
也可以输入 `python search` 来进行查询，Stata 会列印系统上所有可用的 Python 。在 Windows 上，Stata 会搜索 `python.exe`，在 Linux 和 Mac 上，会搜索` /usr/bin/python`,` /usr/bin/python3`, `/usr/local/bin/python`,`/usr/local/bin/python3`, `~/anaconda/bin/python` 或 ` ~/anaconda3/bin/pytnhon3`等。

如果想与默认版本所不同的 Pytnon ，可以输入 `python set exec` 进行更改。设置 Python 版本是可选的，设定之后重启 Python 才能生效。否者，会报错。不附加 `permanently` 选项设置只对当前环境有效，如果要永久设定，可在命令后添加 `permanently` 选项。

#### 9.2.6 包的存放路径
根据 Python 官方文档（参阅 [6.1.2](https://docs.python.org/3/tutorial/modules.html#the-module-search-path) 和 [6.1.3](https://docs.python.org/3/tutorial/modules.html#the-module-search-path) ），当导入 `spm` 模块时，首先会在内置模块中搜索是否有同名模块。如果没有发现，会搜索 `sys,path` 给定的路径列表中是否有名为 `spam.py` 的文件。在 Stata 中，Stata 的 `sysdir` (Stata's system directories) 和 `py/` 路径（除了 Stata 的路径），都会成为模块的默认搜索路径，例如，在 Windows 上，如下路径会被纳入搜索范围：
```
C:\Program Files\Stata16\
C:\Program Files\Stata16\ado\base\
C:\Program Files\Stata16\ado\base\py\
C:\Program Files\Stata16\ado\site\
C:\Program Files\Stata16\ado\site\py\
C:\ado\plus\
C:\ado\plus\py\
C:\ado\personal\
C:\ado\personal\py\
C:\ado\
C:\ado\py\
```
如果想要添加路径进以上列表，可以输入 `python set userpath` 一次性添加多个路径。比如：
```Stata
python set userpath "C:\mymodules1\" "C:\mymodules2" 
```
默认情况下，新增路径会在列表的最后，可以在上述命令添加 `prepend` 选项，会将新增路径挪到模块搜索路径列表的最开始。通过这种方式添加的路径在 Stata 整个运行期间都可以被检索到。这不同与在 `python script` 中通过 `userpath()` 指定路径，当脚本执行完毕后，路径就会从搜索列表中清除。

指定额外的模块搜索路径是可选项，一旦制定，必须重启 Python 之后 才会生效，否者会报错。不附加 `permanently` 选项设置只对当前环境有效，如果要永久设定，可在命令后添加 `permanently` 选项。

当调用 Python 第三方库时 (例如，`numpy`,`pandas`等) ，烧录线要确保所运行版本的 Python 中已经安装。否则，会报错 "the specified module is not found"。可以输入 `python which` 来检查当前 Python 中哪些包可用。

#### 9.2.7 错误状态码
在 Stata 中运行 Python 的代码遇见错误时，Stata 错误码中会包含 Python 的 stack trace，对应含义如下：

|Code|Meaning|
|:---|:---|
|7100 |error occurs when loading or freeing the Python dynamically linked library|
|7101 |attempt to set a different Python version or add additional module search paths after the Python environment is initialized|
|7102 |error occurs when executing Python in the interactive environment|
|7103| error occurs when running a Python script file or importing a Python module|

要在 Python 代码中创建自定义错误码，需要调用 `sfi` 模块中的 `SFIToolkit` 类 中的 `exit()` 函数。这终端运行 Python 代码解决错误条件 (condition) 或者例外 (exceptions) 时较为常用。可以参考下方的示例：
```Python
# saved as pyex4.py
from sfi import SFIToolkit
a = 3 
if a > 4:
    SFIToolkit.displayln("continue execution")
else:
    SFIToolkit.errprintln("assertion failed")
    SFIToolkit.exit(198)
# This line will not be executed due to assertion failure.
SFIToolkit.displayln("never reached")    
```
```Python
# saved as pyex5.py
from sfi import SFIToolkit
try:
    print(a)
except:
    SFIToolkit.errprintln("name is defined")
    SFIToolkit.exit(198)    
# This line will not be executed due to assertion failure.
SFIToolkit.displayln("never reached")  
```
上例中，`errprintln()` 用于将字符串作为错误提示输出在 Stata Result 窗口；`displayln()` 用于将字符串作为正常输出。他们都支持含 SMCL 标记的字符串。执行上面的代码。会显示：
```Stata
python script pyex4.py
*assertion failed
*r(198);

python script pyex5.py
*name a is not defined
*r(198)
```
#### 9.2.8 储存的返回值
`python query` 返回值储存在 `r()` 中：

- Scalar
`r(intialized)`, whether Python environment initialized (0 or 1).
- Macro
|Macro|Meaning|
|:---|:---|
|`r(execpath)` |Python executable path|
|`r(userpath)`| Python user path|
|`r(version)`|Python version|
|`r(arch)`| Python architecture (64-bit or 32-bit)|
|`r(libpath)`|Python shared library|



# 10. Mata 应用

# 11. Stata 与经典算法

## 11.1 二分法

# 12. 有趣的外部命令
## 12.1 -statapush- 
`statapush` 可以使用 Stata 发送邮件。在耗时比较长的程序运行时，通过 `statapush`让程序运行结束后，发送邮件提醒。

# 13.其他
## 13.1 Markdown 入门
## 13.1 Epidata 使用
## 13.2 Git 的使用
## 13.3 Github 和 码云 的使用
## 13.4 Hexo + GitHub Page 个人博客的搭建
## 13.5 公众号和博客推荐
## 13.6 效率工具
### 13.6.1 软件
|名称|用途|评价|
|:---|:---|:---|
|everything|文件搜索||
|Listary|文件搜索||
|Bandizip|压缩和解压文件||
|SublimeText|文本编辑器||
|f.lux|屏幕调色||
|snipaste |截图||
|Iobit Uninstaller|卸载软件||
|Seer|预览文件夹||
|PotPlayer|视频播放器||
|Q-Dir|文件夹可视化||
|Ditto|剪切板管理工具||
|Typora|markdown编辑器||
|GifCam / ScreenToGif|录屏||
|inpaint|去水印||
|幕布|思维导图工具||
|Renamer|批量重命名||
|FastStone Capture|截图||
|Cmder|Windows 命令行||
|adsafe|去除弹窗广告||
|Qtranslate|小巧的翻译工具||
### 13.6.2 Chrome 插件