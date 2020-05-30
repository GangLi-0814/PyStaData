# coding=utf-8

import numpy as np
import pandas as pd
import math
import re
import hashlib
import urllib
import random
import json
import time
from data.helper import multi_sub, is_chinese, is_digit, is_letter, getlistnum, cut_by_seqlength



min_num = 500  # 设定每个样本最少需要的个数
threshold1 = 30  # 不同数据增强方法选择的判断阈值



# 读取数据集
indfile = r'data/ind/ind_raw.txt'
df = pd.DataFrame(pd.read_table(indfile,sep='\t',encoding="utf_8_sig",names=['1','2']))

# 读取分类说明文件
classfile = u'data/classes.xls'
classdf = pd.DataFrame(pd.read_excel(classfile,sheetname=u'行业',encoding='utf_8_sig'))
ind_encode = classdf['code'].values

# 读取text和helptext空值对应code
n1 = classdf.loc[(classdf[u'text'].isnull())]
textnull = n1['code'].values
textnull = textnull.tolist()
n2 = classdf.loc[(classdf[u'helptext'].isnull())]
helpnull = n2['code'].values
helpnull = helpnull.tolist()


# 过滤换行符
tem = classdf[u'text'].str.replace("\n","")
classdf[u'text']=tem
tem1 = classdf[u'helptext'].str.replace("\n","")
classdf[u'helptext']=tem1

# 过滤不合法字符
dfvalue = classdf[u'text'].values
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
classdf[u'text'] = result_new

dfvalue1 = classdf[u'helptext'].values
result_new1 = []
b = []

for r0 in range(0,dfvalue1.shape[0]):
    temx = unicode(dfvalue1[r0])  
    for r1 in range(0,len(temx)):
        if is_chinese(temx[r1]) == False and is_digit(temx[r1]) == False and is_letter(temx[r1]) == False:
            b.append(r1)
    if b:
        temx = multi_sub(temx,b,u'')
        b = []
    result_new1.append(temx)
classdf[u'helptext'] = result_new1



def rever_translate(comment):
    '''
    实现回译
    comment:原文本
    return:回译语句组成的列表
    '''
    appid = ' '  # 用自己的百度账号登陆可以获得api的id和secret,本代码略去
    secretKey = ' '
    url_baidu = 'https://api.fanyi.baidu.com/api/trans/vip/translate'
    text = comment.encode('utf-8')
    #lan_list = ['en', 'yue', 'jp', 'kor', 'fra', 'spa', 'th', 'ara', 'ru', 'pt', 'de', 'it', 'el', 'nl', 'pl', 'bul', 'est', 'dan', 'fin', 'cs', 'rom', 'slo', 'swe', 'hu', 'cht', 'vie']
    lan_list = ['en', 'jp', 'kor', 'spa', 'ara', 'vie']  # 语言列表,由于样本数量较多,26种语言回译耗时过长,缩减至6种
    first_tran = []
    rever_tran = []
    
    # 正向翻译,翻译成6种目标语言
    for lan in lan_list:
        while True:
            salt = random.randint(32768, 65536)
            sign = appid + text + str(salt) + secretKey
            sign = hashlib.md5(sign).hexdigest()    
            url = url_baidu + '?appid=' + appid + '&q=' + urllib.quote(text) + '&from=' + 'zh' + '&to=' + lan + '&salt=' + str(salt) + '&sign=' + sign
            response = urllib.urlopen(url)
            content = response.read().decode('utf-8')
            if (u"error" not in content):
                break
            else:
                pass   
        data = json.loads(content)
        translate_results = (data['trans_result'][0]['dst'])
           
        first_tran.append(translate_results)
        response.close()
        time.sleep(1)

    # 反向翻译,回译成原语言
    for i in first_tran:
        while True:
            index = first_tran.index(i)
            salt = random.randint(32768, 65536)
            sign = appid + text + str(salt) + secretKey
            sign = hashlib.md5(sign).hexdigest()    
            url = url_baidu + '?appid=' + appid + '&q=' + urllib.quote(text) + '&from=' + lan_list[index] + '&to=' + 'zh' + '&salt=' + str(salt) + '&sign=' + sign
            response = urllib.urlopen(url)       
            content = response.read().decode('utf-8')
            if (u"error" not in content):
                break
            else:
                pass
        data = json.loads(content)
        translate_results = (data['trans_result'][0]['dst'])   
        response.close()
        time.sleep(1)
        rever_tran.append( unicode(translate_results) )    
    return rever_tran



# 对编码列(标签列)的所有元素作个数统计,并按元组(编码,个数)排序
col_count = getlistnum(df['1'])
col_count1 = sorted(col_count.items(), key=lambda d:d[1])

# 在样本集出现的编码列表和存在该编码但未出现的编码列表
app_encode = []
napp_encode = []
for j in col_count1:
    app_encode.append(int(j[0]))
for k in ind_encode:
    if k not in app_encode:
        napp_encode.append(k)


