
cd "C:\Users\mudaozi\Documents\WeChatPlatform\Python_Data_Visualization\政府工作报告\result"

************************
* 调用Python 处理数据
************************
**********************************Python****************************************
* 读取PDF
python:
import textract
import re
import jieba
import pandas as pd

# 提取 PDF 文本
pdf = textract.process("../data/2020政府工作报告.pdf", 'utf-8')
text = pdf.decode()

# 分词、去除停用词
ls = jieba.lcut(text)
stopwords = [line.strip() for line in open(
    '../requirement/user_dict.txt', 'r', encoding='utf-8').readlines()]
words = [word for word in ls
         if len(word) > 1
         and word not in stopwords
         and not re.match('^[a-z|A-Z|0-9|.]*$', word)]

# 词频统计
counts = {}
for word in words:
    if len(word) == 1:
        continue
    else:
        counts[word] = counts.get(word, 0) + 1
items = list(counts.items())
items.sort(key=lambda x: x[1], reverse=True)

# 导出词频结果
df = pd.DataFrame(items, columns=['关键词', '频次'])
df.to_csv("../result/01_词频统计结果.csv", index=None, encoding='utf_8_sig')
end
**********************************END*******************************************


*****************
* 可视化
*****************

* 前二十关键词柱状图

import delimited using "01_词频统计结果.csv",  clear encoding("utf8")
gsort -频次
gen n = _n
graph hbar 频次 in 1/20, over(关键词,sort(n)) ///
scheme(s2mono) ///
blabel(bar, position(outside) size(vsmall)) ///
title("2020年政府工作报告二十大关键词") ///
ytitle("频次") ///
ylabel(0(10)70) ///
note("数据来源：2020年政府工作报告")


* 调用 Python 的 Pyecharts库绘制词云图

**********************************Python****************************************
python:
from sfi import Data
from pyecharts import options as opts
from pyecharts.charts import Page, WordCloud
from pyecharts.globals import SymbolType

keywords = Data.get(var='关键词')
coounts = Data.get(var='频次')
items = list(zip(keywords, counts)) 

def wordcloud_diamond() -> WordCloud:
    words = items 
    c = (
        WordCloud()
        .add("", words, word_size_range=[20, 100], shape=SymbolType.DIAMOND)
        .set_global_opts(title_opts=opts.TitleOpts(title="政府工作报告词云图"))
    )
    return c

wordcloud_diamond().render('../result/03_2020年政府工作报告词云图.html')
end
**********************************END*******************************************


shellout "../result/03_2020年政府工作报告词云图.html"
