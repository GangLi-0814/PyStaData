# coding: utf-8

import sys
import os
import numpy as np
import pandas as pd
import tensorflow as tf
import tensorflow.contrib.keras as kr
from cnn_model import TCNNConfig, TextCNN
from data.helper import read_file, read_vocab, read_cate, read_encode, batch_iter, process_file, build_vocab
from data.helper import getlistnum



filenames = []
# 字典路径
base_dir = 'data/'
vocab_dir1 = os.path.join(base_dir, 'ind_vocab.txt')
vocab_dir2 = os.path.join(base_dir, 'occ_vocab.txt')

# 行业最佳验证结果保存路径
save_dir1 = 'checkpoints/textcnn/ind'
save_meta_path1 = os.path.join(save_dir1, 'best_validation_ind_34.meta')
save_path1 = os.path.join(save_dir1, 'best_validation_ind_34')
save_meta_path2 = os.path.join(save_dir1, 'best_validation_ind_56.meta')
save_path2 = os.path.join(save_dir1, 'best_validation_ind_56')

# 职业最佳验证结果保存路径
save_dir2 = 'checkpoints/textcnn/occ'
save_meta_path3 = os.path.join(save_dir2, 'best_validation_occ_12.meta')
save_path3 = os.path.join(save_dir2, 'best_validation_occ_12')
save_meta_path4 = os.path.join(save_dir2, 'best_validation_occ_34.meta')
save_path4 = os.path.join(save_dir2, 'best_validation_occ_34')
save_meta_path5 = os.path.join(save_dir2, 'best_validation_occ_56.meta')
save_path5 = os.path.join(save_dir2, 'best_validation_occ_56')



