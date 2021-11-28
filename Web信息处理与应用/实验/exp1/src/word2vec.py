# 加载包
from gensim.models import Word2Vec
from gensim.models.word2vec import LineSentence
from nltk.corpus import stopwords
from nltk.stem.porter import PorterStemmer


porter_stemmer = PorterStemmer()

'''
#训练
sentences = LineSentence("../output/word2vec_data.txt")
model = Word2Vec(sentences, size=100,window=5,min_count=1,workers=10,max_vocab_size=None)  # 执行这一句的时候就是在训练模型了
model.save("../output/word2vec.model")
print("succeed")
'''

model = Word2Vec.load("../output/word2vec.model")
with open("../input/semantic_search.txt") as file:
    for line in file.readlines():
        line=line.strip().split(" ")
        for i in range(len(line)):
            line[i]=porter_stemmer.stem(line[i])
        print(line)

        with open("../output/word2vec_data.txt") as f:
            result={}
            i=0
            for doc in f.readlines():
                if doc.strip() == "":
                    result[i]=0
                    i+=1
                    continue
                doc=doc.strip().split(" ")
                #print(doc)
                result[i]=model.wv.n_similarity(line,doc)
                i+=1
        answer=sorted(result.items(), key=lambda d: d[1], reverse=True)#按相似度降序排列
        print(answer[0:10])#前十个相似度最高的