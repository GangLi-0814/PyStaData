
<font color='red'>本代码提供了一个预先训练好的模型，该模型在 checkpoints/textcnn/ind_sl15_fc1 （行业编码）和 checkpoints/textcnn/occ_sl15_fc1
  下。</font>而本文下面的内容是从数据处理到训练测试的完整运行过程。


## 环境

- Python 2/3
- TensorFlow 1.3以上
- numpy
- scikit-learn
- scipy

## 数据集

北京大学开放研究数据平台获取的（赵, 银霞, 2018, ）“中国某社科调查的职业和行业编码数据”作为数据集;
其中包含两个数据集文件，重命名后为data/dataset1.xlsx和data/dataset2.xlsx;
样本说明和分类类别信息在data/classes.xls中;
对数据集的基本分析结果在data/analysis/下。

## 预处理

`data/helper.py`为数据的预处理工具文件。

- `read_file()`: 读取文件数据;
- `build_vocab()`: 构建词汇表，使用字符级的表示，这一函数会将词汇表存储下来，避免每一次重复处理;
- `read_vocab()`: 读取上一步存储的词汇表，转换为`{词：id}`表示;
- `read_category()`: 读取各级编码与类别号映射，转换为`{类别: id}`表示;
- `read_encode()`: 读取所有完整编码类别，包括0和999999，转换为`{类别: id}`表示;
- `to_words()`: 将一条由id表示的数据重新转换为文字;
- `process_file()`: 将数据集从文字转换为固定长度的id序列表示;
- `batch_iter()`: 为神经网络的训练准备经过shuffle的批次的数据。

- `multi_sub`:替换字符串中多个指定位置为指定字符;
- `is_chinese`:判断是否是中文;
- `is_digit`:判断是否是数字;
- `is_letter`:判断是否是英文字母;
- `getlistnum`:对列表的每个元素进行计数;
- `cut_by_seqlength`:将文本切成固定长度的若干段.

预处理完整过程为（按顺序运行下列文件）：
- cate2cls.py:产生各级编码类别和id的映射关系，并形成文件（在data/mapping/下）。
- loader.py：将原始数据集分为行业和职业数据集;
  对于行业数据，命名为“ind_raw.txt”；对于职业数据，命名为“occ_raw.txt”。
- da_ind.py和da_occ.py：进行数据增强<font color='red'>（第84和85行请填上自己的百度翻译API账号和密码）</font>;
  对于行业数据，分别命名为“ind_da0.txt”和“ind_da.txt”；对于职业数据，分别命名为“occ_da0.txt”和“occ_da.txt”。
- sample_ind.py和sample_occ.py:进行过采样和欠采样，并进行随机抽样，划分训练集、验证集和测试集;
  对于行业数据，分别命名为“ind_train.txt”、“ind_val.txt”和“ind_test.txt”；对于职业数据，分别命名为“occ_train.txt”、“occ_val.txt”和“occ_ test.txt”。
- splitClass.py:将数据集按高位中位和低位进行划分。
  对于行业数据，分别命名为“ind_train34.txt”、“ind_val34.txt”和“ind_test34.txt”（“ind_train56.txt”、“ind_val56.txt”和“ind_test56.txt”）（“ind_train56.txt”、“ind_val56.txt”和“ind_test56.txt”）；对于职业数据，分别命名为“occ_train12.txt”、“occ_val12.txt”和“occ_ test12.txt”（“occ_train34.txt”、“occ_val34.txt”和“occ_ test34.txt”）（“occ_train56.txt”、“occ_val56.txt”和“occ_ test56.txt”）。

## CNN卷积神经网络

### 配置项

CNN可配置的参数如下所示，在`cnn_model.py`中。

```python
class TCNNConfig(object):
    """CNN配置参数"""

    embedding_dim = 64      # 词向量维度
    seq_length = 600        # 序列长度
    num_filters = 128        # 卷积核数目
    kernel_size = 5         # 卷积核尺寸

    hidden_dim = 128        # 全连接层神经元

    dropout_keep_prob = 0.5 # dropout保留比例
    learning_rate = 1e-3    # 学习率

    batch_size = 64         # 每批训练大小
    num_epochs = 10         # 总迭代轮次

    print_per_batch = 100    # 每多少轮输出一次结果
    save_per_batch = 10      # 每多少轮存入tensorboard
```

### CNN模型

具体参看`cnn_model.py`的实现。

大致结构如下：

![images/cnn_architecture](images/cnn_architecture.png)

### 训练与验证

运行 `python train_ind[34/56].py` 或者 `python train_occ[12/34/56].py` 可以开始训练。
如： `python train_ind34.py` 则对行业中间两位预测编码模型进行训练。
对于一次完整的行业和职业编码模型训练，需要进行5次训练。

> 每次修改参数进行新的训练时，可先将checkpoints下对应的occ或ind文件夹改名或保存至别处;
  把tensorboard/textcnn下对应的occ或ind文件夹改名或保存至别处。
  

### 测试

运行 `python test_ind.py` 或者 `python test_occ.py` 在测试集上进行测试。
测试过程包括对各级模型的测试和融合预测编码的测试。

## 预测

为方便预测， 提供了两种模型的预测方法。
运行 `python predict_ind.py arg_ans1[,arg_ans2,arg_ans3...]` 或者 `python predict_occ.py arg_ans1[,arg_ans2,arg_ans3...]`可以对命令行输入的答案进行预测;
运行 `python predict_all.py arg_ans1[,arg_ans2,arg_ans3...]` 可以对命令行输入的文件内容进行预测，文件格式应与原数据集格式一致。如：运行 `python predict_all.py a.xlsx` 预测结果保存在“predict.xlsx”中。

注：本实验基于gaussic的 [gaussic/text-classification-cnn-rnn](https://github.com/gaussic/text-classification-cnn-rnn) 。
