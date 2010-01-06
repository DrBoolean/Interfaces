require 'test_helper'

class Mappable < Interface
  def latitude(); end
  def longitude(); end
end

class Booty < Interface
  def shine(); end
end

class Treasure
  extend RescueRangers::Implementer
  implements :mappable, :booty
  
  def latitude
    "some latitude"
  end
  
  # purposely missing longitude() and shine()
end


class InterfacesTest < ActiveSupport::TestCase

  def setup
    @treasure = Treasure.new
  end
  
  test "should return a list of implementers" do
    assert Booty.implementers.include?(Treasure)
  end
  
  test "should return a list of interfaces" do
    assert Treasure.interfaces.include?(Mappable)
    assert Treasure.interfaces.include?(Booty)
  end
  
  test "should work normally for correctly implemented methods" do
    assert @treasure.latitude
  end

  test "should raise an error on missing interface implementation" do
    assert_raises(Interface::ImplementationError){ @treasure.shine }
  end
  
  test "should raise an error on only partially missing interface implementation" do
    assert_raises(Interface::ImplementationError){ @treasure.longitude }
  end
  
  test "should raise a normal no method error if the method required by an interface" do
    assert_raises(NoMethodError){ @treasure.steal }
  end
end
