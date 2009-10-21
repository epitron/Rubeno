require 'pp'

class Object
  
  # the class on which class methods are defined
  #def self.metaclass; class << self; self; end; end
  def metaclass; class << self; self; end; end
  
  def alias_class_method(to, from)
    metaclass.send(:alias_method, to, from)
  end
  
end  


module Rubeno
  
  def self.translate_object(obj, meths, table)
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
  
    all_constants = Object.constants.map{|x|x.to_sym} - [:Kernel]
    p all_constants
    
    for const in all_constants
      obj = Object.const_get const
      next unless obj.is_a? Class
      
      # class methods
      translate_object(obj.metaclass, obj.methods(false), table)
      
      # instance methods
      translate_object(obj, obj.instance_methods(false), table)
    end

    # private kernel instance methods
    translate_object(Kernel, Kernel.private_instance_methods(false), table)
  end    
    

end  
  

if $0 == __FILE__
  #include Rubeno
  Rubeno.translate!
  
  vidigu "Saluton, mondo!"
  p "asdfasdfsd".longo
end
