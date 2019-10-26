require 'ffi'
#require 'benchmark'

module Go
  extend FFI::Library
  # define class GoSlice to map to:
  # C type struct { void *data; GoInt len; GoInt cap; }
  class Slice < FFI::Struct
    layout :data,  :pointer,
           :len,   :long_long,
           :cap,   :long_long 

  end

  # define class GoString to map:
  # C type struct { const char *p; GoInt n; }
  class String < FFI::Struct
    layout :p,     :pointer,
           :len,   :long_long

    def self.value 
      return self.val 
    end

    def initialize(str) 
      self[:p] = FFI::MemoryPointer.from_string(str) 
      self[:len] = str.size
      return self
    end
  end

  module Functions
    extend FFI::Library
    ffi_lib './go.so'
    attach_function :greeter, [String.value], :void
    attach_function :is_blank, [:string], :bool
  end
end

Go::Functions.greeter(Go::String.new("test"))
