import numpy as np
from numpy import random
import Sorec
from scipy.sparse import coo_matrix
from scipy.sparse import csr_matrix
import copy
import math
from tqdm import tqdm

user_id_map = {}
item_id_map = {}
user_map = 0
item_map = 0

def sigmoid(x):
    return 1.0/(1.0+np.exp(-x))

def get_trust_data(filename="../data/relation.txt",theshape=(2185,2185)):
    global user_map,user_id_map
    f = open(filename)
    lines = f.readlines()
    f.close()
    row = []
    col = []
    data = []
    for line in tqdm(lines):
        alist = line.strip('\n').split(",")#被关注人列表
        temp = alist[0].split(":")
        luser = temp[0] #关注人
        alist[0]=temp[1] 
        if luser not in user_id_map:
            user_id_map[luser] = user_map
            user_map += 1
        for ruser in alist:
            if ruser not in user_id_map:
                user_id_map[ruser] = user_map
                user_map += 1
            row.append(int(user_id_map[luser]))
            col.append(int(user_id_map[ruser]))
            data.append(1.0)

    print("user_id_map length：")
    print(len(user_id_map))

    mtx = coo_matrix((data, (row, col)), shape=theshape) #稀疏矩阵
    indeg = mtx.sum(axis=0)
    outdeg = mtx.sum(axis=1)
    factor = copy.deepcopy(mtx)
    for k in range(factor.data.shape[0]):
        i = factor.row[k]
        j = factor.col[k]
        factor.data[k] = math.sqrt(indeg[0, j]/(indeg[0,j]+outdeg[i, 0]))
    return csr_matrix(factor)#压缩矩阵

def get_ratings_data(filename="../data/training.dat",theshape=(2185,58431)):
    global user_map,item_map,user_id_map,item_id_map
    f = open(filename,"r",encoding='utf-8')
    train_data = []
    train_row = []
    train_col = []
    vali_data = []
    vali_row = []
    vali_col = []
    lines = f.readlines()
    f.close()

    random.shuffle(lines)#把数据随机打乱
    ind = -1
    pos = int(len(lines)*0.99) #按 99:1切分训练集和测试集

    for line in tqdm(lines):
        ind += 1
        alist = line.strip('\n').split(",")
        if alist[0] not in user_id_map:
            user_id_map[alist[0]] = user_map
            user_map += 1
        if alist[1] not in item_id_map:
            item_id_map[alist[1]] = item_map
            item_map += 1
        if ind>=pos:
            vali_row.append(user_id_map[alist[0]])
            vali_col.append(item_id_map[alist[1]])
            vali_data.append(int(alist[2])+1)
            continue
        train_row.append(user_id_map[alist[0]])
        train_col.append(item_id_map[alist[1]])
        train_data.append(int(alist[2])+1)

    print("user_id_map length：")
    print(len(user_id_map))

    print("item_id_map length：")
    print(len(item_id_map))

    train_mtx = csr_matrix((train_data, (train_row,train_col)), shape=theshape, dtype='float64')
    vali_mtx = csr_matrix((vali_data, (vali_row, vali_col)), shape=theshape, dtype='float64')
    return train_mtx, vali_mtx

def predict(U,V):
    global user_id_map,item_id_map
    R = U.T * V
    print("R shape:")
    print(R.shape)
    pred = []
    pred_f = []
    with open("../data/testing.dat","r",encoding='utf-8') as f:
        for line in f.readlines():
            line_data=line.strip().split(",")
            ratings = 5* sigmoid(R[user_id_map[line_data[0]],item_id_map[line_data[1]]])
            pred.append(int(round(ratings)))
            pred_f.append(ratings)
    with open("../result/雷雨轩_PB18111791_7.txt","w") as f:
        for ratings in pred:
            f.write(str(ratings)+"\n")
    with open("../result/7_float.txt","w") as f:
        for ratings in pred_f:
            f.write(str(ratings)+"\n")

if __name__ == '__main__':
    print("loading data...")
    trust_data = get_trust_data()
    # train set and validae set
    ratings_data_train, ratings_data_validate = get_ratings_data()
    print("loading done...")
    print("begin to train...")
    socmodel = Sorec.MF(ratings_data_train, ratings_data_validate, trust_data, lr=0.01, momentum=0.5, latent_size=10,iters=130)
    U,V,Z,train_loss_list, validate_loss_list = socmodel.train()
    print("train done...")
    print("predict begin...")
    predict(U,V)
