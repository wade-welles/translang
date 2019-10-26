# Translang Experiments

Experiments combining Ruby and Go using ffi and potentially other ways with the goal of exploring, experimenting and researching the available options for building multi-language software 

______
Below are the various methods with tests built:

##### FFI 
Using `cgo` and `ffi` gem to establish a Ruby `module` and add Go functions
stored in a `cgo` compiled `*.so` shared library file. 

_____ 

# Improving CGO 

**Verbosity**
Can we just have something that exports all the public functions automatically
without needing to add extern above it? 

Even if it just took our file and added `extern FuncName` to all the pubic functions (and
the `import "C"` and whatever else before passing it to the compiler. 

**Working with strings** 
Can we not just have exported functions using string as import and export just
simply have a wrapper function that handles the `C.GoString` and `C.CString`
calls so its passed into the function as the expected type?

