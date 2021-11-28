# README

## 源代码运行环境

* Windows 10 家庭版
* Intel(R) Core(TM) i7-8750H CPU @220GHz 2.21GHz
* 16.0GB内存
* x64处理器
* Python 3.8.3 (conda)

## 编译运行方式

* 建立倒排表和tf-idf矩阵：`python build.py`
* 布尔查询：`python bool_search.py`，使用的**相对路径**
* 语义查询：`python semantic_search.py`
* word2vec的语义查询：`python word2vec.py `，使用的**相对路径**
* 读写文件时的**路径问题**可能需要一定调整，实验里除了bool_search.py以及word2vec.py，都用的**绝对路径**，以基础目录path0加exp1下的目录来组成

## 关键函数说明

### bool_search.py

* 利用生成的倒排表做bool查询并在控制台输出满足要求的文档
* `main函数`
  * 读取`exp1/output/inverted_table.txt`并以字典形式存储倒排表。
  * 读取`exp1/input/bool_search.txt`来得到bool查询语句，并调用handle_query() 逐条处理
* `def handle_query(query)`
  * 参数：一条bool查询的字符串
  * 返回值：满足二值匹配的文档序号列表
  * `def exp(querylist)`：读入一个表达式并返回其结果文档列表
  * `def item(querylist) `：读入一个项并返回其结果文档
  * `def factor(querylist)`：读入一个因子并返回其结果文档
  * `def notExp(querylist)`：取反操作
  * 以上四个函数的实现说明参见实验报告对应部分

* `def AND(p1,p2)`
  * 参数：list格式的两个倒排表文档序列
  * 返回值：求交集之后的文档列表
* `def OR(p1,p2)`
  * 参数：list格式的两个倒排表文档序列
  * 返回值：求并集之后的文档列表
* `def NOT(p1)`
  * 参数：list格式的一个倒排表文档序列
  * 返回值：求补集之后的文档列表

### semantic_search.py

* `build_stop_words_table`：对 nltk 的英文停用词表，基于得到的倒排表结果，对停用词表进行人工补充，去除一些没有意义的词
* `tf_idf_normalize(tf_idf_matrix)`：对传入的 tf-idf 矩阵按列进行归一化处理，并返回归一化后的矩阵
* `compare(input_word_vec，normalize_matrix)`：计算传入的查询向量和归一化矩阵中每一列的内积（即**余弦相似度**），并返回内积降序排列前 10 个文档的编号（因为是对同一查询向量与不同文档向量的内积进行比较，故不需要对查询向量基于归一化）
* `cal_input_query(query_str)`：计算查询词或词组的向量（1000维，查询中在前1000个词中出现的词对应权重为1，否则为0），并返回该向量
* `main()`：读取 tf-idf 矩阵以及查询文件`exp1/input/semantic_search.txt`，并对读入的查询文件中的每个查询进行分词、词根化、去停用词处理，并根据得到的归一化矩阵分别计算每次的查询向量与每个文档向量的相似度，输出相似度 top10 的文档 id，如果一次查询中所有查询词都未在前 1000 个词项中出现，则返回`can not find`

### build.py

* `build_stop_words_table`：同 semantic_search.py 中该函数的功能
* `filter(line)`：通过正则表达式对 line 进行过滤，相当于对当前文档按行过滤掉邮件头部信息，保留主题(subject)、文件正文(包含回复邮件的内容)，并返回过滤后的 line
* `add_inverted_table(word，freq)`：根据传入的词项和频率更新倒排表
* `build_invert_list(path)`：根据传入的路径读取当前路径下的文档，该文档会被转化为一个字符串，对该字符串进行分词、词根化处理和去停用词处理后，对文档中的每个词调用 add_inverted_table 将该词更新到倒排表中
* `file_read1(path)`：深度优先搜索，读取路径为 path 的数据集中的所有文件，当读到文件时调用 build_inverted_list
* `write_1000_inverted_table()`：基于词频数对倒排表进行降序排列和一些其他处理后，将前1000行写入文件 `output/inverted_table.txt`，并返回一个有序列表用来建立 tf-idf 矩阵
* `de_repetition2(old_list)`：对 old_list 去重，返回new_list
* `tf_idf_matrix_build(list_sorted)`：根据传入的列表建立建立 tf-idf 矩阵，其中 list_df保存1000个词项的 df 值，原始矩阵中每一项对应 tf 值，根据这两个值计算 tf-idf 矩阵中的每一个项，并将矩阵保存为`exp1/output/tf_idf_matrix.npz`
* `file_No_dict_write()`：建立文件编号到路径的映射表， 保存在文件`exp1/output/dictionary.txt`
* `main()`：主控函数，依次调用各个函数实现预处理、建立倒排表、建立 tf-idf 矩阵的工作

### word2vec.py

* 用预处理后的文档集合`exp1/output/word2vec_data.txt`作为语料进行word2vec语言模型训练。用训练好的模型，以`exp1/input/semantic_search.txt`作为语义查询语句，并返回与每次查询相似度最高的十个文档
* 因为已经把模型训练出来了，所以word2vec.py中训练部分的代码已经注释掉了。
* 用到的python包：`gensim`和`word2vec`

### file_write.py

* 建立`word2vec.py`所需要的训练集文件`exp1/output/word2vec_data.txt`



## 文件说明

### src文件夹

* 各个python文件说明见  关键函数说明  一节

### input 文件夹

#### bool_search.txt

* 格式：每一行为一个正确的bool查询语句，与ppt所示一致，但注意括号也算一个单独的词，需左右有空格

  ```
  power AND NOT energy
  NOT contact AND power OR price
  ( contact OR power ) AND ( price OR market )
  issue AND contact AND price
  contact OR power OR price
  ```

* 选取的词语

  power，energy，contact，price，issue

* 注意三个逻辑运算符的运算优先级

  `NOT > AND > OR`

#### semantic_search.txt

* 格式：每一行为一个正确的语义查询语句，需左右有空格

* 选取的词语：

  power contact，business，offer，financial，issues

  

### output 文件夹

#### inverted_table.txt

* 建立好的倒排表，每一行代表一个词项及其所在的文档id，其格式为

  > word : id1 id2 id3 

#### tf_idf_matrix.npz

* 建立好的 tf-idf 矩阵，并采用`scipy.sparse.save_npz`，对原稀疏矩阵进行压缩存储得到的`.npz`文件

#### dictionary.txt

* 文档号到文档路径的映射表，其中行号即为文档 id，每一行代表一个映射。
* 注意：三个查询文件中输出的文档号从 0 开始编号，而 dictionary.txt 中行号是从 1 开始的，故在映射前要将得到的文档 id 加一，来寻找对应的行中的路径

#### word2vec_data.txt

* 训练模型用到的训练集
* 格式：通过分词、词根化以及去停用词后，把每个文档的词按空格隔开，写入`output/word2vec_data.txt`（每个文档中的词占一行）

#### word2vec.model

* 训练得到的模型

### other文件夹-实验报告中用到的例子

#### tf_idf_matrix.npz

* 基于3034个文件生成的矩阵

#### tf_idf_matrix.txt

* 基于3034个文件生成的矩阵

