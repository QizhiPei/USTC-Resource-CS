package main

import (
	"fmt"
	"log"

	"github.com/boltdb/bolt"
)

const dbFile = "blockchain.db"
const blocksBucket = "blocks"

// 数据库中需要用到的键值对
// 32字节的 Block hash → block
// l 				  → 区块链中最后一个块的 Hash

// Blockchain keeps a sequence of Blocks
// tip指的是存储最后一个块的哈希
// 在链的末端可能出现短暂分叉的情况，所以选择 tip 其实也就是选择了哪条链
// db 存储数据库连接
type Blockchain struct {
	tip []byte
	db  *bolt.DB
}

// 使用迭代器，不用将所有区块都加载到内存里
// BlockchainIterator is used to iterate over blockchain blocks
type BlockchainIterator struct {
	currentHash []byte
	db          *bolt.DB
}

// 添加区块,并存储到数据库中
// AddBlock saves provided data as a block in the blockchain
// implement
func (bc *Blockchain) AddBlock(data []string) {
	var lHash []byte
	// 获取最后一个块的哈希用于生成新块的哈希,只读事务
	err := bc.db.View(func(tx *bolt.Tx) error {
		b := tx.Bucket([]byte(blocksBucket))
		// 获取最后一个块的哈希
		lHash = b.Get([]byte("l"))
		return nil
	})

	if err != nil {
		log.Panic(err)
	}

	// 用最后一个块的哈希产生新的块
	newBlock := NewBlock(data, lHash)
	// 读写事务，添加区块
	err = bc.db.Update(func(tx *bolt.Tx) error {
		b := tx.Bucket([]byte(blocksBucket))
		// key = newBlock.Hash, value = newBlock的序列化表示
		err := b.Put(newBlock.Hash, newBlock.Serialize())
		if err != nil {
			log.Panic(err)
		}
		err = b.Put([]byte("l"), newBlock.Hash)
		if err != nil {
			log.Panic(err)
		}
		// 设置 tip 指向新块的Hash值
		bc.tip = newBlock.Hash
		return nil
	})
}

// 迭代器的初始状态为 tip,所以区块将从尾到头进行迭代
// 选择一个 tip 实际上就是给一个连投票
// Iterator ...
func (bc *Blockchain) Iterator() *BlockchainIterator {
	bci := &BlockchainIterator{bc.tip, bc.db}

	return bci
}

// Next returns next block starting from the tip
func (i *BlockchainIterator) Next() *Block {
	var block *Block
	// 只读事务,读取当前的区块
	err := i.db.View(func(tx *bolt.Tx) error {
		b := tx.Bucket([]byte(blocksBucket))
		encodedBlock := b.Get(i.currentHash)
		block = DeserializeBlock(encodedBlock)

		return nil
	})

	if err != nil {
		log.Panic(err)
	}
	// 调整迭代器到前一个区块
	i.currentHash = block.PrevBlockHash

	return block
}

// NewBlockchain creates a new Blockchain with genesis Block

func NewBlockchain() *Blockchain {
	var tip []byte
	db, err := bolt.Open(dbFile, 0600, nil)
	if err != nil {
		log.Panic(err)
	}
	// 打开一个读写事务
	err = db.Update(func(tx *bolt.Tx) error {
		// 获取存储区块的Bucket
		b := tx.Bucket([]byte(blocksBucket))

		// 如果不存在
		if b == nil {
			fmt.Println("No existing blockchain found. Creating a new one...")
			// 生成创始区块
			genesis := NewGenesisBlock()
			// 创建 bucket
			b, err := tx.CreateBucket([]byte(blocksBucket))

			if err != nil {
				log.Panic(err)
			}
			// 将创世区块保存到 bucket 中
			err = b.Put(genesis.Hash, genesis.Serialize())
			if err != nil {
				log.Panic(err)
			}

			// 更新 l 键以存储区块链中最后一个块的哈希
			err = b.Put([]byte("l"), genesis.Hash)
			if err != nil {
				log.Panic(err)
			}
			// 设置 tip 指向创世区块
			tip = genesis.Hash
		} else {
			// 如果存在,从中读取 l 键,并设置 tip 指向最后一个块的哈希
			tip = b.Get([]byte("l"))
		}
		// 如果存在 error
		return nil
	})

	if err != nil {
		log.Panic(err)
	}

	// 仅存储区块链的 tip 和数据库连接
	// 这样一旦打开数据库连接,区块链就可以运行
	bc := Blockchain{tip, db}

	return &bc
}
