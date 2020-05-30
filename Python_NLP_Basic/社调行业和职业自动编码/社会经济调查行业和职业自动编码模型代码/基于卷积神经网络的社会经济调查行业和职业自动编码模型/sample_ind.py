# coding=utf-8

import numpy as np
import pandas as pd
from data.helper import getlistnum



# 原数据和增加的样本路径
filename1 = u'data/ind/ind_raw.txt'
filename2 = u'data/ind/ind_da.txt'
filename3 = u'data/ind/ind_da0.txt'

# 设定每个样本最少需要的个数和最多需要的个数
min_num = 500
max_num = 1000



# 读取原数据和增加的样本
datafiles = [filename1,filename2,filename3]
df = pd.DataFrame(data=None,columns=['1','2'])
for datafile in datafiles:
    tem = pd.DataFrame(pd.read_table(datafile,sep='\t',encoding='utf_8_sig',names=['1','2']))
    df=df.append(tem)



# 对编码列(标签列)的所有元素作个数统计,并按元组(编码,个数)排序
col_count = getlistnum(df['1'])
col_count1 = sorted(col_count.items(), key=lambda d:d[1])



# 上采样,进行复制
print("UpSampling......")
encodelists = []
answerlists = []

for i in col_count1:
    count_num = 0
    encodelist = []
    answerlist = []
    tem = df.loc[df['1'] == i[0]]['2'].values
    if i[1]>min_num:
        continue
    for r in tem:
        answerlist.append(r)
        encodelist.append(i[0])
    ans_len = len(encodelist)
    count_num = count_num+ans_len
    a_l = []
    e_l = []
    while True:
        if count_num+ans_len < min_num:
            a_l += answerlist
            e_l += encodelist
            count_num = count_num+ans_len
        else:
            a_l += answerlist[:min_num-count_num]
            e_l += encodelist[:min_num-count_num]
            break
    encodelists += e_l
    answerlists += a_l

newdata = pd.DataFrame(data=None,columns=['1','2'])
newdata['1'] = encodelists
newdata['2'] = answerlists
df=df.append(newdata)



# 下采样,进行随即抽样
print("DownSampled......")
newdata1 = pd.DataFrame(data=None,columns=['1','2'])
df1 = df.copy()
count = 0
for i in col_count1:
    if i[1]>max_num:
        count = count+1
        tem = df.loc[df['1'] == i[0]]
        tem = tem.sample(frac = 1)
        tem1 = tem.iloc[:max_num]

        newdata1 = newdata1.append(tem1)
        df1 = df1[~df1['1'].isin([i[0]])]
   
df1 = df1.append(newdata1)
df1 = df1.sample(frac = 1)



# 将数据集划分为训练集,验证集和测试集
row = df1.shape[0]
df1.iloc[:int(row*0.85)].to_csv('data/ind/ind_train.txt',mode='ab+',index=False,sep='\t',encoding="utf_8_sig",header=0)
df1.iloc[int(row*0.85):int(row*0.9)].to_csv('data/ind/ind_val.txt',mode='ab+',index=False,sep='\t',encoding="utf_8_sig",header=0)
df1.iloc[int(row*0.9):].to_csv('data/ind/ind_test.txt',mode='ab+',index=False,sep='\t',encoding="utf_8_sig",header=0)
