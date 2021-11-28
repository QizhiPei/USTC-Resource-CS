import numpy as np
import nltk
import re
import math
from scipy import sparse
from nltk.corpus import stopwords
from nltk.stem.porter import PorterStemmer
#np.set_printoptions(threshold=np.inf)  # 保证完整输出矩阵
porter_stemmer = PorterStemmer()

path0 = "E:\Web_lab\exp1\\"  # 基础目录
N = 517391
N_item = 1000
word_list = []
stop_words_table = stopwords.words('english')  # 创建英文默认倒排表

def build_stop_words_table():
    # print(stop_words_table)
    # 扩展英文倒排表
    for w in ['!', ',', '.', '?', ':', ';', '<', '>', '@', '[', ']', '(', ')', '-', '\'\'', '--', '*', '$',
              '...', '=', '\'s', '\'t', '|', '%', '..', '&', '#', '`', '``', '\'', '/',
              'subject', 'enron', 'thi', 'need', 'forward', 'would', 'enron.com', 's/enron', 'pleas', 'cc', 'ect',
              'ha', 'wa', 'ani', 'pm', 'ee', 'still', '\'ll', '\'m', '\'re', '\'ve', 'might', 'I',
              'may', 'n\'t', 'ga', 'also', 'hi', 'could', 'want', 'bcc', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
              'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
              '=20', '=09', '=09=09', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9']:
        stop_words_table.append(w)


def tf_idf_normalize(tf_idf_matrix):
    normalize_matrix = np.zeros((N_item, N))
    for col in range(N):  # 计算归一化矩阵
        sum_2 = math.sqrt(np.sum(tf_idf_matrix[:, col] ** 2))
        #tf_idf_matrix[:, col] = tf_idf_matrix[:, col] / sum_2
        if sum_2 != 0:
            normalize_matrix[:, col] = tf_idf_matrix[:, col] / sum_2
    #print(normalize_matrix)
    return normalize_matrix

def compare(input_word_vec, normalize_matrix):
    similarity = {}
    for col in range(N):
        #print(normalize_matrix[:, col])
        #similarity.append(np.inner(normalize_matrix[:, col], input_word_vec))
        similarity[str(col)] = np.inner(normalize_matrix[:, col], input_word_vec)
    #print(similarity)
    result = sorted(similarity.items(), key=lambda item: item[1], reverse=True)[0:10]
    return result

#计算查询词或词组的向量，不用作归一化（归一化后，在最后比较时只是因子不同）
def cal_input_query(query_str):
    vec = np.zeros(N_item)  #创建零向量
    text = nltk.word_tokenize(query_str.lower())
    text1 = []
    for word in text:
        w = porter_stemmer.stem(word)  # 词根化处理
        text1.append(word)
    #print(text1)
    #print(word_list)
    for word in text1:
        if word not in stop_words_table:
            if w in word_list:
                vec[word_list.index(w)] = 1
    #print(vec)
    return vec

def main():
    path_npz = path0 + "output\\tf_idf_matrix.npz"
    path_query = path0 + "input\\semantic_search.txt"
    path_inverted_table = path0 + "output\\inverted_table.txt"
    sparse_matrix = sparse.load_npz(path_npz)
    tf_idf_matrix = sparse_matrix.toarray()
    #print(tf_idf_matrix)

    file_query = open(path_query)
    iter_f = iter(file_query)
    query_str = []  #存放输入的查询词或词组
    for line in iter_f:  # 遍历文件，按行遍历，读取文本，每个文本对应一个字符串
        line = re.sub(r'\n.*$', "", line)
        #w = porter_stemmer.stem(line)  # 词根化处理
        query_str.append(line)
    file_query.close()

    file_inverted_table = open(path_inverted_table)
    iter_f = iter(file_inverted_table)
    for line in iter_f:
        line = re.sub(r'\n.*$', "", line)
        word_list.append(line.split()[0])
    file_inverted_table.close()

    normalize_matrix = tf_idf_normalize(tf_idf_matrix)
    #print(query_str)
    for word in query_str:
        vec = cal_input_query(word)
        if np.sum(vec) == 0:
            print("can not find")
        else:
            result = compare(vec, normalize_matrix)
            print(result)
'''
    for word in query:
        vec = cal_input_query(word)
        #zero_vec = np.zeros(N)
        if np.sum(vec) == 0:
            print("can not find")
        else:
            #print("vec:", vec)
            result = compare(vec, normalize_matrix)
            print(result)
'''


if __name__ == "__main__":
    main()
