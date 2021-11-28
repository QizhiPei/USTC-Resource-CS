from nltk.corpus import stopwords
from nltk.stem.porter import PorterStemmer
from scipy import sparse
import os
import nltk
import re
import operator
import math
import numpy as np
np.set_printoptions(threshold=np.inf)  # 保证完整输出矩阵
porter_stemmer = PorterStemmer()
stop_words_table = stopwords.words('english')  # 创建英文默认倒排表
file_No_dict = []
inverted_table = {}
i = 0
#N = 3034  # 文档总数
#N = 9
N = 517401
N_item = 1000
path0 = "E:\Web_lab\exp1\\"  # 基础目录
tf_idf_matrix = np.zeros((N_item, N))
list_df = []

#@jit(nopython=True)
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


# 利用正则表达式过滤除了主题和正文之外的部分
#@jit(nopython=True)
def filter(line):
    line = re.sub(r'Message-ID.*$', "", line)
    line = re.sub(r'Date.*$', "", line)
    line = re.sub(r'From.*$', "", line)
    line = re.sub(r'To.*$', "", line)
    line = re.sub(r'Mime-Version.*$', "", line)
    line = re.sub(r'Content.*$', "", line)
    line = re.sub(r'X.*$', "", line)
    line = re.sub(r'\t.*$', "", line)
    #line = re.sub(r'[^\s]', "", line)
    return line

# 根据word更新倒排表,倒排表用字典存储，key为词项，value为一个列表
# value[0]为词频（不去重,也就是出现该词项的文档数量）
# value[1]为子列表，为含有该词项的文档（去重）以及该词项在文档中出现的次数
#@jit(nopython=True)
def add_inverted_table(word, freq):
    if word not in inverted_table:
        temp = [1]
        temp.append([i, freq])
        inverted_table[word] = temp
    else:
        inverted_table[word][0] += 1
        #if [i, freq] not in inverted_table[word]:
        inverted_table[word].append([i, freq])


# 根据传入的path处理对应的文件，包含预处理和建立倒排表
#@jit(nopython=True)
def build_invert_list(path):
    global i
    file_No_dict.append(path)  # 建立映射表
    str = ""
    try:
        f = open(path, 'r')
        iter_f = iter(f)
        for line in iter_f:  # 遍历文件，按行遍历，读取文本，每个文本对应一个字符串
            line = filter(line)  # 只读取主题和正文
            str = str + line
    except:
        f.close()
        try:
            f = open(path, 'r', encoding='unicode_escape')
            iter_f = iter(f)
            for line in iter_f:  # 遍历文件，按行遍历，读取文本，每个文本对应一个字符串
                line = filter(line)  # 只读取主题和正文
                str = str + line
        except:
            f.close()
            return 0

    text = nltk.word_tokenize(str.lower())  # 分词，并转化为小写，方便通过停用词表去除
    text1 = []
    for word in text:
        w = porter_stemmer.stem(word)  # 词根化处理
        text1.append(w)
    fdist = nltk.FreqDist(text1)
    # print(text1)
    for word in text1:
        # w = porter_stemmer.stem(word)  # 词根化处理
        if word not in stop_words_table:  # 去停用词处理
            add_inverted_table(word, fdist[word])
    i = i + 1
    if i % 100 == 0:
        print(i)


#@jit(nopython=True)
def file_read1(path):  # path = path0 + "dataset\maildir"
    folders = os.listdir(path)  #列出路径下所有文件和文件夹
    if len(folders) == 0:   #如果当前路径下没有文件和文件夹，返回
        return
    else:
        for folder in folders:
            path1 = path + "\\" + folder
            if os.path.isfile(path1):   #如果是文件，则加入倒排表
                build_invert_list(path1)
            else:
                file_read1(path1)   #如果是文件夹，则递归调用
    return 

    
#@jit(nopython=True)
def write_1000_inverted_table():
    list1 = sorted(inverted_table.items(),
                   key=lambda item: item[1][0], reverse=True)
    #print(list1)
    path_inverted_table = path0 + "output/inverted_table.txt"
    file_inverted_table = open(path_inverted_table, 'w+')
    for j in range(N_item):  
        file_inverted_table.write(list1[j][0] + ' : ')
        del (list1[j][1][0])
        new_list = list1[j][1]
        #new_list = list(set(list1[j][1]))
        #list[j][1] = [5, [1,2], [1,2], [1,2], [2,3]]
        new_list = de_repetition2(new_list)
        #print(new_list)
        for k in range(0, len(new_list)):
            file_inverted_table.write(str(new_list[k][0]) + ' ')
        #for k in range(1, len(list1[j][1])):  
            #file_inverted_table.write(str(list1[j][1][k][0]) + ' ')
        file_inverted_table.write('\n')
    # print(list1[0])
    file_inverted_table.close()
    return list1


def de_repetition2(old_list):
    new_list=[old_list[0]]
    temp = old_list[0][0]
    for i in range(1,len(old_list)):
        if(old_list[i][0]==temp):
            continue
        else:
            new_list.append(old_list[i])
            temp=old_list[i][0]
    return new_list
        
        

#@jit(nopython=True)
def tf_idf_matrix_build(list_sorted):
    #print(list_sorted)
    new_list = []
    for row in range(N_item):
        del (list_sorted[row][1][0])
        new_list.append(de_repetition2(list_sorted[row][1]))
    #print(new_list)
    for row in range(N_item):  # 后续改为1000
        list_df.append(len(new_list[row]))
        for col in range(0, len(list_sorted[row][1]) - 1):
            tf_idf_matrix[row][list_sorted[row][1][col][0]] = (
                1 + math.log10(list_sorted[row][1][col][1])) * math.log10(N / list_df[row])
            # if list_sorted[row][1][col][1] == 0:
            # continue
            # else:
            #tf_idf_matrix[row][list_sorted[row][1][col][0]] = (1 + math.log10(list_sorted[row][1][col][1])) * math.log10(N / list_df[row])
    #print(tf_idf_matrix)
    #print(list_df)
    path_tf_idf_matrix = path0 + "output/tf_idf_matrix.npz"
    compressed_matrix = sparse.csr_matrix(tf_idf_matrix)
    sparse.save_npz(path_tf_idf_matrix, compressed_matrix)


#@jit(nopython=True)
# 建立文件编号到路径的映射表
def file_No_dict_write():
    path_tf_idf_dictionary = path0 + "output/dictionary.txt"
    dictionary = open(path_tf_idf_dictionary, 'w+')
    for map in file_No_dict:
        dictionary.write(str(map) + '\n')
    dictionary.close()


def main():
    build_stop_words_table()
    path_read = path0 + "dataset\maildir"
    #file_read()
    file_read1(path_read)
    list_sorted = write_1000_inverted_table()
    tf_idf_matrix_build(list_sorted)
    file_No_dict_write()


if __name__ == "__main__":
    main()
