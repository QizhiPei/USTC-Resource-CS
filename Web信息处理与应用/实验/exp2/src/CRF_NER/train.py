from sklearn_crfsuite import CRF
from sklearn.externals import joblib
#import joblib
from sklearn.model_selection import cross_val_predict
from sklearn_crfsuite.metrics import flat_classification_report
import os
import pandas as pd
import numpy as np

def read_from_file(file_path:str):
    text_data=[]
    with open(file_path, 'r') as f:
        temp_text_data = [text.strip() for text in f.readlines()]
    #print(len(temp_text_data))
    for k in range(0, len(temp_text_data)):
        temp=temp_text_data[k].split(' ')
        text_data.append(temp[0:len(temp)])#二维列表，每一个子列表是一行的分词
    #text_data = [text_data[k].split('  ') ]
    #print(text_data[0])
    index = range(0, len(text_data)+3, 3)

    # Transforming data to matrix format for neural network
    input_data = list()
    for i in range(1, len(index)):
        rows = text_data[index[i-1]:index[i]]
        sentence_no = np.array([i]*len(rows[0]), dtype=int)
        rows.append(sentence_no)
        rows = np.array(rows).T
        #for j in range(0,np.size(rows,0)):
            #rows[j][3]=int(rows[j][3])
        input_data.append(rows)



    input_data = pd.DataFrame(np.concatenate([item for item in input_data]),\
                               columns=['Word', 'Pos', 'Tag', 'Sent_no'])

    input_data['Sent_no']=pd.to_numeric(input_data['Sent_no'])
    #print(input_data.head(10))
    return input_data


class SentenceGetter(object):
    def __init__(self,data):
        self.n_sent = 1
        self.data = data
        self.empty=False
        agg_func = lambda s:[(w,p,t) for w,p,t in zip(s["Word"].values.tolist(),
                                                    s["Pos"].values.tolist(),
                                                    s["Tag"].values.tolist())]
        self.grouped=self.data.groupby("Sent_no").apply(agg_func)
        self.sentences = [s for s in self.grouped]

    def get_next(self):
        try:
            s=self.grouped[self.n_sent]
            self.n_sent+=1
            return s
        except :
            return None


def wordfeature(sent,i):
    word=sent[i][0]
    postag=sent[i][1]

    features={
        'word.lower()':word.lower(),
        'word.isupper()':word.isupper(),
        'word.istitle()':word.istitle(),
        'word.isdigit()':word.isdigit(),
        'postag':postag,
    }
    if i>0:#前一个词
        word1 = sent[i-1][0]
        postag1 = sent[i-1][1]
        features.update({
        '-1:word.lower()':word1.lower(),
        '-1:word.istitle()':word1.istitle(),
        '-1:word.isupper()':word1.isupper(),
        #'-1:word.isdigit()':word1.isdigit(),
        '-1:postag':postag1,
        })
    else:
        features['BOS']=True
    
    if i < len(sent)-1:#后一个词
        word1 = sent[i+1][0]
        postag1 = sent[i+1][1]
        features.update({
        '+1:word.lower()':word1.lower(),
        '+1:word.istitle()':word1.istitle(),
        '+1:word.isupper()':word1.isupper(),
        #'+1:word.isdigit()':word1.isdigit(),
        '+1:postag':postag1,
        })
    else:
        features['EOS']=True
    return features


def sentfeature(sent):
    return [wordfeature(sent,i) for i in range(len(sent))]

def sentlabel(sent):
    return [label for token,postag,label in sent]


def train(train_X,train_y):
    crf = CRF(algorithm="lbfgs",
                c1=0.1,#7
                c2=0.1,#0.05
                max_iterations=200,
                all_possible_transitions=True)
    
    pred=cross_val_predict(estimator=crf,X=train_X,y=train_y,cv=4)

    report = flat_classification_report(y_pred=pred,y_true=train_y)
    
    crf.fit(train_X,train_y)

    print(report)
    if not os.path.exists('./temp/models'):
        os.makedirs('./temp/models')
    joblib.dump(crf,"./temp/models/crf.pkl")

def test(test_X,test_y,sentences):
    crf=joblib.load(filename='./temp/models/crf.pkl')

    pred=crf.predict(test_X)
    report = flat_classification_report(y_pred=pred,y_true=test_y)
    print(report)

    f_out="./submit/crf-output.txt"
    with open(f_out,"w") as f:
        for s,s_pred in zip(sentences,pred):
            for w,p in zip(s,s_pred):
                f.write("{}\t{}\t{}\n".format(w[0],w[2],p))

def predict(test_X,sentences):
    crf=joblib.load(filename='./temp/models/crf.pkl')

    pred=crf.predict(test_X)
    f_out="./submit/crf-output.txt"
    with open(f_out,"w") as f:
        for s,s_pred in zip(sentences,pred):
            for w,p in zip(s,s_pred):
                f.write("{} {}\n".format(w[0],p))
            f.write("\n")


train_data_dir="./data/train.txt"
test_data_dir="./data/test.txt"

train_data = read_from_file(train_data_dir)
test_data = read_from_file(test_data_dir)

getter = SentenceGetter(train_data)
sentences = getter.sentences
X = [sentfeature(s) for s in sentences]
y = [sentlabel(s) for s in sentences]
#print(X[0])
#print(y[0])

test_getter = SentenceGetter(test_data)
test_sentences = test_getter.sentences
test_X = [sentfeature(s) for s in test_sentences]
test_y = [sentlabel(s) for s in test_sentences]


print(test_X[0])
train(X,y)
#test(test_X,test_y,test_sentences)
predict(test_X,test_sentences)

