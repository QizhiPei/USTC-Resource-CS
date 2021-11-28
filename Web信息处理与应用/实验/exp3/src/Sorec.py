import math
import numpy as np
from numpy.random import RandomState
from scipy.sparse import csr_matrix
from scipy.sparse import coo_matrix
from matplotlib import pyplot as plt
import time
import copy


def fx(x):
    return x/5

def sigmoid(x):
    return 1 / (1 + np.exp(-x))

# The derivative of sigmoid
def sigmoid_(x):
    val = sigmoid(x)
    return val*(1-val)

class MF:
    def __init__(self, R, Validate, C, lr = 0.01,momentum=0.8,
                 lambda_c=10, lambda_u=0.001, lambda_v=0.001, lambda_z=0.001, latent_size=10,iters=1000,seed=None):
        """
        :param R: train set of ratings_data
        :param Validate: validate set of ratings_data
        :param C: trust matrix of users
        :param lr: learning rate
        :param momentum:
        :param lambda_c:
        :param lambda_u:
        :param lambda_v:
        :param lambda_z:
        :param latent_size: 潜在因素维度
        :param iters: iteration
        :param seed:
        """
        self.R = R
        self.Validate= Validate
        self.C = C
        self.lambda_c = lambda_c
        self.lambda_u = lambda_u
        self.lambda_z = lambda_z
        self.lambda_v = lambda_v
        self.latent_size = latent_size
        self.random_state = RandomState(seed)
        self.iters = iters
        self.lr = lr
        #print(np.size(R, 0))
        #print(np.size(R, 1))
        #print(np.size(C, 1))
        self.U = np.mat(self.random_state.rand(latent_size, np.size(R, 0)))
        self.V = np.mat(self.random_state.rand(latent_size, np.size(R, 1)))
        self.Z = np.mat(self.random_state.rand(latent_size, np.size(C, 1)))
        self.momentum = momentum


    # the MAE for train set
    def train_loss(self, UVdata):
        loss = (np.fabs(5 * sigmoid(UVdata)  - self.R.data)).sum()
        loss /= self.R.shape[0]
        return loss

    # the MAE for validate_set
    def vali_loss(self):
        dif = 0.0
        index = self.Validate.nonzero()
        data = self.Validate.data
        tot = data.shape[0]
        for k in range(tot):
            predict = 5*sigmoid((self.U[:,index[0][k]].T*self.V[:,index[1][k]])[0,0])
            dif += math.fabs(data[k] - predict - 1 )
        return dif / tot


    def train(self):
        Rindex = self.R.nonzero()
        #print("shape Rindex:")
        #print(len(Rindex[0]))
        Cindex = self.C.nonzero()
        self.R.data = self.R.data - 1
        Rdata = fx(self.R.data)
        print(Rdata)
        Cdata = self.C.data
        Rnum = Rdata.shape[0]
        Cnum = Cdata.shape[0]
        UVdata = copy.deepcopy(Rdata)
        #print("UVdata:")
        #print(UVdata)
        #print(len(UVdata))
        UZdata = copy.deepcopy(Cdata)
        momentum_u = np.mat(np.zeros(self.U.shape))
        momentum_v = np.mat(np.zeros(self.V.shape))
        momentum_z = np.mat(np.zeros(self.Z.shape))
        train_loss_list = []
        validate_loss_list = []
        begin = time.time()
        minloss = 3.0
        for it in range(self.iters):
            start = time.time()
            #print("Rnum:")
            #print(Rnum)
            for k in range(Rnum):
                UVdata[k] = (self.U[:, Rindex[0][k]].T * self.V[:, Rindex[1][k]])[0][0]
            for k in range(Cnum):
                UZdata[k] = (self.U[:, Cindex[0][k]].T * self.Z[:, Cindex[1][k]])[0][0]

            UV = csr_matrix(((sigmoid(UVdata) - Rdata) * sigmoid_(UVdata), Rindex), self.R.shape)
            UZ = csr_matrix(((sigmoid(UZdata) - Cdata) * sigmoid_(UZdata), Cindex), self.C.shape)

            U = csr_matrix(self.U)
            V = csr_matrix(self.V)
            Z = csr_matrix(self.Z)

            grads_u = self.lambda_u*U + UV.dot(V.T).T + self.lambda_c * UZ.dot(Z.T).T
            grads_v = UV.T.dot(U.T).T + self.lambda_v*V
            grads_z = self.lambda_c * UZ.T.dot(U.T).T + self.lambda_z*Z
            momentum_u = self.momentum * momentum_u + grads_u
            momentum_v = self.momentum * momentum_v + grads_v
            momentum_z = self.momentum * momentum_z + grads_z

            self.U = self.U - self.lr*momentum_u
            self.V = self.V - self.lr*momentum_v
            self.Z = self.Z - self.lr*momentum_z
            trloss = self.train_loss(UVdata)
            valiloss = self.vali_loss()
            train_loss_list.append(trloss)
            validate_loss_list.append(valiloss)
            traintxt = open("train_loss_list___.txt",'a+')
            valitxt = open("validate_loss_list___.txt",'a+')
            traintxt.write(str(trloss)+"\n")
            valitxt.write(str(valiloss)+"\n")
            #np.savetxt("train_loss_list.txt", train_loss_list)
            #np.savetxt("validate_loss_list.txt", validate_loss_list)
            end = time.time()
            print("iter:{}, last_train_loss:{}, validate_loss:{}, timecost:{}, have run:{}".format(it + 1, trloss,
                                                                                                   valiloss,
                                                                                                   end - start,
                                                                                                   end - begin))
            np.savetxt("U_last.txt", self.U)
            np.savetxt("V_last.txt", self.V)
            np.savetxt("Z_last.txt", self.Z)
            if valiloss<minloss:
                minloss = valiloss
                self.Umin=self.U
                self.Vmin=self.V
                self.Zmin=self.Z

        np.savetxt("U_min" + ".txt", self.Umin)
        np.savetxt("V_min" + ".txt", self.Vmin)
        np.savetxt("Z_min" + ".txt", self.Zmin)
        x = np.linspace(1, self.iters, self.iters)
        plt.plot(x, train_loss_list, 'b', label='train_loss')
        plt.plot(x, validate_loss_list, 'r', label='validate_loss')
        plt.legend()
        plt.title("iteration-loss")
        plt.xlabel('iterations')
        plt.ylabel('loss')
        plt.savefig('iteration-loss.png')
        plt.show()
        return self.Umin, self.Vmin, self.Zmin, train_loss_list, validate_loss_list
