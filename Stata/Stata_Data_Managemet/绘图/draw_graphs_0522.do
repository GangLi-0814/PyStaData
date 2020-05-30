
/*
需求一:
1.65岁以上 人口数量柱状图 以及它 占总人口比重 折线图这样的复合图
2.四项消费支出的对比图复合图，折线图或者条形图
*/

global path "C:\Users\mudaozi\Documents\WeChatPlatform\Stata_Data_Managemet\绘图"

import excel using "$path/data/bdata(1)(2)(1).xls", firstrow clear

* 图一
gen 比重 = 岁以上人口总数/总人口
tw bar 岁以上人口总数 时间 if 时间 >= 1990|| line 比重 时间 if 时间 >= 1990,yaxis(2) ///
scheme(qlean) ///
title("65岁以上人口总数特征") subtitle("（年份：1978年-2019年）") ///
xtitle("年份") ytitle("人口总数") ytitle("占总人口比重",axis(2)) ///
note("数据来源：国家统计局") ///
legend(label(2 "占总人口比重") pos(9) ring(0)) 
graph export "graph_01.png", replace

* 图二
line 居民人均医疗保健消费支出元 城镇居民人均医疗保健消费支出元 ///
农村居民人均医疗保健消费支出元 时间 if 时间 >= 2013 & 时间 <= 2018, ///
scheme(qlean)  /// 
title("居民人均医疗保健消费支出趋势图") subtitle("（时间：2013年-2018年）") ///
xtitle("年份") ytitle("支出金额（单位：元）") ///
legend(pos(4) order(2 1 3)) ///
note("数据来源：国家统计局")
graph export "graph_02.png", replace



/*
需求二：
1.按性别分的总人口数条形图，和男女比重折线的复合图。
2.按城镇分的总人口数条形图和比重折线图。
3.出生率，死亡率，自然增长率的折线图
*/

import excel using "$path/data/1.xls", clear

replace A = "年份" in 3
replace B = "年末总人口" in 3
replace C = "男性人口数" in 3
replace D = "男性人口比重" in  3
replace E = "女性人口数" in 3
replace F = "女性人口比重" in  3
replace G = "城镇人口数" in 3
replace H = "城镇人口比重" in  3
replace I = "乡村人口数" in 3
replace J = "乡村人口比重" in  3
replace K = "出生率" in  3
replace L = "死亡率" in  3
replace M = "自然增长率" in  3

drop in 1/2
ssc install nrow, replace
nrow
destring _all, replace

* 图一
line 男性人口数 女性人口数 年份 ||  ///
line 男性人口比重 女性人口比重 年份, yaxis(2)  ///
title("不同性别人口总数与比重") ///
subtitle("（时间：1990年-2018年）") ///
ytitle("人口数（单位：万）") ytitle("占总人口比重（单位：%）",axis(2))  ///
note("数据来源：国家统计局") 
graph export "graph_03.png", replace



* 图二
line 城镇人口数 乡村人口数 年份 ||  ///
line 城镇人口比重 乡村人口比重 年份, yaxis(2)  ///
title("城乡人口总数与比重") ///
subtitle("（时间：1990年-2018年）") ///
ytitle("人口数（单位：万）") ytitle("占总人口比重（单位：%）",axis(2))  ///
note("数据来源：国家统计局") 
graph export "graph_04.png", replace


* 图三
line 出生率 死亡率 自然增长率 年份, ///
ytitle("（单位：‰）")
graph export "graph_05.png", replace

