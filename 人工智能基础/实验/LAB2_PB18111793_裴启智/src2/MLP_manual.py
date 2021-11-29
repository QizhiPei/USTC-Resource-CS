import torch
from torch.autograd import Variable
import matplotlib.pyplot as plt
import numpy as np
import os
os.environ["KMP_DUPLICATE_LIB_OK"]  =  "TRUE"

dtype = torch.FloatTensor


class MLP:
    def __init__(self, lr, epochs):
        self.num_layers = 4
        self.W1 = np.random.randn(4, 5)
        self.W2 = np.random.randn(4, 4)
        self.W3 = np.random.randn(3, 4)
        self.lr = lr
        self.epochs = epochs

    def sigmoid(self, z):
        return 1.0 / (1.0 + torch.exp(-z))

    def sigmoid_derivative(self, z):
        return self.sigmoid(z) * (1 - self.sigmoid(z))

    def cross_entropy(self, y_hat, y):
        return - torch.log(y_hat.gather(1, y.view(-1, 1)))
    
    def softmax(self, X):
        X_exp = X.exp()
        partition = X_exp.sum(axis=0, keepdims=True)
        return X_exp / partition


    def train_auto(self, X, Y):
        train_data = Variable(torch.from_numpy(X).type(dtype), requires_grad = False)
        train_label = Variable(torch.from_numpy(Y).type(torch.LongTensor), requires_grad = False)
        W1 = Variable(torch.from_numpy(self.W1).type(dtype), requires_grad = True)
        W2 = Variable(torch.from_numpy(self.W2).type(dtype), requires_grad= True)
        W3 = Variable(torch.from_numpy(self.W3).type(dtype), requires_grad = True)
        
        loss1 = np.zeros([self.epochs,1])
        for epoch in range(self.epochs):
            n = train_data.shape[0]
            # Forward Pass
            in_data = train_data.t()
            z1 = W1.mm(in_data)
            h1 = self.sigmoid(z1)
            z2 = W2.mm(h1)
            h2 = self.sigmoid(z2)
            z3 = W3.mm(h2)
            y_hat = self.softmax(z3)
            # Compute Loss
            loss = self.cross_entropy(y_hat.t(), train_label)

            loss.mean().backward()

            loss1[epoch] = loss.mean().item()
            # print(loss1[epoch])

            delta1 = W1.grad.data
            delta2 = W2.grad.data
            delta3 = W3.grad.data

            # print("Auto Grad")
            # print(delta3)
            # print(delta2)
            # print(delta1)

            W1.data = W1.data - self.lr * delta1
            W2.data = W2.data - self.lr * delta2
            W3.data = W3.data - self.lr * delta3

            W1.grad.data.zero_()
            W2.grad.data.zero_()
            W3.grad.data.zero_()
            # print(W3.grad.data)
        plt.figure()
        ix = np.arange(self.epochs)
        plt.plot(ix, loss1)
        plt.show()

    def train(self, X, Y):
        train_data = torch.from_numpy(X).type(dtype)
        train_label = torch.from_numpy(Y).type(torch.LongTensor)
        W1 = torch.from_numpy(self.W1).type(dtype)
        W2 = torch.from_numpy(self.W2).type(dtype)
        W3 = torch.from_numpy(self.W3).type(dtype)
        loss1 = np.zeros([self.epochs,1])
        for epoch in range(self.epochs):
            n = train_data.shape[0]
            # Forward Pass
            in_data = train_data.t()
            z1 = W1.mm(in_data)
            h1 = self.sigmoid(z1)
            z2 = W2.mm(h1)
            h2 = self.sigmoid(z2)
            z3 = W3.mm(h2)
            y_hat = self.softmax(z3)

            # Compute Loss
            loss = self.cross_entropy(y_hat.t(), train_label)
            loss1[epoch] = loss.detach().numpy().mean()
            # print(loss1[epoch])
            # print(loss.detach().numpy().mean())
            # loss.mean().backward()
            # print(loss)

            # print(loss)
            # Back Prop
            # loss.mean().backward()
            ls3 = torch.rand(3, 100)
            for i in range(100):
                for j in range(3):
                    if j == train_label[i]:
                        ls3[j][i] = y_hat[j][i] - 1
                    else:
                        ls3[j][i] = y_hat[j][i]
            
            delta3 = ls3 @ h2.t() / n
            # (4,3) @ (3,100) 
            tmp = (W3.t() @ ls3) * h2 * (1 - h2)
            # (4, 100) @ (100, 4) = (4, 4)
            delta2 = tmp @ h1.t() / n
        
            delta1 = ((W2.t() @ tmp) * h1 * (1 - h1)) @ in_data.t() / n

            # print("Manual Grad")
            # print(delta3)
            # print(delta2)
            # print(delta1)
            # Update Weights
            W1 = W1 - self.lr * delta1
            W2 = W2 - self.lr * delta2
            W3 = W3 - self.lr * delta3
        plt.figure()
        ix = np.arange(self.epochs)
        plt.plot(ix, loss1)
        plt.show()



if __name__ == '__main__':
    np.random.seed(1)
    # X = torch.tensor(np.random.normal(0, 1, (100, 5)))
    # X = np.random.randn(100, 5)
    X = np.random.randint(5, 10, (100, 5))
    X_label = np.random.randint(0, 3, (100, 1))
    temp = MLP(0.05, 1000)
    temp.train(X, X_label)
    temp.train_auto(X, X_label)

