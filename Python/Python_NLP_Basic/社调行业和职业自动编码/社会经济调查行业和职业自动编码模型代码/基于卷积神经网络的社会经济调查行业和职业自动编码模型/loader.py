#coding=utf-8
import numpy as np
import pandas as pd
import sys 
from data.helper import multi_sub, is_chinese, is_digit, is_letter, getlistnum, cut_by_seqlength



# 数据集(假设每一个file里都有编码和辅助题)
filename1 = r'data/dataset1.xlsx'
filename2 = r'data/dataset2.xlsx'



# 读入数据集
datafiles = [filename1,filename2]
df = pd.DataFrame(data=None,columns=[u'受访者编号',u'题型',u'题目',u'访员实地填写的答案',u'类别',u'编码结果'])

for datafile in datafiles:
    tem = pd.DataFrame(pd.read_excel(datafile,encoding='utf_8_sig'))
    df=df.append(tem)

# 过滤答案列的换行符,避免转换列值的时候出现多行.同时过滤隐含信息"XX"
df[u'编码结果']=df[u'编码结果'].astype(int)
tem = df[u'访员实地填写的答案'].str.replace("\n","")
df[u'访员实地填写的答案']=tem
tem1 = df[u'访员实地填写的答案'].str.replace("XX","")
df[u'访员实地填写的答案']=tem1


# 过滤答案列的非中文,数字,英文字母
dfvalue = df[u'访员实地填写的答案'].values
result_new = []
b = []
for r0 in range(0,dfvalue.shape[0]):
    temx = unicode(dfvalue[r0])
    
    for r1 in range(0,len(temx)):
        if is_chinese(temx[r1]) == False and is_digit(temx[r1]) == False and is_letter(temx[r1]) == False:
            b.append(r1)

    if b:
        temx = multi_sub(temx,b,u'')
        b = []
    result_new.append(temx)

df[u'访员实地填写的答案'] = result_new


# 将数据集分为编码和辅助题
dfencode = df.loc[df[u'题型'] == u'编码']
dfhelp = df.loc[df[u'题型'] == u'辅助题']


# 将编码题划分为行业和职业
dfind = dfencode.loc[dfencode[u'类别'] == u'行业']
dfocc = dfencode.loc[dfencode[u'类别'] == u'职业']


'''
处理编码
'''

# 截取编码结果和答案两列,作为输出
dfind_result = dfind[[u'编码结果',u'访员实地填写的答案']]
dfocc_result = dfocc[[u'编码结果',u'访员实地填写的答案']]

print ("saving ind_raw data...")
dfind_result.to_csv('data/ind/ind_raw.txt',mode='ab+',index=False,sep='\t',encoding="utf_8_sig",header=0)

print ("saving occ_raw data...")
dfocc_result.to_csv('data/occ/occ_raw.txt',mode='ab+',index=False,sep='\t',encoding="utf_8_sig",header=0)


'''
处理辅助题
'''


# 搜索同一个受访者是否有行业或职业编码题,如果有,将行业或职业编码和该答案插入行业或职业df_result后
print ("saving ind_help data...")
newdata=pd.DataFrame(data=None,columns=[u'受访者编号',u'题型',u'题目',u'访员实地填写的答案',u'类别',u'编码结果'])
newdata[u'编码结果'] = newdata[u'编码结果'].astype(int)
for r1 in range(0,len(dfhelp)):
   t1 = dfind.loc[dfind[u'受访者编号'] == dfhelp.iloc[r1][u'受访者编号']]
   if t1.empty == False:
       tmp = pd.DataFrame([dfhelp.iloc[r1]])
       tmp.iloc[0,5] = t1.iloc[0][u'编码结果']
       frame = [newdata,tmp]
       newdata = pd.concat(frame)

newdata1 = newdata.iloc[:,[5,3]]
newdata1.to_csv('data/ind/ind_raw.txt',mode='ab+',index=False,sep='\t',encoding="utf_8_sig",header=0)

print ("saving occ_help data...")
newdatas=pd.DataFrame(data=None,columns=[u'受访者编号',u'题型',u'题目',u'访员实地填写的答案',u'类别',u'编码结果'])
newdatas[u'编码结果'] = newdatas[u'编码结果'].astype(int)
for r2 in range(0,len(dfhelp)):
    t2 = dfocc.loc[dfocc[u'受访者编号'] == dfhelp.iloc[r2][u'受访者编号']]
    if t2.empty == False:
        tmp = pd.DataFrame([dfhelp.iloc[r2]])
        tmp.iloc[0,5] = t2.iloc[0][u'编码结果']
        frame = [newdatas,tmp]
        newdatas = pd.concat(frame)

newdatas1 = newdatas.iloc[:,[5,3]]
newdatas1.to_csv('data/occ/occ_raw.txt',mode='ab+',index=False,sep='\t',encoding="utf_8_sig",header=0)
