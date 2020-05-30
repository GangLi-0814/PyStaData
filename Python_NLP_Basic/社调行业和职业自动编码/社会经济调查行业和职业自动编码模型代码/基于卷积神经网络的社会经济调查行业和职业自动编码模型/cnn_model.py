# coding: utf-8

import tensorflow as tf


class TCNNConfig(object):
    """CNN配置参数"""

    embedding_dim = 64  # 词向量维度
    seq_length = 15  # 序列长度
    num_filters = 256  # 卷积核数目
    kernel_size = 5  # 卷积核尺寸
    hidden_dim = 128  # 全连接层神经元
    dropout_keep_prob = 0.5  # dropout保留比例
    learning_rate = 1e-3  # 学习率
    batch_size = 64  # 每批训练大小
    num_epochs = 15  # 总迭代轮次
    print_per_batch = 100  # 每多少轮输出一次结果
    save_per_batch = 10  # 每多少轮存入tensorboard
 
   

    def __init__(self, num_class, vocab_size):
        self.num_class = num_class  # 类别数   
        self.vocab_size = vocab_size  # 词汇表大小



class TextCNN(object):
    """文本分类，CNN模型"""

    def __init__(self, config):
        self.config = config
        
        # 三个待输入的数据
        self.input_x = tf.placeholder(tf.int32, [None, self.config.seq_length], name='input_x')
        self.input_y = tf.placeholder(tf.float32, [None, self.config.num_class], name='input_y')
        self.keep_prob = tf.placeholder(tf.float32, name='keep_prob')

        self.cnn()



    def cnn(self):
        """CNN模型"""
        # 词向量映射
        with tf.device('/cpu:0'):   
            embedding = tf.get_variable('embedding', [self.config.vocab_size, self.config.embedding_dim])
            embedding_inputs = tf.nn.embedding_lookup(embedding, self.input_x)

        with tf.name_scope("cnn"):
            # CNN layer
            conv = tf.layers.conv1d(embedding_inputs, self.config.num_filters, self.config.kernel_size, name='conv')
            # global max pooling layer
            gmp = tf.reduce_max(conv, reduction_indices=[1], name='gmp')

        with tf.name_scope("score"):
            # 全连接层，后面接dropout以及relu激活
            #fc00 = tf.layers.dense(gmp, self.config.hidden_dim)
            #fc01 = tf.layers.dense(fc00, self.config.hidden_dim)
            #fc02 = tf.layers.dense(fc01, self.config.hidden_dim)
            #fc03 = tf.layers.dense(fc02, self.config.hidden_dim)
            #fc = tf.layers.dense(fc03, self.config.hidden_dim, name='fc1')

            #fc00 = tf.layers.dense(gmp, self.config.hidden_dim)
            #fc01 = tf.layers.dense(fc00, self.config.hidden_dim)
            #fc = tf.layers.dense(fc01, self.config.hidden_dim, name='fc1')

            fc = tf.layers.dense(gmp, self.config.hidden_dim, name='fc1')
            fc = tf.nn.dropout(fc, self.keep_prob)
            fc = tf.nn.relu(fc)

            # 分类器
            self.logits = tf.layers.dense(fc, self.config.num_class, name='fc2')
            self.y_pred_cls = tf.argmax(tf.nn.softmax(self.logits), 1,name='y_pred_cls')  # 预测类别

        with tf.name_scope("optimize"):
            # 损失函数，交叉熵
            cross_entropy = tf.nn.softmax_cross_entropy_with_logits(logits=self.logits, labels=self.input_y)
            #cross_entropy = tf.nn.weighted_cross_entropy_with_logits(logits=self.logits, targets=self.input_y, pos_weight=2.0)
            self.loss = tf.reduce_mean(cross_entropy)
            # 优化器
            self.optim = tf.train.AdamOptimizer(learning_rate=self.config.learning_rate).minimize(self.loss)

        with tf.name_scope("accuracy"):
            # 准确率
            correct_pred = tf.equal(tf.argmax(self.input_y, 1), self.y_pred_cls)
            self.acc = tf.reduce_mean(tf.cast(correct_pred, tf.float32))
