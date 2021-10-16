package main

import (
	"fmt"
	"test/asm"
)

func test(a []int) {
	a[2] = 4
}

func sum(a, b int) int {
	return a + b
}

//monr
func main() {
	fmt.Println(asm.Id)
	fmt.Println(asm.Name)
	//_ = g.Getg() // 需要修改 go-tls 源码，原 g.getg 没有导出
	//stub.Patch(sum, func(a, b int) int { return a - b })
	//fmt.Println(sum(1, 2)) // 输出 -1
}
