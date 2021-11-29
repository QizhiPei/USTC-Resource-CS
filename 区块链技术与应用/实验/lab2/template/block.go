package main

import (
	"bytes"
	"encoding/gob"
	"log"
	"time"
)

// Block keeps block headers
// Block 由区块头和交易两部分构成
// Timestamp, PrevBlockHash, Hash 属于区块头（block header）
// Timestamp     : 当前时间戳，也就是区块创建的时间
// PrevBlockHash : 前一个块的哈希
// Hash          : 当前块的哈希
// Data          : 区块实际存储的信息，比特币中也就是交易
// Nonce         : 用于工作量证明时的验证
type Block struct {
	Timestamp     int64
	Data          [][]byte
	PrevBlockHash []byte
	Hash          []byte
	Nonce         int
}
// 根据区块的数据建立Merkle树,返回Merkle根的数据
func (b *Block) HashData() []byte {
	mTree := NewMerkleTree(b.Data)

	return mTree.RootNode.Data
}

// 将区块数据序列化为一个字节数组
// Serialize serializes the block
func (b *Block) Serialize() []byte {
	// 存储序列化后的数据
	var result bytes.Buffer
	encoder := gob.NewEncoder(&result)
	// 对 Block 进行编码
	err := encoder.Encode(b)
	if err != nil {
		log.Panic(err)
	}

	// 编码的结果作为字节数组返回
	return result.Bytes()
}

// 创建新区块，需要运行工作量证明找到有效哈希
// NewBlock creates and returns Block
func NewBlock(datas []string, prevBlockHash []byte) *Block {
	// 类型为byte的二维切片
	blockData := [][]byte{}
	// 将datas中的数据读入blockData
	for _, data := range datas {
		blockData = append(blockData,[]byte(data))
	} 
	// 建立区块
	block := &Block{time.Now().Unix(), blockData, prevBlockHash, []byte{}, 0}
	pow := NewProofOfWork(block)
	nonce, hash := pow.Run()

	block.Hash = hash[:]
	block.Nonce = nonce

	return block
}

// 创建创世区块Genesis Block
// NewGenesisBlock creates and returns genesis Block
func NewGenesisBlock() *Block {
	return NewBlock([]string{"Genesis Block"}, []byte{})
}

// 将字节数组反序列化为一个Block
// 注意和 Serialize 不同的是，DeserializeBlock 是一个函数 而非 方法
// DeserializeBlock deserializes a block
func DeserializeBlock(d []byte) *Block {
	var block Block

	decoder := gob.NewDecoder(bytes.NewReader(d))
	err := decoder.Decode(&block)
	if err != nil {
		log.Panic(err)
	}

	return &block
}
