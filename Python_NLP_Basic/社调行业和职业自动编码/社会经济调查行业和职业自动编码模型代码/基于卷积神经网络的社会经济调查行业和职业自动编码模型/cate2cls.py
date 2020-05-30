# coding=utf-8

import numpy as np
import pandas as pd
from collections import Counter



filename = r'data/classes.xls'  # 行业职业类别文件


# 读取行业类别
df = pd.DataFrame(pd.read_excel(filename,sheet_name=u'行业',encoding='utf_8_sig'))

# 先过滤掉中文字段的回车
tem1 = df[u'text'].str.replace("\n","")
df[u'text'] = tem1
tem2 = df[u'helptext'].str.replace("\n","")
df[u'helptext'] = tem2

# 读取编码的高位和中位
col1 = df['first'].values
col2 = df['second'].values
col1 = np.append(col1,0)
col2 = np.append(col2,0)
col1 = np.append(col1,99)
col2 = np.append(col2,99)

# 形成高位,中位与其对应的类别号
counter1 = Counter(col1)
count_pairs1 = counter1.most_common()
high_encode = []

for key,value in count_pairs1:
    high_encode.append(key)
high_encode_out = sorted(high_encode)
high_catenum = range(0,len(high_encode_out))

counter2 = Counter(col2)
count_pairs2 = counter2.most_common()
mid_encode = []

for key,value in count_pairs2:
    mid_encode.append(key)
mid_encode_out = sorted(mid_encode)
mid_catenum = range(0,len(mid_encode_out))

#将映射存储到文件中
highdata = pd.DataFrame(data=None,columns=['high_encode_out','high_catenum'])
highdata['high_encode_out'] = high_encode_out
highdata['high_catenum'] = high_catenum
highdata.to_csv('data/mapping/ind_highmap.txt',index=False,sep='\t',encoding="utf_8_sig",header=0)

middata = pd.DataFrame(data=None,columns=['mid_encode_out','mid_catenum'])
middata['mid_encode_out'] = mid_encode_out
middata['mid_catenum'] = mid_catenum
middata.to_csv('data/mapping/ind_midmap.txt',index=False,sep='\t',encoding="utf_8_sig",header=0)


# 读取职业类别
df1 = pd.DataFrame(pd.read_excel(filename,sheet_name=u'职业',encoding='utf_8_sig'))

# 先过滤掉中文字段的回车
tem3 = df1[u'text'].str.replace("\n","")
df[u'text'] = tem3
tem4 = df1[u'helptext'].str.replace("\n","")
df[u'helptext'] = tem4

# 读取编码的高位和中位
col3 = df1['first'].values
col4 = df1['second'].values
col5 = df1['third'].values
col3 = np.append(col3,0)
col4 = np.append(col4,0)
col5 = np.append(col5,0)
col3 = np.append(col3,99)
col4 = np.append(col4,99)
col5 = np.append(col5,99)

# 形成高位,中位,低位与其对应的类别号
counter3 = Counter(col3)
count_pairs3 = counter3.most_common()
high_encode1 = []

for key,value in count_pairs3:
    high_encode1.append(key)
high_encode_out1 = sorted(high_encode1)
high_catenum1 = range(0,len(high_encode_out1))


counter4 = Counter(col4)
count_pairs4 = counter4.most_common()
mid_encode1 = []

for key,value in count_pairs4:
    mid_encode1.append(key)
mid_encode_out1 = sorted(mid_encode1)
mid_catenum1 = range(0,len(mid_encode_out1))

counter5 = Counter(col5)
count_pairs5 = counter5.most_common()
low_encode1 = []

for key,value in count_pairs5:
    low_encode1.append(key)
low_encode_out1 = sorted(low_encode1)
low_catenum1 = range(0,len(low_encode_out1))

# 将映射存储到文件中
highdata1 = pd.DataFrame(data=None,columns=['high_encode_out','high_catenum'])
highdata1['high_encode_out'] = high_encode_out1
highdata1['high_catenum'] = high_catenum1
highdata1.to_csv('data/mapping/occ_highmap.txt',index=False,sep='\t',encoding="utf_8_sig",header=0)

middata1 = pd.DataFrame(data=None,columns=['mid_encode_out','mid_catenum'])
middata1['mid_encode_out'] = mid_encode_out1
middata1['mid_catenum'] = mid_catenum1
middata1.to_csv('data/mapping/occ_midmap.txt',index=False,sep='\t',encoding="utf_8_sig",header=0)

lowdata1 = pd.DataFrame(data=None,columns=['low_encode_out','low_catenum'])
lowdata1['low_encode_out'] = low_encode_out1
lowdata1['low_catenum'] = low_catenum1
lowdata1.to_csv('data/mapping/occ_lowmap.txt',index=False,sep='\t',encoding="utf_8_sig",header=0)
