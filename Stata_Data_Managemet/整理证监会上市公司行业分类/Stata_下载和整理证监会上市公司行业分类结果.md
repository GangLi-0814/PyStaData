# 问题的提出

证监会网站会公布每季度[上市公司最新行业分类结果](http://www.csrc.gov.cn/pub/newsite/scb/ssgshyfljg/)，但提供的是 PDF 版本，难以直接用作数据匹配。刚正好需要这份数据，所以用 Stata 来下载、转换和整理数据。

# 思路分析
1. 使用 Stata16 调用 Python 完成文件的下载、PDF 转换成 Excel 文件。
2. 使用 Stata 进行数据整理，涉及观测值去重、填充和利用正则表达式生成新变量等内容。

# 实现过程

## 调用 Python 下载和提取文件
```Stata
python:
import requests
import pdfplumber
from openpyxl import Workbook

# 下载 PDF 文件
pdf_2019q4 = 'http://www.csrc.gov.cn/pub/newsite/scb/ssgshyfljg/202001/W020200110325952653089.pdf'
r = requests.get(pdf_2019q4, stream=True)
with open("证监会2019年4季度上市公司行业分类结果.pdf", "wb") as pdf:
    for content in r:
            pdf.write(content)

# 提取并写入Excel
wb = Workbook()
ws = wb.active
with pdfplumber.open("证监会2019年4季度上市公司行业分类结果.pdf") as pdf:
    for page in pdf.pages:
        for table in page.extract_tables():
            for row in table:
                ws.append(row)
wb.save("证监会2019年4季度上市公司行业分类结果.xlsx")
end
```

## 整理数据
```Stata
import excel using "证监会2019年4季度上市公司行业分类结果.xlsx", clear
duplicates drop

* ssc install nrow, replace
* ssc install carryforward, replace
nrow
carryforward _all,replace
gen 行业门类与大类 = ustrregexs(0) + 行业大类代码 if ustrregexm(门类名称及代码,"[A-Z]") == 1
save "201914上市公司行业分类.dta", replace
```
# 最终结果
![](/img/result.png)