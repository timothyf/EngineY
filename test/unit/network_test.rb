require 'test_helper'

class NetworkTest < ActiveSupport::TestCase

  def test_should_init_network
    assert "Test Network", Network.find(:first).name   
    network = Network.find(:first)
    Role.destroy_all
    assert Role.find(:first) == nil
    network.init_network  
    roles = Role.find(:all)
    assert roles.length == 5  
    assert roles[0].rolename == 'creator'
    assert roles[1].rolename == 'administrator'
    assert roles[2].rolename == 'group_admin'
    assert roles[3].rolename == 'user'
    assert roles[4].rolename == 'contributor'
  end
  
  
  def test_should_get_first_network
    network = Network.network
    assert network == Network.find(:first) 
  end
  
end
