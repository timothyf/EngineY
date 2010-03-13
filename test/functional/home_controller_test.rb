require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  
  
  def test_get_install 
    get :install
    assert_response :success
    assert_not_nil assigns(:network)
    assert assigns(:network).name == 'Install', 'Incorrect network name'
  end
  
  
  def test_do_install
    get :do_install, :network_name => 'Test Network',
                     :network_org => 'Test Org',
                     :network_website => 'www.test.com',
                     :network_desc => 'Network Description',
                     :first_name => 'John',
                     :last_name => 'Doe',
                     :email => 'john@doe.com',
                     :login => 'jdoe',
                     :password => '12345678',
                     :password_confirmation => '12345678'
    assert_redirected_to '/'
    assert Network.find(:all).length == 1, 'Incorrect number of networks'
    network = Network.find(:first)
    assert network.name == 'Test Network'
    assert network.organization == 'Test Org'
    assert network.website == 'www.test.com'
    assert network.description == 'Network Description'
    assert User.find(:all).length == 1, 'Incorrect number of users'
    user = User.find(:first)
    assert user.first_name == 'John'
    assert user.last_name == 'Doe'
    assert user.email == 'john@doe.com'
    assert user.login == 'jdoe'
  end
  
  
  def test_get_index
    get :index
    assert_response :success
    assert :template=>'index'
    assert_not_nil assigns(:section)
    assert_not_nil assigns(:home_widgets)  
    assert_not_nil assigns(:photos)   
    
    assert assigns(:section) == 'MAIN', 'Incorrect section'
    assert assigns(:photos).length <= 6, 'Too many photos returned'
  end
  
  
end
