require 'ffi'
#require 'benchmark'

module Go
  extend FFI::Library
  class Slice < FFI::Struct
    layout :data,  :pointer,
           :len,   :long_long,
           :cap,   :long_long 

    def self.value 
      return self.val
    end

    def initialize(slice)
      self[:data] = FFI::MemoryPointer.new(:long_long, slice.size)
      self[:len] = slice.size
      self[:cap] = slice.size 
      return self
    end
  end

  # define class GoSlice to map to:
  # C type struct { void *data; GoInt len; GoInt cap; }
  class IntSlice < FFI::Struct
    layout :data,  :pointer,
           :len,   :long_long,
           :cap,   :long_long 

    def self.value 
      return self.val
    end

    def initialize(slice)
      self[:data] = FFI::MemoryPointer.new(:long_long, slice.size)
      self[:data].write_array_of_long_long(slice)
      self[:len] = slice.size
      self[:cap] = slice.size 
      return self
    end
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
    attach_function :int_slice_size, [IntSlice.value], :int
  end
end

Go::Functions.greeter(Go::String.new("test"))

p "size: #{Go::Functions.int_slice_size(Go::IntSlice.new([5, 3, 2]))}"
