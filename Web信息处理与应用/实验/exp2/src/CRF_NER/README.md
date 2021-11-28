##### 依赖

* nltk
* scipy
* numpy
* sklearn-crfsuite=0.3.6
* pandas=0.24.2
* sklearn.externals
*  scikit-learn=0.21.2

运行：

* python data_handle.py
* python train.py

##### 代码说明

###### `data_handle.py`

* 功能：处理实验原始训练集(`\data\origin\train.txt`)和测试集(`\data\origin\test.txt`),生成做了词性标注以及实体序列标注的数据集

* `def build_stop_words_table()`

  利用ntlk库建立倒排表，并把一些标点符号等添加进倒排表

* `def handle_train_data()`

  处理原始训练集，考虑到实体标签的稀疏性(每个句子一般只有两个实体)，所以若再按照实验所给10种关系细化时，效果会很差，所以统一看为一种实体，并利用BIO序列标注格式，非实体为`O`, 实体开头为`B-1`,实体中间部分为`I-1`.

  首先利用nltk库对每个句子分词、去停用词，考虑到测试网站最后需要输出实体单词，词根化处理会有影响，所以未做词根化处理。

  其次利用`nltk.pos_tag()`对每个词作词性标注

  最后通过对数据集的遍历，对训练集中每个句子对应的实体打上标签。

  ```markdown
  //前两个句子的处理后效果
  The system described greatest application arrayed configuration antenna elements 
  DT NN VBD JJS NN VBN NN NN NNS 
  O O O O O O B-1 O B-1 
  The child carefully wrapped bound cradle means cord 
  DT NN RB VBD IN NN VBZ NN 
  O B-1 O O O B-1 O O 
  ```

* `def handle_test_data()`

  处理方式与训练集差不多，唯一区别在于，因为不知道测试集里每句话的实体，所以统一打上标记`O`占位，以便于后序数据格式的统一。

###### `train.py`

* 读取处理后的数据，生成dataframe格式，收集特征并训练，最后把测试集结果输出。

* `def read_from_file()`

  读取经过data_handle.py处理后的训练集数据和测试集数据，存放为pandas库的dataframe格式，`columns=['Word', 'Pos', 'Tag', 'Sent_no']`

* `def wordfeature(sent,i)`

  * 返回句子sent里第i个词的特征
  * 每个词的特征包括 该词的大小写情况、是否为数字，以及改词的前一个词、后一个词的相应特征
  * 以字典形式返回该词的特征

* `def sentfeature(sent)`

  以列表格式返回句子每个词的特征

* `def sentlabel(sent)`

  以列表格式返回一个句子的标注序列

* `class SentenceGetter(object)`

  一个句子迭代器的类，用来迭代返回数据中的句子

  `self.sentences`属性以列表形式存放每个句子，句子里每个单词以三元组格式存放"Word","Pos","Tag"标签数据

* `def train(train_X,train_y)`

  用sklearn_crfsuite库的CRF模型训练，并利用cross_val_predict做k折交叉验证来做泛化效果预测。

* `def predict(test_X,sentences)`

  加载训练好的模型并对测试集预测，结果存放到`./submit/crf-output.txt`，格式为每行一个单词及其预测的标记（空格隔开）。句子间以一个空行隔开。

