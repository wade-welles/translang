require 'ffi'

module Translang
  extend FFI::Library

  ffi_lib './translang.so'
  attach_function :hello_world, [], :void
  attach_function :print_text, [:string], :void
  attach_function :adder, [:int, :int], :int
end

Translang.hello_world
Translang.print_text("test")
sum = Translang.adder(1, 2)

