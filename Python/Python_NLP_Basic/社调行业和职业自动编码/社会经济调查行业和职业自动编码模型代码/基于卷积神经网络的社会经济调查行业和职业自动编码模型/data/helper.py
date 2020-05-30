# coding: utf-8

import sys
from collections import Counter

import numpy as np
import tensorflow.contrib.keras as kr
import pandas as pd


if sys.version_info[0] > 2:
    is_py3 = True
else:
    reload(sys)
    sys.setdefaultencoding("utf-8")
    is_py3 = False



def native_word(word, encoding='utf-8-sig'):
    """如果在python2下面使用python3训练的模型，可考虑调用此函数转化一下字符编码"""
    if not is_py3:
        return word.encode(encoding)
    else:
        return word



def native_content(content):
    if not is_py3:
        return content.decode('utf-8-sig')
    else:
        return content



def open_file(filename, mode='r'):
    """
    常用文件操作，可在python2和python3间切换.
    mode: 'r' or 'w' for read or write
    """
    if is_py3:
        return open(filename, mode, encoding='utf-8-sig', errors='ignore')
    else:
        return open(filename, mode)



def read_file(filename):
    """
    读取文件数据
    filename:文件名
    return:内容(答案文本),标签(编码)
    """
    contents, labels = [], []
    with open_file(filename) as f:
        for line in f:
            try:
                label, content = line.strip().split('\t')
                if content:
                    contents.append(list(native_content(content)))
                    labels.append(native_content(label))
            except:
                pass
    return contents, labels



def build_vocab(train_dir, vocab_dir, vocab_size=5000):
    """
    根据训练集构建词汇表，存储
    train_dir:训练集路径,vocab_dir:词典路径,vocab_size:词典包含词数
    """
    data_train, _ = read_file(train_dir)

    all_data = []
    for content in data_train:
        all_data.extend(content)

    counter = Counter(all_data)
    count_pairs = counter.most_common(vocab_size - 1)
    words, _ = list(zip(*count_pairs))
    # 添加一个 <PAD> 来将所有文本pad为同一长度
    words = ['<PAD>'] + list(words)
    open_file(vocab_dir, mode='w').write('\n'.join(words) + '\n')



def read_vocab(vocab_dir):
    """
    读取词汇表
    vocab_dir:词典路径
    return:词典中的词,词和词序号映射关系
    """
    # words = open_file(vocab_dir).read().strip().split('\n')
    with open_file(vocab_dir) as fp:
        # 如果是py2 则每个值都转化为unicode
        words = [native_content(_.strip()) for _ in fp.readlines()]
    word_to_id = dict(zip(words, range(len(words))))
    return words, word_to_id



def read_cate():
    """
    读取各级编码与类别号映射
    return:各级编码映射表(pd.dataframe)
    """
    occ_txtFile1 = r'data/mapping/occ_lowmap.txt'
    occ_txtFile2 = r'data/mapping/occ_midmap.txt'
    occ_txtFile3 = r'data/mapping/occ_highmap.txt'
    ind_txtFile1 = r'data/mapping/ind_midmap.txt'
    ind_txtFile2 = r'data/mapping/ind_highmap.txt'
    
    occ_df1 = pd.DataFrame(pd.read_table(occ_txtFile1,sep='\t',encoding="utf_8_sig",names=['1','2'])) 
    occ_df2 = pd.DataFrame(pd.read_table(occ_txtFile2,sep='\t',encoding="utf_8_sig",names=['1','2'])) 
    occ_df3 = pd.DataFrame(pd.read_table(occ_txtFile3,sep='\t',encoding="utf_8_sig",names=['1','2'])) 
    ind_df1 = pd.DataFrame(pd.read_table(ind_txtFile1,sep='\t',encoding="utf_8_sig",names=['1','2'])) 
    ind_df2 = pd.DataFrame(pd.read_table(ind_txtFile2,sep='\t',encoding="utf_8_sig",names=['1','2'])) 
    occ_df1['1'] = occ_df1['1'].astype('int')
    occ_df2['1'] = occ_df2['1'].astype('int')
    occ_df3['1'] = occ_df3['1'].astype('int')
    ind_df1['1'] = ind_df1['1'].astype('int')
    ind_df2['1'] = ind_df2['1'].astype('int')
    return occ_df1,occ_df2,occ_df3,ind_df1,ind_df2



