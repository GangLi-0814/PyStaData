# coding: utf-8

from __future__ import print_function

import os
import numpy as np
import tensorflow as tf
import tensorflow.contrib.keras as kr

from cnn_model import TCNNConfig, TextCNN
from data.helper import read_file, read_vocab, read_cate, read_encode, batch_iter, process_file, build_vocab

import sys

try:
    bool(type(unicode))
except NameError:
    unicode = str

# 行业字典路径
base_dir = 'data/'
vocab_dir = os.path.join(base_dir, 'ind_vocab.txt')

# 行业最佳验证结果保存路径
save_dir = 'checkpoints/textcnn/ind'
save_meta_path1 = os.path.join(save_dir, 'best_validation_ind_34.meta')
save_path1 = os.path.join(save_dir, 'best_validation_ind_34')
save_meta_path2 = os.path.join(save_dir, 'best_validation_ind_56.meta')
save_path2 = os.path.join(save_dir, 'best_validation_ind_56')  



def opmap_concat(k1, k2):
    '''
    将中间和高位预测结果连接
    k1:中间预测结果,k2:高位预测结果
    return:完整预测编码(int)
    '''
    uk1 = unicode( (ind_df1.loc[ind_df1['2']==int(k1)])['1'].values[0] )
    uk2 = unicode( (ind_df2.loc[ind_df2['2']==int(k2)])['1'].values[0] )
    if u'99' == uk1 and u'99' == uk2:
        con_encode0 = 999999
        return con_encode0

    if 1 == len(unicode(uk1)):
        uk1 = u'0'+unicode(uk1)

    con_encode = uk2+uk1+'00'
    return int(con_encode)

def judge_encode(con_encode):
    '''
    判断完整预测编码是否存在
    con_encode:完整预测编码
    return:bool值
    '''
    _, ind_encode = read_encode()
    if con_encode in ind_encode:
        return True
    else:
        return False



def predict(answer):
    '''
    根据答案预测编码
    answer:提供的答案序列
    return:预测编码(unicode)
    '''

    # 分别读取行业中位和高位的预测网络模型
    g1 = tf.Graph()
    sess1= tf.Session(graph=g1)
    with g1.as_default():
        new_saver = tf.train.import_meta_graph(save_meta_path1)
        new_saver.restore(sess1, save_path1)
   
    g2 = tf.Graph()
    sess2= tf.Session(graph=g2)    
    with g2.as_default():
        new_saver = tf.train.import_meta_graph(save_meta_path2)
        new_saver.restore(sess2, save_path2)

    with sess1.as_default():
        with g1.as_default():
            input_x = g1.get_tensor_by_name("input_x:0")
            keep_prob = g1.get_tensor_by_name("keep_prob:0")
            argmax1 = g1.get_tensor_by_name("score/y_pred_cls:0")
            softmax1 = g1.get_tensor_by_name("score/Softmax:0")
        
            content = unicode(answer)
            data = [word_to_id[x] for x in content if x in word_to_id]
            y_pred_cls1 = np.zeros(shape=1, dtype=np.int32)  # 保存预测结果
            softtensor1 = np.zeros(shape=(1,ind_df1.shape[0]), dtype=np.float64)
            topk1 = np.zeros(shape=(1,ind_df1.shape[0]), dtype=np.float64)
            index1 = np.zeros(shape=(1,ind_df1.shape[0]), dtype=np.int32)
            feed_dict = {
                input_x: kr.preprocessing.sequence.pad_sequences([data], config1.seq_length),
                keep_prob: 1.0
            }
            # 预测的类号和logits
            y_pred_cls1,softtensor1 = sess1.run([argmax1,softmax1], feed_dict=feed_dict)
            # 概率和索引
            topk1 = tf.nn.top_k(softtensor1,ind_df1.shape[0])[0].eval(session=sess1)
            index1 = tf.nn.top_k(softtensor1,ind_df1.shape[0])[1].eval(session=sess1)

    with sess2.as_default():
        with g2.as_default():
            input_x = g2.get_tensor_by_name("input_x:0")
            keep_prob = g2.get_tensor_by_name("keep_prob:0")
            argmax2 = g2.get_tensor_by_name("score/y_pred_cls:0")
            softmax2 = g2.get_tensor_by_name("score/Softmax:0")
        
            content = unicode(answer)
            data = [word_to_id[x] for x in content if x in word_to_id]
            y_pred_cls2 = np.zeros(shape=1, dtype=np.int32)  # 保存预测结果
            softtensor2 = np.zeros(shape=(1,ind_df2.shape[0]), dtype=np.float64)
            topk2 = np.zeros(shape=(1,ind_df2.shape[0]), dtype=np.float64)
            index2 = np.zeros(shape=(1,ind_df2.shape[0]), dtype=np.int32)
            feed_dict = {
                input_x: kr.preprocessing.sequence.pad_sequences([data], config2.seq_length),
                keep_prob: 1.0
            }
            # 预测的类号和logits
            y_pred_cls2,softtensor2 = sess2.run([argmax2,softmax2], feed_dict=feed_dict)
            # 概率和索引
            topk2 = tf.nn.top_k(softtensor2,ind_df2.shape[0])[0].eval(session=sess2)
            index2 = tf.nn.top_k(softtensor2,ind_df2.shape[0])[1].eval(session=sess2)

    # 对预测结果串联,形成完整的行业预测编码
    k1 = 0
    k2 = 0
    pre_code = unicode('0')
    while True:
        con_encode = opmap_concat(index1[0][k1], index2[0][k2])
        if True == judge_encode(con_encode):
            print ( u'\'' + answer + u'\'' + u'的预测编码为：' + unicode (con_encode) )
            pre_code = unicode(con_encode)
            break
        else:
            if k1+1>=topk1.shape[1] or k2+1>=topk2.shape[1]:
                print (  u'\'' + answer + u'\'' + u'的预测编码为：' + unicode('0') )
                pre_code = unicode('0')
                break
            prob1 = topk1[0][k1+1]*topk2[0][k2]
            prob2 = topk1[0][k1]*topk2[0][k2+1]
            prob = [prob1, prob2]
            indprob = prob.index(max(prob))
            if 0 == indprob:
                k1 = k1+1
            else:
                k2 = k2+1
    return pre_code



if __name__ == '__main__':
    '''
    主函数:对合法的字符串进行行业预测编码
    输入参数:字符串
    '''
    occ_df1, occ_df2, occ_df3, ind_df1, ind_df2 = read_cate()
    words, word_to_id = read_vocab(vocab_dir)
    vocab_size = len(words)
    config1 = TCNNConfig(ind_df1.shape[0], vocab_size)  # mid
    config2 = TCNNConfig(ind_df2.shape[0], vocab_size)  # hig    

    if len(sys.argv) > 1:
        for i in range(1,len(sys.argv)):
            if type(sys.argv[i])==str:
                answer = sys.argv[i].decode('utf8')
                predict(answer)
            else:
                print ("Please input the valid answer(s).")
    else:
        print ("Please input the valid answer(s)(need at least 1 answer).")
