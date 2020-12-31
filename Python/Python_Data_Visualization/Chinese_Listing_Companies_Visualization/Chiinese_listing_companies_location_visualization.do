

***************
* 数据下载
***************
python:
import requests
import pdfplumber
from openpyxl import Workbook

# 下载 PDF 文件
pdf_2019q4 = 'http://www.csrc.gov.cn/pub/newsite/scb/ssgshyfljg/202001/W020200110325952653089.pdf'
r = requests.get(pdf_2019q4, stream=True)
with open("CSRC_201914.pdf", "wb") as pdf:
    for content in r:
            pdf.write(content)

# 提取并写入Excel
wb = Workbook()
ws = wb.active
with pdfplumber.open("CSRC_201914.pdf") as pdf:
    for page in pdf.pages:
        for table in page.extract_tables():
            for row in table:
                ws.append(row)
wb.save("CSRC_201914.xlsx")
end


*************
* 数据整理
*************

* ssc install nrow, replace
* ssc install carryforward, replace

import excel using "CSRC_2019q4.xlsx", clear
duplicates drop
nrow
carryforward _all,replace
gen 行业门类与大类 = ustrregexs(0) + 行业大类代码 if ustrregexm(门类名称及代码,"[A-Z]") == 1
rename (上市公司代码 上市公司简称 行业门类与大类 门类名称及代码) (Stkcd Stknme  Nnindcd Nnindnme)
drop 行业大类代码 行业大类名称
lab var Stkcd "上市公司代码"
lab var Stknme "上市公司简称"
lab var Nnindcd "行业代码"
lab var Nnindnme "行业名称"
save "CSRC_201914_ok.dta", replace

import excel using "IPO_Cobasic.xlsx", firstrow clear
duplicates drop Stkcd, force 
lab var Listdt "上市时间"
lab var Estbdt "成立时间"
lab var Regadd "注册地址"
save "IPO_Cobasic.dta", replace

use "CSRC_201914_ok.dta", clear
merge 1:1 Stkcd using "IPO_Cobasic.dta", keep(3) nogen

* 识别农产品加工企业
gen Agri_m = 0
forvalues i = 13/23{
	replace Agri_m = 1 if regexm(Nnindcd, "C`i'") == 1  // 根据国家统计局：C13-C23；C29
}
replace Agri_m = 1 if regexm(Nnindcd, "C29") == 1
lab var Agri_m "农产品加工企业"
tab Agri_m
save "CSRC_2019q4_ok.dta", replace



python:
import pandas as pd
import cpca
import china_region
from chinese_province_city_area_mapper import drawers


df = pd.read_excel("CSRC_2019q4.xlsx")
df.head()

# cpca.transform(df.adress)

location = df['Regadd']
loca = location.to_list()
df = cpca.transform(loca)
drawers.draw_locations(df, "df.html")
end














