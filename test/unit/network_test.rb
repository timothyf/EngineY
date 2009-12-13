require 'test_helper'

class NetworkTest < ActiveSupport::TestCase

  test "should init network" do
    assert "Test Network", Network.find(:first).name
    
    network = Network.find(:first)
    
    network.init_network
    
  end
  
end
