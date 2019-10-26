require 'ffi'
require 'benchmark'



module Go
  extend FFI::Library
  ffi_lib './translang.so'

  # define class GoSlice to map to:
  # C type struct { void *data; GoInt len; GoInt cap; }
  class GoSlice < FFI::Struct
    layout :data,  :pointer,
           :len,   :long_long,
           :cap,   :long_long 

  end

  # define class GoString to map:
  # C type struct { const char *p; GoInt n; }
  class GoString < FFI::Struct
    layout :p,     :pointer,
           :len,   :long_long
    def initialize(str) 
      self[:p] = FFI::MemoryPointer.from_string(str) 
      self[:len] = str.size
      return self
    end
  end

  attach_function :hello_world, [], :void
  attach_function :print, [:string], :void 
  attach_function :greeter, [GoString.by_value], :void
  attach_function :adder, [:int, :int], :int
  attach_function :is_blank, [:string], :bool
end

Go.hello_world
Go.print("test")
sum = Go.adder(1, 2)

test = Go::GoString.new("test")
Go.greeter(test)
