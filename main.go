package main

import "C"

import (
	"fmt"
)

//export greeter
func greeter(cstr string) { fmt.Printf("hello %v\n", cstr) }

//export is_blank
func is_blank(str string) bool { return len(str) == 0 }

//export adder
func adder(a, b int) (sum int) {
	sum = a + b
	fmt.Printf("sum: %v\n", sum)
	return sum
}

//export int_slice_size
func int_slice_size(slice []int) int { return len(slice) }

func main() {}
