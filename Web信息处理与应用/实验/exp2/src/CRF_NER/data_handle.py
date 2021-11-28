from nltk.corpus import stopwords
from nltk.stem.porter import PorterStemmer
from scipy import sparse
import os
import nltk
import re
import operator
import math
import numpy as np


porter_stemmer = PorterStemmer()
stop_words_table = stopwords.words('english')  # 创建英文默认倒排表


TRAIN_DATA_PATH = "./data/origin/train.txt"
TRAIN_changed_DATA_PATH="./data/train.txt"
TEST_DATA_PATH  = "./data/origin/test.txt"
TEST_changed_DATA_PATH="./data/test.txt"
TRAIN_SIZE = 6400
TEST_SIZE = 1600

#target_names = ['Cause-Effect', 'Component-Whole', 'Entity-Destination', 'Product-Producer', 'Entity-Origin',
  #              'Member-Collection', 'Message-Topic', 'Content-Container', 'Instrument-Agency', 'Other']

target_names=['1']

def build_stop_words_table():
    # print(stop_words_table)
    for w in ['!', ',', '.', '?', ':', ';', '<', '>', '@', '[', ']', '(', ')', '-', '\'\'', '--', '*', '$',
              '...', '=', '\'s', '\'t', '|', '%', '..', '&', '#', '`', '``',]:
        stop_words_table.append(w)

# handle train data
def handle_train_data():
    count=0
    with open(TRAIN_DATA_PATH) as f:
        with open(TRAIN_changed_DATA_PATH,"w") as write_f:
            while count < TRAIN_SIZE:
                sentence = []#句子分词结果
                prop=[]#词性标注
                label=[]#序列标注

                temp=f.readline().split('"')[1]
                temp=nltk.word_tokenize(temp)#分词

                for word in temp:
                    #w = porter_stemmer.stem(word)  # 词根化处理
                    if word not in stop_words_table:#去停用词
                        sentence.append(word)

                temp1=re.split(r'[(,)]',f.readline())
                relation=temp1[0]
                #e1=[porter_stemmer.stem(word) for word in temp1[1].split(" ")]
                e1=temp1[1].split(" ")
                #e2=[porter_stemmer.stem(word) for word in temp1[2].split(" ")]
                e2=temp1[2].split(" ")
                length=len(sentence)
                i=0
                while i < length:
                    if sentence[i] in e1:
                        #label.append("B-e1-"+relation)
                        label.append(("B-1"))
                        i+=1
                        while i<length and sentence[i] in e1:
                            #label.append("I-e1-"+relation)
                            label.append("I-1")
                            i+=1
                    elif sentence[i] in e2:
                        #label.append("B-e2-"+relation)
                        label.append("B-1")
                        i+=1
                        while i<length and sentence[i] in e2:
                            #label.append("I-e2-"+relation)
                            label.append(("I-1"))
                            i+=1
                    else:
                        label.append("O")
                        i+=1

                prop=nltk.pos_tag(sentence)#词性标注


                if(len(sentence)!=len(prop)):
                    exit("prop error")
                elif(len(sentence)!=len(label)):
                    exit("label error")

                for word in sentence:
                    write_f.write(word+" ")
                write_f.write("\n")
                for pro in prop:
                    write_f.write(pro[1]+" ")
                write_f.write("\n")
                for lab in label:
                    write_f.write(lab+" ")
                write_f.write("\n")
            
                count+=1
            #train_data.append()
            #train_target.append(target_names.index(f.readline().split('(')[0]))

#handle test data
def handle_test_data():
    count=0
    with open(TEST_DATA_PATH) as f:
        with open(TEST_changed_DATA_PATH,"w") as write_f:
            while count < TEST_SIZE:
                sentence = []#句子分词结果
                prop=[]#词性标注
                temp=f.readline().split('"')[1]
                temp=nltk.word_tokenize(temp)#分词

                for word in temp:
                    #w = porter_stemmer.stem(word)  # 词根化处理
                    if word not in stop_words_table:#去停用词
                        sentence.append(word)
                
                prop=nltk.pos_tag(sentence)#词性标注

                for word in sentence:
                    write_f.write(word+" ")
                write_f.write("\n")
                for pro in prop:
                    write_f.write(pro[1]+" ")
                write_f.write("\n")
                for i in range(0,len(sentence)):
                    write_f.write("O ")
                write_f.write("\n")
                count+=1


def main():
    build_stop_words_table()
    handle_train_data()
    handle_test_data()


if __name__=='__main__':
    main()