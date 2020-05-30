cd "C:\Users\mudaozi\Documents\WeChatPlatform\Stata_Data_Managemet\自动生成中南财大2019拟录取硕士研究生分析报告"

************************
* 下载并转换为 Excel
************************
**********************************Python****************************
python:
import requests
import pdfplumber
from openpyxl import Workbook

# 下载 PDF 文件
pdf_2019q4 = 'http://yzb.zuel.edu.cn/_upload/article/files/70/72/9a65178a4aacb5ae64daa5950b83/cf27a493-b596-4059-9c7c-ba76ba73237f.pdf'
r = requests.get(pdf_2019q4, stream=True)
with open("2019年硕士研究生拟录取名单公示.pdf", "wb") as pdf:
    for content in r:
            pdf.write(content)

# 提取并写入 Excel
wb = Workbook()
ws = wb.active
with pdfplumber.open("2019年硕士研究生拟录取名单公示.pdf") as pdf:
    for page in pdf.pages:
        for table in page.extract_tables():
            for row in table:
                ws.append(row)
wb.save("./data/2019年硕士研究生拟录取名单公示.xlsx")
end
***************************************************************************

***********************
* 爬取并整理学院代码
***********************
copy "http://www.zuel.edu.cn/schools/" "./data/schools.txt", replace
infix strL v 1-200000 using "./data/schools.txt",clear
keep if index(v,"学院")
gen 学院 = ustrregexs(2) if ustrregexm(v,`"<option value="(.*?)" >(.*?)</option>"')
keep 学院
drop if 学院 == "" 
drop if _n >= 15 & _n != 16 & _n != 17
gen 学院代码 = 100 + _n
tostring 学院代码, replace
replace 学院 = "法律硕士教育中心" if 学院 == "继续教育学院"
replace 学院代码 = "117" if 学院代码 == "116"
save "./data/学院代码.dta", replace

*****************
* 二、数据分析
*****************

* 数据清理
**************
import excel using "./data/2019年硕士研究生拟录取名单公示.xlsx",firstrow clear

*数据清理

* 异常值
destring 政治-总成绩, replace
misstable summarize _all // 3条异常
replace 专项计划 = "少数民族高层次骨干人才计划" if 专项计划 == "少数民族高层次骨"
replace 拟录取专业 = "金融统计、保险精算与风险管理" if 拟录取专业 == "金融统计、保险精算与风险"
drop if 考生编号 == ""

* 去除换行符
replace 拟录取专业 = usubinstr(拟录取专业," ","",.)
replace 拟录取专业 = ustrregexrf(拟录取专业,"\n","")

* 匹配学院代码
merge m:1 学院代码 using "./data/学院代码.dta", nogen
order 学院* 拟录取专业
compress
save "./data/2019拟录取_不含推免_清理后.dta", replace

* 总体分析
use "./data/2019拟录取_不含推免_清理后.dta", clear

/* 创建文档 */
capture putdocx clear
putdocx begin

/* 标题  */
putdocx paragraph, style(Title) halign(center)
putdocx text ("中南财经政法大学2019拟录取硕士研究生分析报告"), ///
    font("宋体",16,black) bold linebreak

// /* 署名和日期 */
// putdocx paragraph, halign(center) style(Subtitle)
// putdocx text ("PyStaData"), linebreak
// putdocx text ("2020 年 5 月2 日"), bold ///
// 	font("华文楷体", 12, black) linebreak

putdocx paragraph, style(Title)
putdocx text ("一、前言"), ///
    font("黑体",14,black)

/* 文本块 */
putdocx textblock begin
        本报告使用的数据来自中南财经政法大学研究生招生网公布的《2019年硕士研究生拟录取名单公示》。本文处理流程大致为：首先使用Stata16调用Python完成PDF下载和转化，随后去官网爬取和匹配学院代码、清理异常值等整理工作，
最后对拟录取人数的学院、专业和录取类型进行了简单的分析。要说明的是，研招网公布的这份名单不包括推免生，所以本报告分析对象主要是统考生，另外，本分析旨在学习Stata数据整理和文档自动化，为解决需要提供重复性报告的工作提供一种思路。
如果分析过程中的数据与实际情况存在差别，请以官网为准。
putdocx textblock end

putdocx paragraph, style(Title)
putdocx text ("二、总体分析"), ///
    font("黑体",14,black)

**********************************
des,s
local N = r(N)
count if 学习方式 == "全日制"
local allday = r(N)

count if 备注 == "调剂"
local change = r(N)

count if 拟录取类别 == "定向"
local fixed = r(N)
************************************

putdocx textblock begin
        据网站公布的名单，2019年拟录取的硕士研究生（不含推免）共 <<dd_docx_display:`N'>> 名。其中，有 <<dd_docx_display:`change'>> 名是调剂而来。在学习方式方面，全日制 <<dd_docx_display:`allday'>> 名，非全日制为 <<dd_docx_display:`N'-`allday'>> 名。在拟录取类别
方面，非定向为 <<dd_docx_display:`fixed'>> 名，定向为 <<dd_docx_display:`N'-`fixed'>> 名。
putdocx textblock end

putdocx paragraph
putdocx text ("拟录取人数在各学院的分布大致如下：")
tbl2putdocx 学院

putdocx paragraph
putdocx text ("各专业拟录取人数如下：")
tbl2putdocx 拟录取专业

putdocx save "./result/中南财经政法大学2019硕士拟录取研究生分析报告.docx", replace



**************
*考生编号
***************
/*考生编号
报考单位的代码+报考年份+学院的代码+报名的次序
105209666619432
10520 中南财经政法大学
9   "2019"
6666 研究生院代码
03770 报名次序

10520 9 6666 19432

*/

gen 院校 = usubstr(考生编号,1,5)
gen 报考年份 = usubstr(考生编号,6,1)
gen 未知 = usubstr(考生编号,7,4)   //研究生院代号?
sort 考生编号
gen 报名次序 = usubstr(考生编号,11,.)  //仅适用于财大


count if 备注 == "调剂" /* 74 obs */
count if 院校 != "10520" /* 58 obs */
count if 院校 != "10520" & 备注 == "" /* 0 obs */
edit if 院校 != "10520"
count if 报考年份 != "9" /* 0 obs */


keep if 院校 == "10520" //非调剂,报名为财大
keep 院校 报考年份 未知 报名次序  /* 2426 */
destring 报名次序,replace

gen 报名次序区间 = cond(报名次序 <= 2500, 1, cond(报名次序 <= 5000, 2, ///
cond(报名次序 <= 7500, 3, cond(报名次序 <= 10000, 4, cond(报名次序 <= 12500, 5, ///
cond(报名次序 <=15000, 6, cond(报名次序 <= 17500, 7, cond(报名次序 <= 20000, 8, ///
cond(报名次序 <= 22500, 9, 10))))))))) if 报名次序 < .

 
label def 区间 1 "(0, 2500]" 2 "(2500, 5000]" 3 "(5000, 7500]" 4 "(7500, 10000]" ///
5 "(10000, 12500]" 6 "(12500, 15000]" 7 "(15000, 17500]" 8 "(17500, 20000]"  ///
9 "(20000, 22500]" 10 "(22500, 25000]"

label val 报名次序区间 区间

histogram 报名次序区间,discrete freq addlabels ylabel(,grid) ///
xlabel(1/10,valuelabel angle(45) gmin) ytitle("人数") scheme(qlean) ///
note("数据来源：整理自中南财经政法大学研招网公示数据")
graph export "./result/非推免非调剂报名拟录取学生的报名次序.png",replace


************************************
cd "C:\Users\mudaozi\Desktop\财大2019研究生录取"
import excel using "2019年硕士研究生拟录取名单公示（不含推免）.xlsx",firstrow clear
des,s /* 2484 obs */

format 考生编号 %16.0f
*gen id = string(考生编号,"%16.0f")
tostring 考生编号,replace format(%16.0f) force
gen 院校 = substr(考生编号,1,5)
*keep if 院校 != "10520" /* 58 obs */
merge m:m 院校 using "2019年全国普通高校_学校标识码.dta"
drop if _merge != 3
drop _merge 
logout, word save("调剂生来源与拟录取专业") replace: tab 学校名称 拟录取专业 if 备注 == "调剂"

