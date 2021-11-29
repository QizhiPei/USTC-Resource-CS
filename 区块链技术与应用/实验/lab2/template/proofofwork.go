package main

import (
	"bytes"
	"crypto/sha256"
	"fmt"
	"math"
	"math/big"
)

var (
	maxNonce = math.MaxInt64
)

// 难度值，这里表示哈希的前 10 位必须是 0。要注意数据是什么进制
const targetBits = 10

// ProofOfWork represents a proof-of-work
// 需要将Hash转化为一个大整数,然后检测它是否小于目标
type ProofOfWork struct {
	block  *Block
	target *big.Int
}

// NewProofOfWork builds and returns a ProofOfWork
func NewProofOfWork(b *Block) *ProofOfWork {
	// 初始化为1
	target := big.NewInt(1)
	// 256 bits,对应 32 bytes
	// 左移 256 - targetBits 位
	target.Lsh(target, uint(256-targetBits))

	pow := &ProofOfWork{b, target}

	return pow
}

// 定义结构体 prepareData 的方法(只在该文件内使用)
func (pow *ProofOfWork) prepareData (nonce int) []byte {
	// Join 结果得到1维切片
	data := bytes.Join(
		[][]byte{
			pow.block.PrevBlockHash,
			pow.block.HashData(),
			// 大写字母开头的变量 or方法是暴露给其他包用的
			IntToHex(pow.block.Timestamp),
			IntToHex(int64(targetBits)),
			IntToHex(int64(nonce)),
		},
		[]byte{},
	)
	return data
}

// 寻找有效哈希
// Run performs a proof-of-work
// implement
func (pow *ProofOfWork) Run() (int, []byte) {
	nonce := 0
	var hashInt big.Int
	var hash [32]byte

	fmt.Printf("Mining the block, containing data :\"%s\"\n", pow.block.Data)
	// 类似 While 循环, nonce < maxNonce 避免溢出
	for nonce < maxNonce {
		// 准备数据
		data := pow.prepareData(nonce)
		// 计算Hash值
		hash = sha256.Sum256(data)
		// SetBytes将hash解释为大端无符号整数的字节，并将hashInt设置为该值
		// 这是为了格式统一,便于后续比较
		hashInt.SetBytes(hash[:])
		// 如果 hashInt 小于目标值
		if hashInt.Cmp(pow.target) == -1 {
			// \r 为回车符
			fmt.Printf("\r%x", hash)
			break
		} else {
			nonce++
		}
	}
	fmt.Print("\n\n")
	// 修改，因为是通过调用 Run 函数后通过返回值来设置 Block 的hash
	// 所以这里没必要返回 pow.block.Hash
	return nonce, hash[:]
}

// 只要哈希小于目标就是有效工作量
// Validate validates block's PoW
// implement
func (pow *ProofOfWork) Validate() bool {
	var hashInt big.Int
	// 准备数据
	data := pow.prepareData(pow.block.Nonce)
	// 调用 SHA-256 加密算法
	hash := sha256.Sum256(data)
	// 转化为大整数
	hashInt.SetBytes(hash[:])
	// 验证是否小于目标值，Cmp == -1
	isValid := (hashInt.Cmp(pow.target) == -1)
	return isValid
}
