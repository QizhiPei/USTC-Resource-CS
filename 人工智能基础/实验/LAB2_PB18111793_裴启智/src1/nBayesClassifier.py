import numpy as np
import math
from collections import Counter
from process_data import load_and_process_data
from evaluation import get_micro_F1,get_macro_F1,get_acc

class NaiveBayes:
    '''参数初始化
    Pc: P(c) 每个类别c的概率分布
    Pxc: P(c|x) 每个特征的条件概率
    '''
    def __init__(self):
        self.Pc={}
        self.Pxc = {}

    '''
    通过训练集计算先验概率分布p(c)和条件概率分布p(x|c)
    建议全部取log，避免相乘为0
    '''
    def fit(self,traindata,trainlabel,featuretype):
        '''
        需要你实现的部分
        '''
        self.X_mean = {}
        self.X_var = {}
        self.Dc = {1: 0, 2: 0, 3:0}
        self.Dcx = {(1,1): 0, (1,2): 0, (1,3): 0, (2,1): 0, (2,2): 0, (2,3): 0, (3,1): 0, (3,2): 0, (3, 3): 0}

        for data, label in zip(traindata, trainlabel):
            if label[0] == 1:
                self.Dc[1] += 1
                # M
                if data[0] == 1:
                    self.Dcx[(1,1)] += 1
                # F
                elif data[0] == 2:
                    self.Dcx[(1,2)] += 1
                # I
                elif data[0] == 3:
                    self.Dcx[(1,3)] += 1
            elif label[0] == 2:
                self.Dc[2] += 1
                # M
                if data[0] == 1:
                    self.Dcx[(2,1)] += 1
                # F
                elif data[0] == 2:
                    self.Dcx[(2,2)] += 1
                # I
                elif data[0] == 3:
                    self.Dcx[(2,3)] += 1
            elif label[0] == 3:
                self.Dc[3] += 1
                # M
                if data[0] == 1:
                    self.Dcx[(3,1)] += 1
                # F
                elif data[0] == 2:
                    self.Dcx[(3,2)] += 1
                # I
                elif data[0] == 3:
                    self.Dcx[(3,3)] += 1

        def cal_prior_P(D_c):
            # （当前类别下的样本数 + 1）/（总样本数 + 类别总数）
            return (len(D_c) + 1) / (n + class_num)
        
        # 计算各个类别，8个特征维度的平均值
        def cal_X_mean(X):
            X_mean = []
            for i in range(X.shape[1]):
                X_mean.append(np.mean(X[:, i]))
            return X_mean
        # 计算各个类别，8个特征维度的方差
        def cal_X_var(X):
            X_var = []
            for i in range(X.shape[1]):
                X_var.append(np.var(X[:, i]))
            return X_var

        n = traindata.shape[0]
        class_num = 3

        full_data = np.hstack((traindata, trainlabel))
        #print(full_data.shape)
        #提取各类别数据，字典的键为类别名，值为对应的分类数据
        data_dict={} 
        for i in range(1, 4):
            if i in full_data[:,-1]:
                data_dict[i]=full_data[full_data[:, -1]==i]
            
            # class_name=list(data_dict.keys()) #类别名
            # num_of_class = len(data_dict.keys())  #类别总数
        
        # print(data_dict)
        # print(len(data_dict[1]) + len(data_dict[2]) + len(data_dict[3]))
        for i in range(1, 4):
            class_data = data_dict[i]
            X_class = class_data[:, :-1]
            y_class = class_data[:, -1]
            self.Pc[i] = cal_prior_P(y_class)
            self.X_mean[i] = cal_X_mean(X_class)
            self.X_var[i] = cal_X_var(X_class)
            

    '''
    根据先验概率分布p(c)和条件概率分布p(x|c)对新样本进行预测
    返回预测结果,预测结果的数据类型应为np数组，shape=(test_num,1) test_num为测试数据的数目
    feature_type为0-1数组，表示特征的数据类型，0表示离散型，1表示连续型
    '''
    def predict(self,features,featuretype):
        '''
        需要你实现的部分
        '''       
        def cal_Gaussian(X, XMean, XVar):
            prob = []
            d = len(X)
            for i in range(d):
                a = 1 / np.sqrt(2 * np.pi * XVar[i+1])
                b = np.exp(-(X[i] - XMean[i+1]) ** 2 / (2 * XVar[i+1]))
                prob.append(a * b)
            return prob
        def cal_discrete_P(X, i):        
            return (self.Dcx[i, X] + 1) / (self.Dc[i] + 3)
        res = []
        # 对每一个样本进行如下计算
        for i in range(features.shape[0]):
            X = features[i, :]
            post_P = []
            # 计算该样本输入每个类别的后验概率
            for j in range(1, 4):
                gaussian_res = cal_Gaussian(X[1:], self.X_mean[j], self.X_var[j])
                discrete_res = cal_discrete_P(X[0], j)
                post_P.append(np.log(self.Pc[j]) + sum(np.log(gaussian_res)) + np.log(discrete_res))
                max_index = np.argmax(post_P)
            res.append([max_index + 1])
        return np.array(res)

def main():
    # 加载训练集和测试集
    train_data,train_label,test_data,test_label=load_and_process_data()
    feature_type=[0,1,1,1,1,1,1,1] #表示特征的数据类型，0表示离散型，1表示连续型

    Nayes=NaiveBayes()
    Nayes.fit(train_data,train_label,feature_type) # 在训练集上计算先验概率和条件概率

    pred=Nayes.predict(test_data,feature_type)  # 得到测试集上的预测结果
    # 计算准确率Acc及多分类的F1-score
    print("Acc: "+str(get_acc(test_label,pred)))
    print("macro-F1: "+str(get_macro_F1(test_label,pred)))
    print("micro-F1: "+str(get_micro_F1(test_label,pred)))

main()