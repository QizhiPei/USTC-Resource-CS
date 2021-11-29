import torch
import torch.nn as nn
from torchvision import transforms
from torchvision.datasets import MNIST
#禁止import除了torch以外的其他包，依赖这几个包已经可以完成实验了

device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")

class Mixer_Layer(nn.Module):
    def __init__(self, patch_size, hidden_dim):
        super(Mixer_Layer, self).__init__()
        ########################################################################
        #这里需要写Mixer_Layer（layernorm，mlp1，mlp2，skip_connection）
        # 这里自己设定的
        tokens_mlp_dim = 16
        channels_mlp_dim = 128

        class Mlp_Block(nn.Module):
            def __init__(self, hidden_dim, mlp_dim):
                super(Mlp_Block, self).__init__()
                self.mlp = nn.Sequential(
                    nn.Linear(hidden_dim, mlp_dim),
                    nn.GELU(),
                    nn.Linear(mlp_dim, hidden_dim)
                )

            def forward(self, x):
                return self.mlp(x)

        self.layer_norm_token = nn.LayerNorm(hidden_dim)
        self.token_mix = Mlp_Block(patch_size, tokens_mlp_dim)
        self.layer_norm_channel = nn.LayerNorm(hidden_dim)
        self.channel_mix = Mlp_Block(hidden_dim, channels_mlp_dim)
        ########################################################################

    def forward(self, x):
        ########################################################################
        out = self.layer_norm_token(x).transpose(1, 2)
        x = x + self.token_mix(out).transpose(1, 2)
        out = self.layer_norm_channel(x)
        x = x + self.channel_mix(out)
        return x
        ########################################################################


class MLPMixer(nn.Module):
    def __init__(self, patch_size, hidden_dim, depth):
        super(MLPMixer, self).__init__()
        assert 28 % patch_size == 0, 'image_size must be divisible by patch_size'
        assert depth > 1, 'depth must be larger than 1'
        ########################################################################
        #这里写Pre-patch Fully-connected, Global average pooling, fully connected
        num_classes = 10
        num_tokens = (28 // patch_size) ** 2

        self.patch_emb = nn.Conv2d(1, hidden_dim, kernel_size=patch_size, stride=patch_size, bias=False)
        self.mlp = nn.Sequential(*[Mixer_Layer(num_tokens, hidden_dim) for _ in range(depth)])
        self.layer_norm = nn.LayerNorm(hidden_dim)
        self.fully_connected = nn.Linear(hidden_dim, num_classes)
        ########################################################################


    def forward(self, data):
        ########################################################################
        #注意维度的变化
        data = self.patch_emb(data)
        data = data.flatten(2).transpose(1, 2)
        data = self.mlp(data)
        data = self.layer_norm(data)
        data = data.mean(dim=1)
        data = self.fully_connected(data)
        return data
        ########################################################################


def train(model, train_loader, optimizer, n_epochs, criterion):
    model.train()
    for epoch in range(n_epochs):
        for batch_idx, (data, target) in enumerate(train_loader):
            data, target = data.to(device), target.to(device)
            ########################################################################
            #计算loss并进行优化
            optimizer.zero_grad()
            loss = criterion(model(data), target)
            loss.backward()
            optimizer.step()
            ########################################################################
            if batch_idx % 100 == 0:
                print('Train Epoch: {}/{} [{}/{}]\tLoss: {:.6f}'.format(
                    epoch, n_epochs, batch_idx * len(data), len(train_loader.dataset), loss.item()))


def test(model, test_loader, criterion):
    model.eval()
    test_loss = 0.
    num_correct = 0 #correct的个数
    with torch.no_grad():
        for data, target in test_loader:
            data, target = data.to(device), target.to(device)
        ########################################################################
        #需要计算测试集的loss和accuracy
            pred = model(data)
            loss = criterion(pred, target)
            test_loss += loss
            num_correct += (pred.argmax(dim=1) == target).float().sum()
        test_num = len(test_loader.dataset)
        print(test_num)
        accuracy = num_correct / test_num
        test_loss /= 25 # 5 个 epoch，每个 epoch 会得到 5 个 loss
        ########################################################################
        print("Test set: Average loss: {:.4f}\t Acc {:.2f}".format(test_loss.item(), accuracy))




if __name__ == '__main__':
    n_epochs = 5
    batch_size = 128
    learning_rate = 1e-3

    transform = transforms.Compose(
        [transforms.ToTensor(),
        transforms.Normalize((0.1307,), (0.3081,))])

    trainset = MNIST(root = './data', train=True, download=True, transform=transform)
    train_loader = torch.utils.data.DataLoader(trainset, batch_size=batch_size, shuffle=True, num_workers=2, pin_memory=True)

    testset = MNIST(root = './data', train=False, download=True, transform=transform)
    test_loader = torch.utils.data.DataLoader(testset, batch_size=batch_size, shuffle=False, num_workers=2, pin_memory=True)

    
    ########################################################################
    device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
    model = MLPMixer(patch_size = 7, hidden_dim = 14, depth = 3).to(device) # 参数自己设定，其中depth必须大于1
    # 这里需要调用optimizer，criterion(交叉熵)
    optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)
    criterion = nn.CrossEntropyLoss()
    ########################################################################
    
    train(model, train_loader, optimizer, n_epochs, criterion)
    test(model, test_loader, criterion)