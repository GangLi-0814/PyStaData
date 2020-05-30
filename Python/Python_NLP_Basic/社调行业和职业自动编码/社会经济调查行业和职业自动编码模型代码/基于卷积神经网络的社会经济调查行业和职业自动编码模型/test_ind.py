# coding=utf-8

from __future__ import print_function

import os
import sys
import time
from datetime import timedelta

import numpy as np
import tensorflow as tf
from sklearn import metrics

from cnn_model import TCNNConfig, TextCNN
from data.helper import read_file, read_vocab, read_cate, read_encode, batch_iter, process_file, build_vocab

# 行业字典路径
base_dir = 'data/'
ind_base_dir = 'data/ind/'
ind_vocab_dir = os.path.join(base_dir, 'ind_vocab.txt')

# 最佳验证结果保存路径
save_dir = 'checkpoints/textcnn/ind'
save_meta_path1 = os.path.join(save_dir, 'best_validation_ind_34.meta')
save_path1 = os.path.join(save_dir, 'best_validation_ind_34')
save_meta_path2 = os.path.join(save_dir, 'best_validation_ind_56.meta')
save_path2 = os.path.join(save_dir, 'best_validation_ind_56')

# 行业测试集
ind_test_dir1 = os.path.join(ind_base_dir, 'ind_test_34.txt')
ind_test_dir2 = os.path.join(ind_base_dir, 'ind_test_56.txt')
ind_test_dirs =[ind_test_dir1, ind_test_dir2]



def get_time_dif(start_time):
    '''
    获取已使用时间
    start_time:开始时间
    return:程序运行时间
    '''
    end_time = time.time()
    time_dif = end_time - start_time
    return timedelta(seconds=int(round(time_dif)))



def feed_data(x_batch, y_batch, keep_prob):
    '''
    向模型中传入输入向量
    '''
    feed_dict = {
        model.input_x: x_batch,
        model.input_y: y_batch,
        model.keep_prob: keep_prob
    }
    return feed_dict



def evaluate(sess, x_, y_):
    '''
    评估在某一数据上的准确率和损失
    '''
    data_len = len(x_)
    batch_eval = batch_iter(x_, y_, 128)
    total_loss = 0.0
    total_acc = 0.0
    for x_batch, y_batch in batch_eval:
        batch_len = len(x_batch)
        feed_dict = feed_data(x_batch, y_batch, 1.0)
        loss, acc = sess.run([model.loss, model.acc], feed_dict=feed_dict)
        total_loss += loss * batch_len
        total_acc += acc * batch_len

    return total_loss / data_len, total_acc / data_len



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