# 处理样本数不足且等于0的样本
print u'样本数不足且等于0'
ctr=0
encodelists = []
answerlists = []
for napp in napp_encode:
    ctr=ctr+1
    print (ctr,napp)
    encodelist = []
    answerlist = []
    count_num = 0
    
    # 读取text
    if napp not in textnull:
        answer2 = (classdf.loc[classdf['code']==napp])['text'].values[0]
        answers = cut_by_seqlength(answer2, 15)
        for ans in answers:
            answerlist.append(ans)
            encodelist.append(napp)
    # 读取helptext
    if napp not in helpnull:
        answer3 = (classdf.loc[classdf['code']==napp])['helptext'].values[0]
        answers = cut_by_seqlength(answer3, 15)
        for ans in answers:
            answerlist.append(ans)
            encodelist.append(napp)

    count_num = len(answerlist)
    if count_num>=min_num:
        encodelist = encodelist[:min_num]
        answerlist = answerlist[:min_num]
        encodelists+=encodelist
        answerlists+=answerlist
    # 未到达每个样本最少需要的个数时进行回译
    else:
        encodelist1 = []
        answerlist1 = []
        reve1 = []
        enco1 = []   
        for ans in answerlist:
            rever_ans = rever_translate(ans)          
            for w in rever_ans:
                reve1.append(w)
                enco1.append(napp)
            answerlist1 += reve1
            encodelist1 += enco1
        encodelists+=encodelist1
        answerlists+=answerlist1


# 对回译后的数据进行清洗
answer_new = []
b1 = []
for ans_i in range(len(answerlists)):
    temans = unicode(answerlists[ans_i])
    for rx in range(0,len(temans)):
        if is_chinese(temans[rx]) == False and is_digit(temans[rx]) == False and is_letter(temans[rx]) == False:
            b1.append(rx)   
    if b1:
        temans = multi_sub(temans,b1,u'')
        b1 = []
    if '' == temans:
        temans = ( (df.loc[df['1'] == encodelists[ans_i]])['2'].values )[0]
    answer_new.append(temans)  

# 保存增加的样本至文件中
newdata0=pd.DataFrame(data=None,columns=['1','2'])
newdata0['1'] = encodelists
newdata0['2'] = answer_new
newdata0.to_csv('data/ind/ind_da0.txt',mode='ab+',index=False,sep='\t',encoding="utf_8_sig",header=0)



# 处理样本数不足且大于等于1的样本
print u'样本数不足且大于等于1'
ctr=0
encodelists = []
answerlists = []
for i in col_count1:
    ctr=ctr+1
    print (ctr,i[0])
    encodelist = []
    answerlist = []
    count_num = 0
    x = int(i[0])
    if x not in ind_encode:
        continue
    
    # 样本数大于等于阈值且小于每个样本最少需要的个数
    if i[1]>=threshold1 and i[1]<min_num:
        # 读取text
        if x not in textnull:
            answer2 = (classdf.loc[classdf['code']==x])['text'].values[0]
            answers = cut_by_seqlength(answer2, 15)
            for ans in answers:
                answerlist.append(ans)
                encodelist.append(x)
        # 读取helptext
        if x not in helpnull:
            answer3 = (classdf.loc[classdf['code']==x])['helptext'].values[0]
            answers = cut_by_seqlength(answer3, 15)
            for ans in answers:
                answerlist.append(ans)
                encodelist.append(x)
        count_num = i[1]+len(answerlist)
        if count_num>=min_num-i[1]:
            encodelist = encodelist[:min_num-i[1]]
            answerlist = answerlist[:min_num-i[1]]
        encodelists+=encodelist
        answerlists+=answerlist

      
    # 样本数小于阈值
    if i[1]<threshold1:
        # 读取原始编码和答案样本
        tem = df.loc[df['1'] == i[0]]
        for answer1 in tem['2'].values:
            answers = cut_by_seqlength(answer1, 15)
            for ans in answers:
                answerlist.append(ans)
                encodelist.append(x)       
        # 读取text
        if x not in textnull:
            answer2 = (classdf.loc[classdf['code']==x])['text'].values[0]
            answers = cut_by_seqlength(answer2, 15)
            for ans in answers:
                answerlist.append(ans)
                encodelist.append(x)
        # 读取helptext
        if x not in helpnull:
            answer3 = (classdf.loc[classdf['code']==x])['helptext'].values[0]
            answers = cut_by_seqlength(answer3, 15)
            for ans in answers:
                answerlist.append(ans)
                encodelist.append(x)
        count_num = len(answerlist)
        if count_num>=min_num-i[1]:
            encodelist = encodelist[:min_num-i[1]]
            answerlist = answerlist[:min_num-i[1]]
            encodelists+=encodelist
            answerlists+=answerlist

        # 未到达每个样本最少需要的个数时进行回译
        else:
            encodelist1 = []
            answerlist1 = []
            reve1 = []
            enco1 = []
   
            for ans in answerlist:
                rever_ans = rever_translate(ans)          
                for w in rever_ans:
                    reve1.append(w)
                    enco1.append(i[0])
                answerlist1 += reve1
                encodelist1 += enco1
            encodelists+=encodelist1
            answerlists+=answerlist1


# 对回译后的数据进行清洗
answer_new = []
b1 = []
for ans_i in range(len(answerlists)):
    temans = unicode(answerlists[ans_i])
    print (temans)
    for rx in range(0,len(temans)):
        if is_chinese(temans[rx]) == False and is_digit(temans[rx]) == False and is_letter(temans[rx]) == False:
            b1.append(rx)   
    if b1:
        temans = multi_sub(temans,b1,u'')
        b1 = []
    if '' == temans:
        print (encodelists[ans_i])
        temans = ( (df.loc[df['1'] == unicode(encodelists[ans_i])])['2'].values )[0]
    answer_new.append(temans)        

# 保存增加的样本至文件中
newdata=pd.DataFrame(data=None,columns=['1','2'])
newdata['1'] = encodelists
newdata['2'] = answer_new
newdata.to_csv('data/ind/ind_da.txt',mode='ab+',index=False,sep='\t',encoding="utf_8_sig",header=0)
