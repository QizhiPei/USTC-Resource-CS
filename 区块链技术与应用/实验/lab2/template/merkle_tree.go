package main

import "crypto/sha256"

// MerkleTree represent a Merkle tree
type MerkleTree struct {
	RootNode *MerkleNode
}

// MerkleNode represent a Merkle tree node
type MerkleNode struct {
	Left  *MerkleNode
	Right *MerkleNode
	Data  []byte
}

// data为序列化后的交易
func NewMerkleNode(left *MerkleNode, right *MerkleNode, data []byte) *MerkleNode {
	mNode := MerkleNode{}
	// 叶子结点，数据从外界传入
	if left == nil && right == nil {
		hash := sha256.Sum256(data)
		mNode.Data = hash[:]
	} else {
		// 内部结点，将子节点的数据连接后再哈希
		// 后面加三个点，这时append只支持两个参数，不支持任意个数的参数。
		prevHashes := append(left.Data, right.Data...)
		hash := sha256.Sum256(prevHashes)
		mNode.Data = hash[:]
	}
	mNode.Left = left
	mNode.Right = right

	return &mNode
}

// NewMerkleTree creates a new Merkle tree from a sequence of data
// implement
func NewMerkleTree(data [][]byte) *MerkleTree {
	// var node = MerkleNode{nil,nil,data[0]}
	var nodes []MerkleNode
	// 保证叶子节点为偶数
	if len(data) % 2 != 0 {
		// 复制最后一份数据
		data = append(data, data[len(data) - 1])
	}

	// 将所有数据读入所有叶子结点
	for _, dataTemp := range data {
		node := NewMerkleNode(nil, nil, dataTemp)
		nodes = append(nodes, *node)
	}

	// 逐层合并，由下到上，生成内部结点
	for i := 0; i < len(data) / 2; i++ {
		var treeLevel []MerkleNode
		for j := 0; j < len(nodes); j += 2 {
			node := NewMerkleNode(&nodes[j], &nodes[j+1], nil)
			treeLevel = append(treeLevel, *node)
		}
		// 每轮循环中都对 nodes 赋值，最终nodes只含有 Merkle 树的根结点
		nodes = treeLevel
	}

	var mTree = MerkleTree{&nodes[0]}
	return &mTree
}