def test():
    '''
    对行业编码模型进行测试
    '''

    # 分别读取行业中位和高位的预测网络模型,分别对每个模型测试
    print("Loading test data...")
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
        
            x_test, y_test = process_file(ind_test_dirs[0], word_to_id, ind_df1, config1.seq_length)
            batch_size = 128
            data_len = len(x_test)
            num_batch = int((data_len - 1) / batch_size) + 1
        
            y_test_cls = np.argmax(y_test, 1)
            y_pred_cls1 = np.zeros(shape=len(x_test), dtype=np.int32)  # 保存预测结果
            softtensor1 = np.zeros(shape=(len(x_test),ind_df1.shape[0]), dtype=np.float64)
            topk1 = np.zeros(shape=(len(x_test),ind_df1.shape[0]), dtype=np.float64)
            index1 = np.zeros(shape=(len(x_test),ind_df1.shape[0]), dtype=np.int32)
            for i in range(num_batch):  # 逐批次处理
                start_id = i * batch_size
                end_id = min((i + 1) * batch_size, data_len)
                feed_dict = {
                    input_x: x_test[start_id:end_id],
                    keep_prob: 1.0
                }
                # 预测的类号和logits
                y_pred_cls1[start_id:end_id],softtensor1[start_id:end_id] = sess1.run([argmax1,softmax1], feed_dict=feed_dict)
                
                # 概率和索引
                topk1[start_id:end_id] = tf.nn.top_k(softtensor1[start_id:end_id],ind_df1.shape[0])[0].eval(session=sess1)
                index1[start_id:end_id] = tf.nn.top_k(softtensor1[start_id:end_id],ind_df1.shape[0])[1].eval(session=sess1)
            # 评估
            print("Precision, Recall and F1-Score...")
            print(metrics.classification_report(y_test_cls, y_pred_cls1))

            # 混淆矩阵
            print("Confusion Matrix...")
            cm = metrics.confusion_matrix(y_test_cls, y_pred_cls1)
            print(cm)

    with sess2.as_default():
        with g2.as_default():
            input_x = g2.get_tensor_by_name("input_x:0")
            keep_prob = g2.get_tensor_by_name("keep_prob:0")
            argmax2 = g2.get_tensor_by_name("score/y_pred_cls:0")
            softmax2 = g2.get_tensor_by_name("score/Softmax:0")
        
            x_test, y_test = process_file(ind_test_dirs[1], word_to_id, ind_df2, config2.seq_length)
            batch_size = 128
            data_len = len(x_test)
            num_batch = int((data_len - 1) / batch_size) + 1
            
            y_test_cls = np.argmax(y_test, 1)
            y_pred_cls2 = np.zeros(shape=len(x_test), dtype=np.int32)  # 保存预测结果
            softtensor2 = np.zeros(shape=(len(x_test),ind_df2.shape[0]), dtype=np.float64)
            topk2 = np.zeros(shape=(len(x_test),ind_df2.shape[0]), dtype=np.float64)
            index2 = np.zeros(shape=(len(x_test),ind_df2.shape[0]), dtype=np.int32)
            for i in range(num_batch):  # 逐批次处理
                start_id = i * batch_size
                end_id = min((i + 1) * batch_size, data_len)
                feed_dict = {
                    input_x: x_test[start_id:end_id],
                    keep_prob: 1.0
                }
                # 预测的类号和logits
                y_pred_cls2[start_id:end_id],softtensor2[start_id:end_id] = sess2.run([argmax2,softmax2], feed_dict=feed_dict)

                # 概率和索引
                topk2[start_id:end_id] = tf.nn.top_k(softtensor2[start_id:end_id],ind_df2.shape[0])[0].eval(session=sess2)
                index2[start_id:end_id] = tf.nn.top_k(softtensor2[start_id:end_id],ind_df2.shape[0])[1].eval(session=sess2)
            # 评估
            print("Precision, Recall and F1-Score...")
            print(metrics.classification_report(y_test_cls, y_pred_cls2))

            # 混淆矩阵
            print("Confusion Matrix...")
            cm = metrics.confusion_matrix(y_test_cls, y_pred_cls2)
            print(cm)

    # 对预测结果串联,形成完整的行业预测编码,再进行测试
    start_time = time.time()
    con_encodes = []
    #count = 0 
    _, all_y_test_cls = read_file('data/ind/ind_test.txt')
    for row in range(len(x_test)):
        k1 = 0
        k2 = 0
        while True:
            con_encode = opmap_concat(index1[row][k1], index2[row][k2])

            if True == judge_encode(con_encode):
                #count = count+1
                con_encodes.append( unicode(con_encode) )
                break
            else:
                if k1+1>=topk1.shape[1] or k2+1>=topk2.shape[1]:
                    #count = count+1
                    con_encodes.append( unicode('0') )
                    break
                prob1 = topk1[row][k1+1]*topk2[row][k2]
                prob2 = topk1[row][k1]*topk2[row][k2+1]
               
                prob = [prob1, prob2]
                indprob = prob.index(max(prob))
                if 0 == indprob:
                    k1 = k1+1
                else:
                    k2 = k2+1

    # 评估
    print("Precision, Recall and F1-Score...")
    print(metrics.classification_report(all_y_test_cls, con_encodes))

    # 混淆矩阵
    print("Confusion Matrix...")
    cm = metrics.confusion_matrix(all_y_test_cls, con_encodes)
    print(cm)  

    time_dif = get_time_dif(start_time)
    print("Time usage:", time_dif)
    #print (count)

if __name__ == '__main__':
    '''
    主函数:对行业预测编码模型及其组合结果进行测试
    '''
    print('Configuring CNN model...')
    occ_df1, occ_df2, occ_df3, ind_df1, ind_df2 = read_cate()
    if not os.path.exists(ind_vocab_dir):  # 如果不存在词汇表，重建
        build_vocab(ind_train_dir, ind_vocab_dir, 5000)

    words, word_to_id = read_vocab(ind_vocab_dir)
    vocab_size = len(words)
    config1 = TCNNConfig(ind_df1.shape[0], vocab_size)#mid 
    config2 = TCNNConfig(ind_df2.shape[0], vocab_size)#hig   

    test()
