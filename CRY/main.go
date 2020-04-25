package main

import (
	"bytes"
	"crypto/sha256"
	"encoding/binary"
	"encoding/hex"
	"fmt"
	"math"
	"math/big"
	"math/rand"
	"time"
)

func reverse(a []byte) []byte {
	for i := len(a)/2 - 1; i >= 0; i-- {
		opp := len(a) - 1 - i
		a[i], a[opp] = a[opp], a[i]
	}
	return a
}
func bin(a uint32) []byte {
	bin := make([]byte, 4)
	binary.LittleEndian.PutUint32(bin, a)
	return bin
}

func checkNonce(headerPrefix, targetStr []byte, nonce uint32) bool {
	tempHeader := make([]byte, len(headerPrefix))
	copy(tempHeader, headerPrefix)
	header := append(tempHeader, bin(nonce)...)
	has1 := sha256.Sum256(header)
	hash := sha256.Sum256(has1[:])
	if bytes.Compare(reverse(hash[:]), targetStr) == -1 {
		return true
	}
	return false
}
func calcHash(headerPrefix []byte, nonce uint32) string {
	tempHeader := make([]byte, len(headerPrefix))
	copy(tempHeader, headerPrefix)
	header := append(tempHeader, bin(nonce)...)
	has1 := sha256.Sum256(header)
	hash := sha256.Sum256(has1[:])
	return hex.EncodeToString(hash[:])
}
func work(workerID, minNonce, maxNonce, workers uint32, headerPrefix, targetStr []byte, resp chan response) {
	tempHeader := make([]byte, len(headerPrefix))
	for nonce := minNonce + workerID; nonce < maxNonce-workers; nonce += workers {
		copy(tempHeader, headerPrefix)
		header := append(tempHeader, bin(nonce)...)
		has1 := sha256.Sum256(header)
		hash := sha256.Sum256(has1[:])
		if bytes.Compare(reverse(hash[:]), targetStr) == -1 {
			r := response{}
			r.nonce = nonce
			r.hash = hex.EncodeToString(hash[:])
			resp <- r
			return
		}
	}
	resp <- response{}
}
func caz1(headerPrefix, targetStr []byte) uint32 {
	var minNonce uint32 = 3_000_000_000
	var maxNonce uint32 = 3_100_000_000
	var workers uint32 = 8
	resp := make(chan response)
	for i := uint32(0); i < workers; i++ {
		go work(i, minNonce, maxNonce, workers, headerPrefix, targetStr, resp)
	}
	for i := uint32(0); i < workers; i++ {
		r := <-resp
		if checkNonce(headerPrefix, targetStr, r.nonce) {
			fmt.Printf("Cazul 1:\n\tNonce1: %d (0x%x);\n\tBlock Hash: %s;\n\tPrimele 5 valori hash:\n", r.nonce, r.nonce, r.hash)
			for i := minNonce; i < minNonce+5; i++ {
				fmt.Printf("\t\t %s\n", calcHash(headerPrefix, i))
			}
			return r.nonce
		}
	}
	return 0
}
func caz2(headerPrefix, targetStr []byte, nonce1 uint32) {
	if nonce1 == 0 {
		return
	}
	s1 := rand.NewSource(time.Now().UnixNano())
	r1 := rand.New(s1)
	var maxNonce uint32 = math.MaxUint32
	var minNonce uint32 = r1.Uint32()*(math.MaxUint32-nonce1) + nonce1
	for minNonce < nonce1 || (maxNonce-minNonce) < 100_000_000 {
		minNonce = r1.Uint32()*(math.MaxUint32-nonce1) + nonce1
	}
	var workers uint32 = 8
	resp := make(chan response, workers)
	for i := uint32(0); i < workers; i++ {
		go work(i, minNonce, maxNonce, workers, headerPrefix, targetStr, resp)
	}
	fmt.Printf("Cazul 2:\n\tNonce2 start: %d;\n\tNumar testari: %d;\n\tSucces: ", minNonce, maxNonce-minNonce)
	for i := uint32(0); i < workers; i++ {
		r := <-resp
		if checkNonce(headerPrefix, targetStr, r.nonce) {
			fmt.Printf("DA\n\t\tNonce2: %d\n\t\tHash2: %s\n", r.nonce, r.hash)
			return
		}
	}
	fmt.Printf("NU\n")
	close(resp)
}

type response struct {
	nonce uint32
	hash  string
}

func main() {
	var ver uint32 = 0x20400000
	prevBlock := "00000000000000000006a4a234288a44e715275f1775b77b2fddb6c02eb6b72f"
	mrklRoot := "2dc60c563da5368e0668b81bc4d8dd369639a1134f68e425a9a74e428801e5b8"
	var t uint32 = 0x5DB8AB5E
	var bits uint32 = 0x17148EDF

	var exp uint = uint(bits >> 24)
	mant := bits & (0xffffff)
	w := 8 * (exp - 3)
	x := new(big.Int).SetInt64(1)
	x = x.Lsh(x, uint(w))
	x = x.Mul(x, new(big.Int).SetInt64(int64(mant)))
	targetHexstr := fmt.Sprintf("%064x", x)
	targetStr, _ := hex.DecodeString(targetHexstr)
	prev, _ := hex.DecodeString(prevBlock)
	mrkl, _ := hex.DecodeString(mrklRoot)
	binVer := make([]byte, 4)
	binary.LittleEndian.PutUint32(binVer, ver)

	headerPrefix := append(append(append(append(append(binVer, reverse(prev)...), reverse(mrkl)...), bin(t)...), bin(bits)...))
	nonce1 := caz1(headerPrefix, targetStr)

	caz2(headerPrefix, targetStr, nonce1)

}
