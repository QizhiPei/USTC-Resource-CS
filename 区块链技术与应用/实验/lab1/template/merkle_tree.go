package main

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

// NewMerkleTree creates a new Merkle tree from a sequence of data
// implement
func NewMerkleTree(data [][]byte) *MerkleTree {
	var node = MerkleNode{nil,nil,data[0]}
	var mTree = MerkleTree{&node}

	return &mTree
}