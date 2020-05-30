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
from data.helper import read_vocab, read_cate, batch_iter, process_file, build_vocab



'''mid2'''
# 行业字典路径
base_dir = 'data/'
ind_base_dir = 'data/ind/'
ind_vocab_dir = os.path.join(base_dir, 'ind_vocab.txt')

# 行业训练集,验证集
train_dir = os.path.join(ind_base_dir, 'ind_train_34.txt')
val_dir = os.path.join(ind_base_dir, 'ind_val_34.txt')
ind_train_dir = 'data/ind/ind_train.txt'

# 最佳验证结果保存路径
save_dir = 'checkpoints/textcnn/ind'
save_path = os.path.join(save_dir, 'best_validation_ind_34')



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


def train():
    '''
    对行业34位预测编码模型进行训练
    '''
    print("Configuring TensorBoard and Saver...")

    # 配置 Tensorboard
    tensorboard_dir = 'tensorboard/textcnn/ind_34'
    if not os.path.exists(tensorboard_dir):
        os.makedirs(tensorboard_dir)

    tf.summary.scalar("loss", model.loss)
    tf.summary.scalar("accuracy", model.acc)
    merged_summary = tf.summary.merge_all()
    writer = tf.summary.FileWriter(tensorboard_dir)

    # 配置 Saver
    saver = tf.train.Saver()
    if not os.path.exists(save_dir):
        os.makedirs(save_dir)

    print("Loading training and validation data...")
    # 载入训练集与验证集
    start_time = time.time()
    x_train, y_train = process_file(train_dir, word_to_id, ind_df1, config.seq_length)
    x_val, y_val = process_file(val_dir, word_to_id, ind_df1, config.seq_length)
    time_dif = get_time_dif(start_time)
    print("Time usage:", time_dif)

    # 创建session
    session = tf.Session()
    session.run(tf.global_variables_initializer())
    writer.add_graph(session.graph)

    print('Training and evaluating...')
    start_time = time.time()
    total_batch = 0  # 总批次
    best_acc_val = 0.0  # 最佳验证集准确率
    last_improved = 0  # 记录上一次提升批次
    require_improvement = 1000  # 如果超过1000轮未提升，提前结束训练

    flag = False
    for epoch in range(config.num_epochs):
        print('Epoch:', epoch + 1)
        batch_train = batch_iter(x_train, y_train, config.batch_size)
        for x_batch, y_batch in batch_train:
            feed_dict = feed_data(x_batch, y_batch, config.dropout_keep_prob)

            if total_batch % config.save_per_batch == 0:
                # 每多少轮次将训练结果写入tensorboard scalar
                s = session.run(merged_summary, feed_dict=feed_dict)
                writer.add_summary(s, total_batch)

            if total_batch % config.print_per_batch == 0:
                # 每多少轮次输出在训练集和验证集上的性能
                feed_dict[model.keep_prob] = 1.0
                loss_train, acc_train = session.run([model.loss, model.acc], feed_dict=feed_dict)
                loss_val, acc_val = evaluate(session, x_val, y_val)  # todo

                if acc_val > best_acc_val:
                    # 保存最好结果
                    best_acc_val = acc_val
                    last_improved = total_batch
                    saver.save(sess=session, save_path=save_path)
                    improved_str = '*'
                else:
                    improved_str = ''

                time_dif = get_time_dif(start_time)
                msg = 'Iter: {0:>6}, Train Loss: {1:>6.2}, Train Acc: {2:>7.2%},' \
                      + ' Val Loss: {3:>6.2}, Val Acc: {4:>7.2%}, Time: {5} {6}'
                print(msg.format(total_batch, loss_train, acc_train, loss_val, acc_val, time_dif, improved_str))

            session.run(model.optim, feed_dict=feed_dict)  # 运行优化
            total_batch += 1

            if total_batch - last_improved > require_improvement:
                # 验证集正确率长期不提升，提前结束训练
                print("No optimization for a long time, auto-stopping...")
                flag = True
                break  # 跳出循环
        if flag:  # 同上
            break

    

if __name__ == '__main__':
    print('Configuring CNN model...')
    occ_df1, occ_df2, occ_df3, ind_df1, ind_df2 = read_cate()
    if not os.path.exists(ind_vocab_dir):  # 如果不存在词汇表，重建
        build_vocab(ind_train_dir, ind_vocab_dir, 2500)
    words, word_to_id = read_vocab(ind_vocab_dir)
    vocab_size = len(words)

    config = TCNNConfig(ind_df1.shape[0], vocab_size)  # mid
    model = TextCNN(config)

    train()
