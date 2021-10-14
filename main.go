package main

import "github.com/huandu/go-tls/g"

//monr
func main() {
	_ = g.Getg() // 需要修改 go-tls 源码，原 g.getg 没有导出
	//monkey.Patch(sum, func(a, b int) int { return a - b })
	//fmt.Println(sum(1, 2)) // 输出 -1
}
