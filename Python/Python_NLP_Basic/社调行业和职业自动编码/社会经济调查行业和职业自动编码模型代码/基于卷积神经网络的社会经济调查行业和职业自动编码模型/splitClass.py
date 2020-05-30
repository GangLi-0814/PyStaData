# coding=utf-8

import pandas as pd
import numpy as np



# 职业训练集,验证集和测试集
occfiles = [r'data/occ/occ_train.txt',r'data/occ/occ_val.txt',r'data/occ/occ_test.txt']

# 分割为高2位,中2位和低2位
count = 0
for occfile in occfiles:
    count = count+1
    df = pd.DataFrame(pd.read_table(occfile,sep='\t',encoding="utf_8_sig",names=['1','2'])) 
    df1 = df.copy()
    df2 = df.copy()
    df3 = df.copy()
    df = df["1"].values
    a0 = []
    a1 = []
    a2 = []

    for r in range(0,df.shape[0]):
        if u'0' == df[r]:
            x = u'000000'
        else:
            x = unicode(str(df[r]))
        a0.append(x[len(x)-2:len(x)]) # 低2
        a1.append(x[len(x)-4:len(x)-2]) # 中2
        a2.append(x[:len(x)-4]) # 高2

    df1["1"] = a0
    df2["1"] = a1
    df3["1"] = a2
    if 1 == count :
        df1.to_csv('data/occ/occ_train_12.txt',index=False,sep='\t',encoding="utf_8_sig",header=0)
        df2.to_csv('data/occ/occ_train_34.txt',index=False,sep='\t',encoding="utf_8_sig",header=0) 
        df3.to_csv('data/occ/occ_train_56.txt',index=False,sep='\t',encoding="utf_8_sig",header=0)
    elif 2 == count :
        df1.to_csv('data/occ/occ_val_12.txt',index=False,sep='\t',encoding="utf_8_sig",header=0)
        df2.to_csv('data/occ/occ_val_34.txt',index=False,sep='\t',encoding="utf_8_sig",header=0) 
        df3.to_csv('data/occ/occ_val_56.txt',index=False,sep='\t',encoding="utf_8_sig",header=0)
    else :
        df1.to_csv('data/occ/occ_test_12.txt',index=False,sep='\t',encoding="utf_8_sig",header=0)
        df2.to_csv('data/occ/occ_test_34.txt',index=False,sep='\t',encoding="utf_8_sig",header=0) 
        df3.to_csv('data/occ/occ_test_56.txt',index=False,sep='\t',encoding="utf_8_sig",header=0)         



# 行业训练集,验证集和测试集
indfiles = [r'data/ind/ind_train.txt',r'data/ind/ind_val.txt',r'data/ind/ind_test.txt']

# 分割为高2位,中2位和低2位
count = 0
for indfile in indfiles:
    count = count+1
    dfs = pd.DataFrame(pd.read_table(indfile,sep='\t',encoding="utf_8_sig",names=['1','2'])) 
    df4 = pd.DataFrame(dfs)
    df5 = pd.DataFrame(dfs)
    df4 = dfs.copy()
    df5 = dfs.copy()
    dfs = dfs["1"].values
    b1 = []
    b2 = []

    for r1 in range(0,dfs.shape[0]):
        if u'0' == dfs[r1]:
            x = u'000000'
        else:
            x = unicode(dfs[r1])
        b1.append(x[len(x)-4:len(x)-2])#中2
        b2.append(x[:len(x)-4])#高2
    
    df4["1"] = b1
    df5["1"] = b2
    
    if 1 == count :
        df4.to_csv('data/ind/ind_train_34.txt',index=False,sep='\t',encoding="utf_8_sig",header=0)
        df5.to_csv('data/ind/ind_train_56.txt',index=False,sep='\t',encoding="utf_8_sig",header=0)
    elif 2 == count :
        df4.to_csv('data/ind/ind_val_34.txt',index=False,sep='\t',encoding="utf_8_sig",header=0)
        df5.to_csv('data/ind/ind_val_56.txt',index=False,sep='\t',encoding="utf_8_sig",header=0)
    else :
        df4.to_csv('data/ind/ind_test_34.txt',index=False,sep='\t',encoding="utf_8_sig",header=0)
        df5.to_csv('data/ind/ind_test_56.txt',index=False,sep='\t',encoding="utf_8_sig",header=0)
