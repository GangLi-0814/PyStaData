

help added_text_options

* 1978-2006各项支农费用支出
import excel using "1978-2006各项支农费用支出.xlsx", firstrow clear

twoway line 支援农村生产及事业费支出占比 基本建设支出占比 科技三项费用占比 其他费用占比 年份, scheme(plotplain) ///
title("各项财政支农费用占支农总支出的比重") ///
subtitle("（1978-2006年）") ///
xtitle("") ///
xlabel(1978(4)2006) ///
ytitle("比重(%)") ///
legend(off) ///
text(75 1982 "支援农村生产及事业费用") ///
text(38 1980 "基本建设费用")  ///
text(12 1980 "其他费用") ///
text(5 1980 "科技三项费用") ///
note("数据来源：中国农村统计年鉴") 

graph export "${result}/fig3_1978-2006各项支农费用支出.png", replace




use http://www.stata-press.com/data/r13/uslifeexp, clear

twoway line le year || fpfit le year, ///
ytitle("Life Expectancy, years") ///
xlabel(1900 1918 1940(20)2000) ///
title("Life Expectancy at Birth") ///
subtitle("U.S., 1900-1999") ///
note("Source: National Vital Statistics Report, Vol. 50 No. 6") ///
legend(off) ///
text( 48.5 1923 ///
"The 1918 Influenza Pandemic was the worst epidemic" ///
"known in the U.S." ///
"More citizens died than in all combat deaths of the" ///
"20th century." ///
, place(se) box just(left) margin(l+4 t+1 b+1) width(85) )