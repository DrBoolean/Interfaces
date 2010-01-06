class Interface
  ImplementationError = Class.new(StandardError)
  
  def self.implementers
    @implementers ||= []
  end
    
  def self.required_methods
    self.instance_methods(false)
  end
  
end
