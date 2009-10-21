require 'pp'

  
module Rubeno
  def self.translate_object(obj, meths, table)
    p [obj, obj.class]
    
    for meth in meths
      if esps = table[meth]
        for esp in esps
          p [:renaming, obj, meth, esp]
          obj.send(:alias_method, esp, meth)
        end
      end
    end                             
  end
    
  
  def self.translate!
    table = Hash.new { |h, k| h[k] = [] }
    
    for line in open("metodoj.txt")
      eng, esp = line.split(" ")
      if eng.nil? or esp.nil?
        puts "YOU ARE A BAD LINE: #{line.inspect}"
        next
      end
      table[eng] << esp
      
    end
  
    for const in Object.constants
      obj = Object.const_get const
      next unless obj.is_a? Class
      
      translate_object(obj, obj.methods, table) do ||
      end
      
      translate_object(obj, obj.instance_methods, table) do ||
      end
    end
    
    exit 1
  end    
    
=begin
  class Object #ditto for String, Array, etc.
    alias foo bar
    #loop through every method of the class
    #check if each one is in the translation hash
    # ObjectSpace.each_object(Module) {|mod| mod.class_eval { ... } }
    instance_methods.each{|id| alias_method trans[id], id if trans.key? id }
  end
=end

end  
  
#include Rubeno
Rubeno.translate!

vidigu "Saluton, mondo!"

