package main

import "C"

import (
	"fmt"
)

//export hello_world
func hello_world() {
	fmt.Printf("hello world\n")
}

//export print_text
func print_text(cstr *C.char) {
	fmt.Printf("%v\n", C.GoString(cstr))
}

//export adder
func adder(a, b int) (sum int) {
	sum = a + b
	fmt.Printf("sum: %v\n", sum)
	return sum
}

//export is_blank
func is_blank(str *C.char) bool {
	return len(C.GoString(str)) == 0
}

func main() {}
