package main

import (
	"fmt"
	"unsafe"
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

func sum(n int) int

type FunTwiceClosure struct {
	F uintptr
	X int
}

func ptrToFunc(p unsafe.Pointer) func() int

func asmFunTwiceClosureAddr() uintptr

func NewTwiceFunClosure(x int) func() int {
	var p = &FunTwiceClosure{
		F: asmFunTwiceClosureAddr(),
		X: x,
	}
	Y := 10
	fmt.Println(Y)
	return ptrToFunc(unsafe.Pointer(p))
}

func SyscallWrite_Darwin(int, string) int

type ta struct {
	a uint32
	c int
}

func getg() unsafe.Pointer

const g_goid_offset = 152 // Go>=1.10

func GetGroutineId() int64 {
	g := getg()
	p := (*int64)(unsafe.Pointer(uintptr(g) + g_goid_offset))
	return *p
}

func testP(**int)

func main() {

	a := 1
	b := &a
	testP(&b)

	//
	//t := &ta{}
	//fmt.Printf("%d\n",&t.a)
	//fmt.Printf("%d\n",&t.c)

	//fmt.Println(GetGroutineId())
	//go func() {
	//	fmt.Println(GetGroutineId())
	//}()
	//time.Sleep(1*time.Second)

	//var a *[10000]int

	//a = (*[10000]int)(unsafe.Pointer(t))
	//a[0] = 1
	//t.b[0] = 10
	//a[1] = 2
	//a[9999] = 20
	//fmt.Println(a[0])
	//fmt.Println(a[9999])

	//fmt.Println(SyscallWrite_Darwin(1, "hello syscall!\n"))

	//fnTwice := NewTwiceFunClosure(1)
	//
	//println(fnTwice()) // 1*2 => 2
	//println(fnTwice()) // 2*2 => 4
	//println(fnTwice()) // 4*2 => 8
}

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