def read_encode():
    """
    读取所有完整编码类别
    return:完整编码类别数组(np.array)
    """
    excelFile = r'data/classes.xls'
    ind_classes = pd.DataFrame(pd.read_excel(excelFile,sheetname='行业',encoding="utf_8_sig"))
    occ_classes = pd.DataFrame(pd.read_excel(excelFile,sheetname='职业',encoding="utf_8_sig"))
    
    occ_encode = occ_classes['code'].values
    ind_encode = ind_classes['code'].values
    occ_encode = np.append(occ_encode,[0,999999])
    ind_encode = np.append(ind_encode,[0,999999])
    return occ_encode,ind_encode  # array



def to_words(content, words):
    """
    将id表示的内容转换为文字
    content:内容(答案文本),words:词典中的词
    """
    return ''.join(words[x] for x in content)


def process_file(filename, word_to_id, cat_to_id, max_length=600):
    """
    将文件转换为id表示
    filename:文件名,word_to_id:词和词序号映射关系,cat_to_id:编码类别到类别号的映射,max_length:文本向量最大长度
    return:文本向量,标签one-hot向量
    """
    contents, labels = read_file(filename)

    data_id, label_id = [], []
    for i in range(len(contents)):
        data_id.append([word_to_id[x] for x in contents[i] if x in word_to_id])
        label_id.append(((cat_to_id.loc[cat_to_id['1']==int(labels[i])])['2']).values[0])
        
    # 使用keras提供的pad_sequences来将文本pad为固定长度
    x_pad = kr.preprocessing.sequence.pad_sequences(data_id, max_length)
    y_pad = kr.utils.to_categorical(label_id, num_classes = cat_to_id.shape[0])  # 将标签转换为one-hot表示
    return x_pad, y_pad



def batch_iter(x, y, batch_size=64):
    """
    生成批次数据
    """
    data_len = len(x)
    num_batch = int((data_len - 1) / batch_size) + 1

    indices = np.random.permutation(np.arange(data_len))
    x_shuffle = x[indices]
    y_shuffle = y[indices]

    for i in range(num_batch):
        start_id = i * batch_size
        end_id = min((i + 1) * batch_size, data_len)
        yield x_shuffle[start_id:end_id], y_shuffle[start_id:end_id]



def multi_sub(string,p,c):
    """
    替换字符串中多个指定位置为指定字符
    p:位置列表，c:对应替换的字符列表
    return:替换后的字符串
    """
    new = []
    for s in string:
        new.append(s)
    for index,point in enumerate(p):
        new[point] = c
    return ''.join(new)



def is_chinese(uchar):
    """
    判断是否是中文
    uchar:检测字符(unicode)
    return:bool值
    """
    if uchar >= u'\u4E00' and uchar <= u'\u9FA5':
        return True
    else:
        return False



def is_digit(uchar):
    """
    判断是否是数字
    uchar:检测字符(unicode)
    return:bool值
    """
    if uchar >= u'\u0030' and uchar <= u'\u0039':
        return True
    else:
        return False



def is_letter(uchar):
    """
    判断是否是英文字母
    uchar:检测字符(unicode)
    return:bool值
    """
    if ( uchar >= u'\u0041' and uchar <= u'\u005A' ) or ( uchar >= u'\u0061' and uchar <= u'\u007A'):
        return True
    else:
        return False



def getlistnum(li):
    """
    对列表的每个元素进行计数
    li:需要记数的列表
    return:字典(元素:元素个数)
    """
    li = list(li)
    set1 = set(li)
    dict1 = {}
    for item in set1:
        dict1.update({item:li.count(item)})
    return dict1
 


def cut_by_seqlength(answer, step):
    """
    将文本切成固定长度的若干段
    answer:原文本, step:切割长度
    return:包含切割后文本的列表
    """
    answernum = int((len(answer)-1)/step)+1
    answers = []
    for i in range(answernum):
        tem = answer[i*step:(i+1)*step]
        answers.append(tem)
    return answers
