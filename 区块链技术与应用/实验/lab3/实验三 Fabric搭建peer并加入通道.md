# 实验三 Fabric搭建peer并加入通道



[TOC]



## 介绍

在Fabric中，根据提供的服务不同，可以把服务节点分为三类：CA、Orderer和Peer。

- CA：用于提供Fabric中组织成员的身份注册和证书颁发
- Orderer：排序节点，搜集交易并排序出块，广播给其他组织的主节点
- Peer：背书、验证和存储节点

实验使用的Fabric版本为release-2.2，所有概念、架构以及命令文档，都可以在官方文档中搜索翻阅  [一个企业级区块链平台 — hyperledger-fabricdocs master 文档](https://hyperledger-fabric.readthedocs.io/zh_CN/release-2.2/)

本次实验的目标是==使用Fabric搭建一个peer节点，并用这个peer节点加入已经创建的通道之中==



## 实验环境

在本次实验中，拥有以下物理服务器，服务器操作系统为Ubuntu 18.04.4 LTS

- 222.195.70.186
- 222.195.70.187
- 222.195.70.188
- 222.195.70.189
- 222.195.70.190

在222.195.70.186这个服务器上已经搭建了**CA服务器**和**Orderer服务器**,CA服务端口号为**7054**，orderer服务端口号为**7050**。

同时各个服务器上为同学们注册了各自的账户，账户信息见群里分享的共享表格 Account，同学们自行选择喜欢的方式（ssh）连接到服务器完成实验任务。

在本次实验中，所有同学启动的peer节点都属于一个组织，**peer节点组织名为Peer**，需要加入的通道名称为**bcclass** 。

同学们需要用到的程序有**fabric-ca-client、peer**。其可执行文件所在的路径都已经设置为系统的全局变量，可以直接使用这些命令，但是需要注意使程序能够找到配置文件所在的目录（例如使用export来设置用户环境变量，export FABRIC_CFG_PATH=config_file_path）。

------

222.195.70.186机器上新建了一个用户kecheng，passwd：kecheng

家目录下：

admin-msp：Peer组织的admin

ca-admin-msp：CA组织的admin

bcclass.block：bcclass通道的初始块

需要的时候用**scp指令**拷贝



## 实验流程

1. 使用CA服务器注册身份，并获得CA服务器颁发的身份证书
2. 在本地准备Peer节点启动所需要的文件，启动Peer节点
3. 将自己搭建的Peer节点加入通道bcclass



## CA服务

有关CA服务的详细功能和操作见附件 Fabric_ca.pdf

在这次实验中，事先拥有CA的admin证书，组织的admin证书（两个管理员证书的作用域不同，前者管理CA服务，后者管理组织服务）。

你需要使用这个CA的admin证书去注册自己在fabric组织中的peer证书。主要使用的是CA客户端的服务。

涉及的主要是以下两条指令（参数自己修改）

其中id.name和id.secret可以随意取值，为了不覆盖掉他人的id账户，请考虑使用account中的用户名作为id.name

```
注册组织peer (一定要记得 --home指定目录或者export设置工作目录环境变量)
fabric-ca-client register --id.name myname_1 --id.secret mysecret --id.type peer -u http://127.0.0.1:7054 --mspdir ./admin/msp

获得组织peer的msp
fabric-ca-client enroll -u http://myname_1:mysecret@127.0.0.1:7054 --mspdir ./myname_1/msp
```



查看自己的证书信息可以使用以下两条命令

```
查看pem证书
openssl x509 -in ./msp/signcerts/cert.pem -text
或者
keytool -printcert -file certificate.pem
```



## 启动Peer节点

此部分详细操作见附件 Peer节点配置与启动.pdf

主要工作为

1. 构造msp文件夹
2. 配置好core.yaml文件
3. 设置环境变量（如果有需要）
4. 启动peer

其中启动peer可以考虑使用screen命令启动额外的shell后，再执行peer node start

```
screen 提供从单个 SSH 会话中使用多个 shell 窗口（会话）的能力
screen -S name 启动一个shell
分离：要从当前的 screen 会话中分离，你可以按下Ctrl-A 和 d
screen -ls 列出所有screen会话
screen -r 7934 连接某个会话
关闭：有几种方法来中止 screen 会话。你可以按下 Ctrl+d ，或者在命令行中使用 exit 命令
```



填写配置文件的时候，需要指定服务的端口号，为了防止端口被占用而无法启动服务，请查找合适的未被服务占用的空闲端口号

```
netstat -tunlp | grep 端口号
或者
lsof -i:端口号
```



配置文件中core.yaml中，关于profile、metrics等服务，都可以配置为关闭，实验不需要。

```
metrics 下的 provider 设置为disabled  //关闭后就不需要管operations部分的配置了
profile 下的 enabled 设置为false
```



注意，启动peer节点时需要使用peer类型证书，加入通道时需要使用admin类型证书。证书的切换有多种办法，可参考如下

```
方法一：设置环境变量，如设置
export CORE_PEER_ADDRESS 启动的peer服务的ip地址:端口
export CORE_PEER_LOCALMSPID 设置连接peer的localmspid
export CORE_PEER_MSPCONFIGPATH 设置msp文件的目录路径

方法二：
core.yaml文件中的mspConfigPath指定了msp目录,在msp目录下的signcerts目录中存放组织admin的证书,keystore下面放对应私钥
```



## 加入通道

如果证书有效，节点配置正确，则此时peer已经具备加入通道的能力。

peer通道操作命令文档见 [peer channel — hyperledger-fabricdocs master 文档](https://hyperledger-fabric.readthedocs.io/zh_CN/release-2.2/commands/peerchannel.html)

调用如下命令加入通道（参数自己修改）

```
获取配置区块
peer channel fetch config mychannel.genesis.block -c mychannel --orderer orderer.example.com:7050
peer加入通道（加入通道的创世区块可以使用peer channel fetch获得）
peer channel join -b mychannel.genesis.block
```

如果加入成功，会输出以下信息

![](fig\fig1.png)

可以使用以下命令查看peer加入的通道名称

```
peer channel list
```

![](fig/fig2.png)



## 实验要求

完成实验和实验报告，实验报告要求提供一张带有自己账户名以及调用peer channel list 成功输出加入的通道的信息截图（如“加入通道”部分的第2张图）。报告发送至助教邮箱。

截至日期2021年6月18日晚上十二点。



## 实验附件清单

```
├─ Account.txt
│
├─ 实验三 Fabric搭建peer并加入通道.md
│
├─ config_and_adminMsp   //配置模板，某些部分需要自己手动修改
│      config.yaml  //msp中的文件
│      core.yaml    //peer的配置文件
│      fabric-ca-client-config.yaml //ca-clinet的配置文件
│      ca_admin.tar.gz   //ca的admin证书
│      org_adm.tar.gz    //组织的admin证书
│
├─fig
│      fig1.png
│      fig2.png
│
└─pdf   //相关资料
        Fabric_ca.pdf
        Peer节点配置与启动.pdf

```

