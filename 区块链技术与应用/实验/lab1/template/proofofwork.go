package main

import (
	"math"
	"math/big"
)

var (
	maxNonce = math.MaxInt64
)

const targetBits = 10

// ProofOfWork represents a proof-of-work
type ProofOfWork struct {
	block  *Block
	target *big.Int
}

// NewProofOfWork builds and returns a ProofOfWork
func NewProofOfWork(b *Block) *ProofOfWork {
	target := big.NewInt(1)
	target.Lsh(target, uint(256-targetBits))

	pow := &ProofOfWork{b, target}

	return pow
}


// Run performs a proof-of-work
// implement
func (pow *ProofOfWork) Run() (int, []byte) {
	nonce := 0

	return nonce, pow.block.Hash
}

// Validate validates block's PoW
// implement
func (pow *ProofOfWork) Validate() bool {
	return true
}
