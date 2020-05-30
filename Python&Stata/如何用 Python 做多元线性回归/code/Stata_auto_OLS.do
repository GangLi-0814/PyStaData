cd ..\data
use auto,clear

global x "weight length mpg"

* 数据概览
describe

* 描述性统计
summarize price $x

* 相关系数
pwcorr price $x

* 绘制散点图
tw (scatter price weight)(lfit price weight)

* 回归
regress price $x