package main

import (
	"fmt"
)

var num [2]int

var (
	boolValue  bool
	trueValue  bool
	falseValue bool
)

var int32Value int32

func Swap(a, b int) (int, int)

func Add(int64, int64) int64

func output(s int) {
	println(s)
}

func output2(a, b int) {
	println(a, b)
}

func main()

func mainA() {

	a := 1
	b := 2
	c, d := Swap(a, b)
	fmt.Println(c, d)
	fmt.Println("end")

	fmt.Println(num[0])

	fmt.Println(boolValue)
	fmt.Println(trueValue)
	fmt.Println(falseValue)
	fmt.Println(int32Value)

	fmt.Println(Add(1, 2))
}

////monr
//func main() {
//	fmt.Println(asm.Id)
//	fmt.Println(asm.Name)
//	//_ = g.Getg() // 需要修改 go-tls 源码，原 g.getg 没有导出
//	//stub.Patch(sum, func(a, b int) int { return a - b })
//	//fmt.Println(sum(1, 2)) // 输出 -1
//}
