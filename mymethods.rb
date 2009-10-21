require 'pp'
class Object
  def self.my_methods
    ancs = self.class.ancestors - [self]
    #p [:ancs, ancs]
    not_my_methods = ancs.map { |klass| klass.methods }.flatten
    #p [:not_my_methods, not_my_methods]
    methods - not_my_methods    
  end
  def self.my_instance_methods
    not_my_methods = self.class.ancestors.map { |klass| klass.instance_methods }.flatten
    methods - not_my_methods    
  end
end
                                

class What
  def only_method
  end
end


p [:Class, Class.my_methods]
p [:Object, Object.my_methods]
p [:What, What.my_methods] 
