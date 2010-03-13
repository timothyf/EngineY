require 'test_helper'

class NetworksControllerTest < ActionController::TestCase


  def setup
    login_as(:quentin)
  end
  
  
  def test_should_get_edit
    get :edit, :id => networks(:one).id
    assert_response :success
    assert_not_nil assigns(:network)
  end


  def test_should_update_network
    put :update, :id => networks(:one).id, :network => { :name => 'Updated Network Name',
                                                         :organization => 'TestCo',
                                                         :website => 'www.website.com',
                                                         :description => 'This is a test network'}
    assert_redirected_to network_path(assigns(:network))
    assert_not_nil assigns(:network) 
    assert assigns(:network).name == 'Updated Network Name', 'Incorrect network name'
  end
  

end
