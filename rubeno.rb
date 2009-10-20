module Rubeno

  metodoj = File.read("metodoj.txt").split(" ")
  
  (metodoj.length / 2).times do
    alias_method metodoj.pop.to_sym, metodoj.pop.to_sym
  end

  class Object #ditto for String, Array, etc.
    alias foo bar
    #loop through every method of the class
    #check if each one is in the translation hash
    # ObjectSpace.each_object(Module) {|mod| mod.class_eval { ... } }
    instance_methods.each{|id| alias_method trans[id], id if trans.key? id }
  end

end  
  

include Rubeno
vidigu "Saluton, mondo!"
