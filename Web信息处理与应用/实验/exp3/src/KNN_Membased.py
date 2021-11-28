import pandas as pd

from surprise import Dataset
from surprise import Reader
from surprise import SVD
from surprise import KNNWithMeans,KNNWithZScore,KNNBaseline,KNNBasic
from surprise import accuracy
from surprise.model_selection import KFold
#from surprise import  print_perf
from surprise.model_selection import cross_validate

# Creation of the dataframe. Column names are irrelevant.
ratings_dict = {'userID': [],
                'itemID': [],
                'rating': [],
                'timestamp': [],
                'tags':[]}


with open("./data/training.dat","r",encoding='utf-8') as f:
    for line in f.readlines():
        line_data=line.strip().split(",")
        length = len(line_data)
        ratings_dict['userID'].append(line_data[0])
        ratings_dict['itemID'].append(line_data[1])
        ratings_dict['rating'].append(int(line_data[2]))
        ratings_dict['timestamp'].append(line_data[3])
        tags=[]
        for i in range(4,length):
            tags.append(line_data[i])
        ratings_dict['tags'].append(tags)

df_train = pd.DataFrame(ratings_dict)
#print(df.head(10))
# A reader is still needed but only the rating_scale param is requiered.
reader = Reader(rating_scale=(0, 5))

# The columns must correspond to user id, item id and ratings (in that order).
data_train = Dataset.load_from_df(df_train[['userID', 'itemID', 'rating']], reader)

sim_options1 = {'name': 'pearson_baseline',
               'user_based': True,
               'min_support ': 3,
               'shrinkage': 100
               }

sim_options2 = {'name': 'pearson',
                'user_based': True,
                'min_support ': 1,
                }

bsl_options_SGD = {'method': 'sgd',
               'learning_rate': .00005,
               'n_epochs': 20
               }

bsl_options_ALS = {'method': 'als',
               'n_epochs': 5,
               'reg_u': 12,
               'reg_i': 5
               }

#algo = KNNWithMeans(k=40, min_k=1, sim_options=sim_options, verbose=True)
algo1 = KNNBaseline(k=40, min_k=1, sim_options=sim_options1,bsl_options=bsl_options_ALS, verbose=True)
algo1.fit(data_train.build_full_trainset())

algo2 = KNNWithZScore(k=40, min_k=1, sim_options=sim_options1, verbose=True)
algo2.fit(data_train.build_full_trainset())

algo3 = KNNWithMeans(k=40, min_k=1, sim_options=sim_options2, verbose=True)
algo3.fit(data_train.build_full_trainset())

pred1 = []
pred_f1 = []
pred2 = []
pred_f2 = []
pred3 = []
pred_f3 = []
with open("./data/testing.dat","r",encoding='utf-8') as f:
    for line in f.readlines():
        line_data=line.strip().split(",")
        a = algo1.predict(str(line_data[0]),str(line_data[1]),None,True,True)[3]
        b = algo2.predict(str(line_data[0]),str(line_data[1]),None,True,True)[3]
        c = algo3.predict(str(line_data[0]),str(line_data[1]),None,True,True)[3]
        pred1.append(int(round(a)))
        pred_f1.append(a)
        pred2.append(int(round(b)))
        pred_f2.append(b)
        pred3.append(int(round(c)))
        pred_f3.append(c)


with open("./雷雨轩_PB18111791_4.txt","w") as f:
    for ratings in pred1:
        f.write(str(ratings)+"\n")

with open("./4_float.txt","w") as f:
    for ratings in pred_f1:
        f.write(str(ratings)+"\n")

with open("./雷雨轩_PB18111791_5.txt","w") as f:
    for ratings in pred2:
        f.write(str(ratings)+"\n")

with open("./5_float.txt","w") as f:
    for ratings in pred_f2:
        f.write(str(ratings)+"\n")

with open("./雷雨轩_PB18111791_6.txt","w") as f:
    for ratings in pred3:
        f.write(str(ratings)+"\n")

with open("./6_float.txt","w") as f:
    for ratings in pred_f3:
        f.write(str(ratings)+"\n")
