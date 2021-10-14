package main

import "fmt"

func main1() {
	x := 200
	for i := 0; i < 100; i++ {
		x = 2 + i
		fmt.Println(x)
	}
}
