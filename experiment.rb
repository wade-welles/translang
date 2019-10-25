require 'ffi'
require 'benchmark'



module Translang
  extend FFI::Library

  def self.blank?(str) 
    return str.empty?
  end

  ffi_lib './translang.so'
  attach_function :hello_world, [], :void
  attach_function :print_text, [:string], :void
  attach_function :adder, [:int, :int], :int
  attach_function :is_blank, [:string], :bool
end

Translang.hello_world
Translang.print_text("test")
sum = Translang.adder(1, 2)

#"ruby is blank: #{Translang.blank?("test")}"
#"go is blank: #{Translang.is_blank("test")}"



Benchmark.bm 100 do |r| 
  r.report "ruby" do 
    Translang.blank?("test a really long sentence")
  end 
  r.report "go" do 
    Translang.is_blank("test a really long sentence")
  end 
end