def opmap_concat1(k1, k2):
    '''
    将(行业)中间和高位预测结果连接
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

def judge_encode1(con_encode):
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

def opmap_concat2(k1, k2, k3):
    '''
    将(职业)低位,中间和高位预测结果连接
    k1:中间预测结果,k2:高位预测结果
    return:完整预测编码(int)
    '''
    uk1 = unicode( (occ_df1.loc[occ_df1['2']==int(k1)])['1'].values[0] )
    uk2 = unicode( (occ_df2.loc[occ_df2['2']==int(k2)])['1'].values[0] )
    uk3 = unicode( (occ_df3.loc[occ_df3['2']==int(k3)])['1'].values[0] )
    if 1 == len(unicode(uk1)):
        uk1 = u'0'+unicode(uk1)
    if 1 == len(unicode(uk2)):
        uk2 = u'0'+unicode(uk2)
    con_encode = uk3+uk2+uk1
    return int(con_encode)

def judge_encode2(con_encode):
    '''
    判断完整预测编码是否存在
    con_encode:完整预测编码
    return:bool值
    '''
    occ_encode, _ = read_encode()
    if con_encode in occ_encode:
        return True
    else:
        return False



def predict_ind(answer):
    '''
    根据答案预测行业编码
    answer:提供的答案序列
    return:预测编码高位和中间位概率向量
    '''
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
            data = [word_to_id1[x] for x in content if x in word_to_id1]
            y_pred_cls1 = np.zeros(shape=1, dtype=np.int32)  # 保存预测结果
            softtensor1 = np.zeros(shape=(1,ind_df1.shape[0]), dtype=np.float64)
            topk1 = np.zeros(shape=(1,ind_df1.shape[0]), dtype=np.float64)
            index1 = np.zeros(shape=(1,ind_df1.shape[0]), dtype=np.int32)
            feed_dict = {
                input_x: kr.preprocessing.sequence.pad_sequences([data], config1.seq_length),
                keep_prob: 1.0
            }
            #预测的类号和logits
            y_pred_cls1,softtensor1 = sess1.run([argmax1,softmax1], feed_dict=feed_dict)

    with sess2.as_default():
        with g2.as_default():
            input_x = g2.get_tensor_by_name("input_x:0")
            keep_prob = g2.get_tensor_by_name("keep_prob:0")
            argmax2 = g2.get_tensor_by_name("score/y_pred_cls:0")
            softmax2 = g2.get_tensor_by_name("score/Softmax:0")
        
            content = unicode(answer)
            data = [word_to_id1[x] for x in content if x in word_to_id1]
            y_pred_cls2 = np.zeros(shape=1, dtype=np.int32)  # 保存预测结果
            softtensor2 = np.zeros(shape=(1,ind_df2.shape[0]), dtype=np.float64)
            topk2 = np.zeros(shape=(1,ind_df2.shape[0]), dtype=np.float64)
            index2 = np.zeros(shape=(1,ind_df2.shape[0]), dtype=np.int32)
            feed_dict = {
                input_x: kr.preprocessing.sequence.pad_sequences([data], config2.seq_length),
                keep_prob: 1.0
            }
            #预测的类号和logits
            y_pred_cls2,softtensor2 = sess2.run([argmax2,softmax2], feed_dict=feed_dict)
    return softtensor1,softtensor2



def predict_occ(answer):
    '''
    根据答案预测职业编码
    answer:提供的答案序列
    return:预测编码高位,中间位和低位概率向量
    '''
    g3 = tf.Graph()
    sess3= tf.Session(graph=g3)
    with g3.as_default():
        new_saver = tf.train.import_meta_graph(save_meta_path3)
        new_saver.restore(sess3, save_path3)
   
    g4 = tf.Graph()
    sess4= tf.Session(graph=g4)    
    with g4.as_default():
        new_saver = tf.train.import_meta_graph(save_meta_path4)
        new_saver.restore(sess4, save_path4)

    g5 = tf.Graph()
    sess5= tf.Session(graph=g5)    
    with g5.as_default():
        new_saver = tf.train.import_meta_graph(save_meta_path5)
        new_saver.restore(sess5, save_path5)

    with sess3.as_default():
        with g3.as_default():
            input_x = g3.get_tensor_by_name("input_x:0")
            keep_prob = g3.get_tensor_by_name("keep_prob:0")
            argmax1 = g3.get_tensor_by_name("score/y_pred_cls:0")
            softmax1 = g3.get_tensor_by_name("score/Softmax:0")
        
            content = unicode(answer)
            data = [word_to_id2[x] for x in content if x in word_to_id2]
            y_pred_cls1 = np.zeros(shape=1, dtype=np.int32)  # 保存预测结果
            softtensor1 = np.zeros(shape=(1,occ_df1.shape[0]), dtype=np.float64)
            topk1 = np.zeros(shape=(1,occ_df1.shape[0]), dtype=np.float64)
            index1 = np.zeros(shape=(1,occ_df1.shape[0]), dtype=np.int32)
            feed_dict = {
                input_x: kr.preprocessing.sequence.pad_sequences([data], config3.seq_length),
                keep_prob: 1.0
            }
            #预测的类号和logits
            y_pred_cls1,softtensor1 = sess3.run([argmax1,softmax1], feed_dict=feed_dict)

    with sess4.as_default():
        with g4.as_default():
            input_x = g4.get_tensor_by_name("input_x:0")
            keep_prob = g4.get_tensor_by_name("keep_prob:0")
            argmax2 = g4.get_tensor_by_name("score/y_pred_cls:0")
            softmax2 = g4.get_tensor_by_name("score/Softmax:0")
        
            content = unicode(answer)
            data = [word_to_id2[x] for x in content if x in word_to_id2]
            y_pred_cls2 = np.zeros(shape=1, dtype=np.int32)  # 保存预测结果
            softtensor2 = np.zeros(shape=(1,occ_df2.shape[0]), dtype=np.float64)
            topk2 = np.zeros(shape=(1,occ_df2.shape[0]), dtype=np.float64)
            index2 = np.zeros(shape=(1,occ_df2.shape[0]), dtype=np.int32)
            feed_dict = {
                input_x: kr.preprocessing.sequence.pad_sequences([data], config4.seq_length),
                keep_prob: 1.0
            }
            #预测的类号和logits
            y_pred_cls2,softtensor2 = sess4.run([argmax2,softmax2], feed_dict=feed_dict)

    with sess5.as_default():
        with g5.as_default():
            input_x = g5.get_tensor_by_name("input_x:0")
            keep_prob = g5.get_tensor_by_name("keep_prob:0")
            argmax3 = g5.get_tensor_by_name("score/y_pred_cls:0")
            softmax3 = g5.get_tensor_by_name("score/Softmax:0")
        
            content = unicode(answer)
            data = [word_to_id2[x] for x in content if x in word_to_id2]
            y_pred_cls3 = np.zeros(shape=1, dtype=np.int32)  # 保存预测结果
            softtensor3 = np.zeros(shape=(1,occ_df3.shape[0]), dtype=np.float64)
            topk3 = np.zeros(shape=(1,occ_df3.shape[0]), dtype=np.float64)
            index3 = np.zeros(shape=(1,occ_df3.shape[0]), dtype=np.int32)
            feed_dict = {
                input_x: kr.preprocessing.sequence.pad_sequences([data], config5.seq_length),
                keep_prob: 1.0
            }
            #预测的类号和logits
            y_pred_cls3,softtensor3 = sess5.run([argmax3,softmax3], feed_dict=feed_dict)
    return softtensor1,softtensor2,softtensor3



if __name__ == '__main__':
    '''
    主函数:对合法的文件进行预测编码,文件格式和数据集格式一致,且编码列为空。预测结果保存在“predict_result.xlsx”中
    输入参数:文件名字符串  
    '''
    occ_df1, occ_df2, occ_df3, ind_df1, ind_df2 = read_cate()
    words1, word_to_id1 = read_vocab(vocab_dir1)
    vocab_size1 = len(words1)
    words2, word_to_id2 = read_vocab(vocab_dir2)
    vocab_size2 = len(words2)

    config1 = TCNNConfig(ind_df1.shape[0], vocab_size1)  # mid
    config2 = TCNNConfig(ind_df2.shape[0], vocab_size1)  # hig    

    config3 = TCNNConfig(occ_df1.shape[0], vocab_size2)
    config4 = TCNNConfig(occ_df2.shape[0], vocab_size2)  # mid    
    config5 = TCNNConfig(occ_df3.shape[0], vocab_size2)  # hig

    # 合并文件
    for filename in sys.argv[1:]:
        if os.path.exists(filename):
            filenames.append(filename)
        else:
            print (filename + "does not exist.")
    df = pd.DataFrame(data=None,columns=[u'受访者编号',u'题型',u'题目',u'访员实地填写的答案',u'类别',u'编码结果'])
    dfnew = pd.DataFrame(data=None,columns=[u'受访者编号',u'题型',u'题目',u'访员实地填写的答案',u'类别',u'编码结果'])
    for filename in filenames:
        tem = pd.DataFrame(pd.read_excel(filename,encoding='utf_8_sig'))
        df=df.append(tem)
    tem = df[u'访员实地填写的答案'].str.replace("\n","")
    df[u'访员实地填写的答案']=tem
    df[u'受访者编号']=df[u'受访者编号'].astype(int)

    # 按受访者编号进行划分
    col_count = getlistnum(df[u'受访者编号'])
    col_count1 = sorted(col_count.items(), key=lambda d:d[1])

    for i in col_count1:
        dftem = df.loc[df[u'受访者编号'] == i[0]]
        dfenc = dftem.loc[df[u'题型'] == u'编码']
        dfhelp = dftem.loc[df[u'题型'] == u'辅助题']
        # 每个受访者回答编码题和辅助题的数量
        el = dfenc.shape[0]
        hl = dfhelp.shape[0]

        # 设置编码题和辅助题对预测结果所占的权重（只考虑编码/按数量/编码占0.5（其他），辅助题均分）
        '''
        w_e = 1
        w_hl = 0
        '''
        w_e = float(el)/(el+hl)
        w_hl = float(hl)/(el+hl)
        '''
        if 0 == hl:
           w_e = 1
           w_hl = 0
        else:
           w_e = 0.5
           w_hl = 0.5/hl
        '''
        #print (w_e,w_hl)

        eh_ind_topk1 = np.zeros(shape=(1,occ_df1.shape[0]), dtype=np.float64)
        eh_ind_topk2 = np.zeros(shape=(1,occ_df2.shape[0]), dtype=np.float64)
        eh_occ_topk1 = np.zeros(shape=(1,occ_df1.shape[0]), dtype=np.float64)
        eh_occ_topk2 = np.zeros(shape=(1,occ_df2.shape[0]), dtype=np.float64)
        eh_occ_topk3 = np.zeros(shape=(1,occ_df3.shape[0]), dtype=np.float64)
        # 对每一道编码题答案进行预测，结合所有辅助题预测结果，得到最终的预测结果
        for ei in range(dfenc.shape[0]):
            dfenc1 = dfenc.copy()
            dfhelp1 = dfhelp.copy()
            # 编码类型为行业
            if unicode(dfenc.iloc[ei,4]) == u'行业':
                ans = dfenc.iloc[ei,3]
                eh_ind_topk1, eh_ind_topk2 = predict_ind(ans)

                g_main = tf.Graph()
                sess_main = tf.Session(graph=g_main)

                with sess_main.as_default():
                    with g_main.as_default():
                        eh_ind_topk1 = [x*w_e for x in eh_ind_topk1]
                        eh_ind_topk2 = [x*w_e for x in eh_ind_topk2]
                        for hi in range(dfhelp.shape[0]):
                            ans1 = dfhelp.iloc[hi,3]
                            h_topk1, h_topk2 = predict_ind(ans)
                            h_topk1 = [x*w_hl for x in h_topk1]
                            h_topk2 = [x*w_hl for x in h_topk2]
                            eh_ind_topk1 = [eh_ind_topk1[y]+h_topk1[y] for y in range(len(eh_ind_topk1))]
                            eh_ind_topk2 = [eh_ind_topk2[y]+h_topk2[y] for y in range(len(eh_ind_topk2))]

                        topk1_tensor = tf.convert_to_tensor(np.array(eh_ind_topk1))
                        topk2_tensor = tf.convert_to_tensor(np.array(eh_ind_topk2))

                        # 得到各级编码分类的概率向量和索引向量
                        ind_topk1 = tf.nn.top_k(topk1_tensor,ind_df1.shape[0])[0].eval(session=sess_main)
                        ind_index1 = tf.nn.top_k(topk1_tensor,ind_df1.shape[0])[1].eval(session=sess_main)
                        ind_topk2 = tf.nn.top_k(topk2_tensor,ind_df2.shape[0])[0].eval(session=sess_main)
                        ind_index2 = tf.nn.top_k(topk2_tensor,ind_df2.shape[0])[1].eval(session=sess_main)
              
                k1 = 0
                k2 = 0
                pre_code = unicode('0')
                while True:
                    con_encode = opmap_concat1(ind_index1[0][k1], ind_index2[0][k2])
                    if True == judge_encode1(con_encode):
                        print ( u'\'' + unicode(i[0]) + u'\'' + u'的预测编码为：' + unicode (con_encode) )
                        pre_code = unicode(con_encode)
                        break
                    else:
                        if k1+1>=ind_topk1.shape[1] or k2+1>=ind_topk2.shape[1]:
                            print (  u'\'' + unicode(i[0]) + u'\'' + u'的预测编码为：' + unicode('0') )
                            pre_code = unicode('0')
                            break 
                        prob1 = ind_topk1[0][k1+1]*ind_topk2[0][k2]
                        prob2 = ind_topk1[0][k1]*ind_topk2[0][k2+1]
                        prob = [prob1, prob2]
                        indprob = prob.index(max(prob))
                        if 0 == indprob:
                            k1 = k1+1
                        else:
                            k2 = k2+1
                dfenc1.iloc[ei,5] = pre_code
                dfnew = dfnew.append(dfenc1.iloc[ei])

            # 编码类型为职业
            else:
                ans = dfenc.iloc[ei,3]
                eh_occ_topk1, eh_occ_topk2, eh_occ_topk3 = predict_occ(ans)

                g_main1 = tf.Graph()
                sess_main1 = tf.Session(graph=g_main1)

                with sess_main1.as_default():
                    with g_main1.as_default():
                        eh_occ_topk1 = [x*w_e for x in eh_occ_topk1]
                        eh_occ_topk2 = [x*w_e for x in eh_occ_topk2]
                        eh_occ_topk3 = [x*w_e for x in eh_occ_topk3]
                        for hi in range(dfhelp.shape[0]):
                            ans1 = dfhelp.iloc[hi,3]
                            h_topk1, h_topk2, h_topk3 = predict_occ(ans1)
                            h_topk1 = [x*w_hl for x in h_topk1]
                            h_topk2 = [x*w_hl for x in h_topk2]
                            h_topk3 = [x*w_hl for x in h_topk3]
                            eh_occ_topk1 = [eh_occ_topk1[y]+h_topk1[y] for y in range(len(eh_occ_topk1))]
                            eh_occ_topk2 = [eh_occ_topk2[y]+h_topk2[y] for y in range(len(eh_occ_topk2))]
                            eh_occ_topk3 = [eh_occ_topk3[y]+h_topk3[y] for y in range(len(eh_occ_topk3))]

                        topk1_tensor = tf.convert_to_tensor(np.array(eh_occ_topk1))
                        topk2_tensor = tf.convert_to_tensor(np.array(eh_occ_topk2))
                        topk3_tensor = tf.convert_to_tensor(np.array(eh_occ_topk3))

                        # 得到各级编码分类的概率向量和索引向量
                        occ_topk1 = tf.nn.top_k(topk1_tensor,occ_df1.shape[0])[0].eval(session=sess_main1)
                        occ_index1 = tf.nn.top_k(topk1_tensor,occ_df1.shape[0])[1].eval(session=sess_main1)
                        occ_topk2 = tf.nn.top_k(topk2_tensor,occ_df2.shape[0])[0].eval(session=sess_main1)
                        occ_index2 = tf.nn.top_k(topk2_tensor,occ_df2.shape[0])[1].eval(session=sess_main1)
                        occ_topk3 = tf.nn.top_k(topk3_tensor,occ_df3.shape[0])[0].eval(session=sess_main1)
                        occ_index3 = tf.nn.top_k(topk3_tensor,occ_df3.shape[0])[1].eval(session=sess_main1)
                
                k1 = 0
                k2 = 0
                k3 = 0
                pre_code = unicode('0')
                while True:
                    con_encode = opmap_concat2(occ_index1[0][k1], occ_index2[0][k2], occ_index3[0][k3])
                    if True == judge_encode2(con_encode):
                        print ( u'\'' + unicode(i[0]) + u'\'' + u'的预测编码为：' + unicode (con_encode) )
                        pre_code = unicode(con_encode)
                        break
                    else:
                        if k1+1>=occ_topk1.shape[1] or k2+1>=occ_topk2.shape[1] or k3+1>=occ_topk3.shape[1]:
                            print (  u'\'' + unicode(i[0]) + u'\'' + u'的预测编码为：' + unicode('0') )
                            pre_code = unicode('0')
                            break 
                        prob1 = occ_topk1[0][k1+1]*occ_topk2[0][k2]*occ_topk3[0][k3]
                        prob2 = occ_topk1[0][k1]*occ_topk2[0][k2+1]*occ_topk3[0][k3]
                        prob3 = occ_topk1[0][k1]*occ_topk2[0][k2]*occ_topk3[0][k3+1]
                        prob = [prob1, prob2, prob3]
                        occprob = prob.index(max(prob))
                        if 0 == occprob:
                            k1 = k1+1
                        elif 1== occprob:
                            k2 = k2+1
                        else:
                            k3 = k3+1
                dfenc1.iloc[ei,5] = pre_code
                dfnew = dfnew.append(dfenc1.iloc[ei])

        for t in range(dfhelp1.shape[0]):
            dfhelp1.iloc[t,5] = unicode('0')
        dfnew = dfnew.append(dfhelp1)
    # 将结果保存至“predict_result.xlsx”
    dfnew.to_excel('predict_result.xlsx',index=False)
