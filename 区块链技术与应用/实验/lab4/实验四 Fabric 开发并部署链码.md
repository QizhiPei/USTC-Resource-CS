# 实验四 Fabric 开发并部署链码



[TOC]

## 介绍

在Fabric中，根据提供的服务不同，可以把服务节点分为三类：CA、Orderer和Peer。

- CA：用于提供Fabric中组织成员的身份注册和证书颁发
- Orderer：排序节点，搜集交易并排序出块，广播给其他组织的主节点
- Peer：背书、验证和存储节点，链码安装的节点。

实验使用的Fabric版本为release-2.2，所有概念、架构以及命令文档，都可以在官方文档中搜索翻阅  [一个企业级区块链平台 — hyperledger-fabricdocs master 文档](https://hyperledger-fabric.readthedocs.io/zh_CN/release-2.2/)

本次实验的目标是自己开发可以在Fabric上运行的链码，并且成功部署在Fabric网络上，并调用各个功能进行测试



## 实验环境

同实验三，组织名Peer，通道名bcclass，都与上一次组织相同。

虽然这个组织Peer中有很多的peer节点，但每个节点安装各自的链码，由节点代表组织为各自安装的链码背书。因为该通道中只有一个组织Peer，所以能够搜集到足够的背书来支持调用链码的交易上链。

------

222.195.70.186机器上新建了一个用户kecheng，passwd：kecheng

家目录下：

admin-msp：Peer组织的admin

ca-admin-msp：CA组织的admin

bcclass.block：bcclass通道的初始块

fabric-samples: 里面的chaincode目录存放有官方链码实例（**这次实验可能需要用到**）

需要的时候用scp指令拷贝



## 实验流程

1. 学习链码的开发，编写链码
2. 打包链码、安装链码、批准链码、实例化链码，在peer节点上完成
3. 调用链码，查看功能是否实现



## 实验要求

分三个档次，A,B,C，请同学们根据自己的能力、时间安排，选择合适自己情况的一个档次完成。

难度：A>B>C

得分：

- A: 根据完成情况尽量给予较高的分数，且有独立于实验分数的附加分。
- B: 根据完成情况给出合适的分数，仍可能拿到该实验的满分。
- C: 完成即可拿到实验的及格分数，若未完成仍可能给予更低的分数。

**ddl: 6月24号晚上12点**

### A档

实现一个带一定处理逻辑的链码，包括但不限于，对数据进行计数排序，根据身份证书的属性进行访问控制，等等。可以考虑实现一个投票系统或者自由设计。部署并正确调用链码，截图。提交源码和实验报告。

访问控制参考博客 [ Hyperledger Fabric链码使用基于属性的访问控制_algiz_kk的博客-CSDN博客](https://blog.csdn.net/qq_33657251/article/details/107351136)

### B档

实现一个能够体现增删改查功能的链码，参考官方的例子即可，应用的业务场景不是考察的重点。部署并正确调用链码，截图。提交源码和实验报告。

### C档

能够部署官方的链码fabcar，并正确调用，截图写实验报告。



## 学习链码的开发

fabric智能合约的api [入门 — hyperledger-fabricdocs master 文档](https://hyperledger-fabric.readthedocs.io/zh_CN/release-2.2/getting_started.html#hyperledger-fabric-api)

部署链码的官方教程 [Deploying a smart contract to a channel — hyperledger-fabricdocs master 文档](https://hyperledger-fabric.readthedocs.io/zh_CN/release-2.2/deploy_chaincode.html)

编写智能合约举例[编写你的第一个应用 — hyperledger-fabricdocs master 文档](https://hyperledger-fabric.readthedocs.io/zh_CN/release-2.2/write_first_app.html)

官方链码实例，仓库为     [hyperledger/fabric-samples (github.com)](https://github.com/hyperledger/fabric-samples)

在fabric-samples的chaincode目录下，有各自官方提供的链码例子

| **Smart Contract**                                           | **Description**                                              | **Languages**                    |
| ------------------------------------------------------------ | ------------------------------------------------------------ | -------------------------------- |
| [fabcar](https://github.com/hyperledger/fabric-samples/blob/main/chaincode/fabcar) | Basic smart contract that allows you to add and change data on the ledger using the Fabric contract API. Also contains an example on how to run chaincode as an external service. | Go, Java, JavaScript, Typescript |
| [marbles02](https://github.com/hyperledger/fabric-samples/blob/main/chaincode/marbles02) | Sample that demonstrates how to deploy an index and use rich queries when you are using CouchDB as your state database. | Go                               |
| [marbles02_private](https://github.com/hyperledger/fabric-samples/blob/main/chaincode/marbles02_private) | Sample that demonstrates the use of private data collections. | Go                               |
| [sacc](https://github.com/hyperledger/fabric-samples/blob/main/chaincode/sacc) | Simple asset chaincode that interacts with the ledger using the low-level APIs provided by the Fabric Chaincode Shim API. | Go                               |
| [abstore](https://github.com/hyperledger/fabric-samples/blob/main/chaincode/abstore) | Basic smart contract that allows you to transfer data (from A to B) using the Fabric contract API. | Go, Java, JavaScript             |



## 部署链码及调用

注意1：这部分只是教程，下面的命令不要无脑复制粘贴，更改参数使其符合实际。

注意2：开发链码的时候可以选择自己喜欢的语言，例如go, javascript, java等。不同语言的api见 [入门 — hyperledger-fabricdocs master 文档](https://hyperledger-fabric.readthedocs.io/zh_CN/release-2.2/getting_started.html?highlight=java#hyperledger-fabric-api)

注意3：请每个人将各自的链码命名为“ 学号+链码名字”（例如PB00000001fabcar），否则会报错重复安装。

以官方的fabcar链码安装过程为例，安装链码的环境依赖以go语言为例

在有go.mod的目录执行

```
GO111MODULE=on go mod vendor 下载依赖包存放于vender目录
```

打包链码（路径不要弄错）

```
peer lifecycle chaincode package fabcar.tar.gz --path ../chaincode/fabcar/go/ --lang golang --label fabcar_1
```

注意：在进行以下操作时，请确保通过参数输入、core.yaml文件放于同一目录下或者设置环境变量等办法确保你联系到正确的peer服务，并且提供正确的msp。

```
//以下请自己酌情使用
export CORE_PEER_ADDRESS
export CORE_PEER_LOCALMSPID
export CORE_PEER_MSPCONFIGPATH
export FABRIC_CFG_PATH
```

安装链码

```
peer lifecycle chaincode install fabcar.tar.gz
```

可以查询已经安装的链码信息

```
peer lifecycle chaincode queryinstalled
```

根据返回的信息，设置参数，调用下面的命令

```
export CC_PACKAGE_ID=fabcar_1:762e0fe3dbeee0f7b08fb6200adeb4a3a20f649a00f168c0b3c2257e53b6e506
```

批准链码

```
peer lifecycle chaincode approveformyorg -o ordereraddress:7050 --channelID mychannel --name fabcar --version 1.0 --package-id $CC_PACKAGE_ID --sequence 1
```

可以查询批准的链码信息

```
peer lifecycle chaincode queryapproved --channelID mychannel -n fabcar
```

可以查询已经批准的组织信息

```
peer lifecycle chaincode checkcommitreadiness --channelID mychannel -n fabcar --version 1.0 --sequence 1
```

最后如果应该批准的大部分组织都已经批准了，那么就可以commit到通道（提醒排序节点和本peer），开始这个链码的服务了

```
peer lifecycle chaincode commit -o ordereraddress:7050 --channelID mychannel --name mycc --version 1.0 --sequence 1 --peerAddresses peer0.org1.example.com:7051 --peerAddresses peer0.org2.example.com:9051(输入所有有安装链码并且批准的peer节点服务地址:端口,在这次实验里只有这一个地址)
```

如果以上都成功了，可以调用链码的函数，例如initLedger来初始化数据库

```
peer chaincode invoke -o ordereraddress:7050 -C mychannel -n fabcar --peerAddresses node89:7061 -c '{"function":"initLedger","Args":[]}'
```

然后可以进行其他查询或者调用

```
peer chaincode query -C mychannel -n fabcar -c '{"Args":["queryAllCars"]}'
peer chaincode invoke ordereraddress:7050 -C mychannel -n fabcar --peerAddresses

peer0.org2.example.com:9051 -c '{"function":"CreateCar","Args":["CAR10","Dong","JianLiang","Red","djl"]}'

peer chaincode invoke ordereraddress:7050 -C mychannel -n fabcar --peerAddresses peer0.org2.example.com:9051 -c '{"function":"ChangeCarOwner","Args":["CAR1","djl"]}'
```

query和invoke的区别在于，前者不会提交到排序节点也不会上链，因为是读交易，没有更改状态。后者会进行交易的完整流程，包括背书、排序和验证上链。