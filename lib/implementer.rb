module RescueRangers
module Implementer
    
  def interfaces
    @interfaces ||= []
  end

  def implements(*args)
    args.each do |arg|
      interface = arg.to_s.camelize.constantize
      interface.implementers << self
      self.interfaces << interface
      self.send(:include, InstanceMethods)
    end
  end
  
  module InstanceMethods

    def method_missing(name, *args)
      if interface = self.class.interfaces.detect{ |i| i.required_methods.include?(name.to_s) }
        raise(Interface::ImplementationError, "#{interface} requires that #{self} implement #{name}")
      else
        super
      end
    end
  end

end
end
