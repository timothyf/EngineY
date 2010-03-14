require 'test_helper'

class ApiKeysControllerTest < ActionController::TestCase
  

  def test_create
    login_as(:sam)
    assert User.find(3).api_key == '', 'Incorrect api key'
    get :create
    assert_redirected_to edit_user_path(users(:sam))
    assert User.find(3).api_key.length > 1, 'Incorrect api key'
  end
  
  
  def test_destroy
    login_as(:quentin)
    assert User.find(1).api_key == 'testapikey', 'Incorrect api key'
    get :destroy
    assert_redirected_to edit_user_path(users(:quentin))
    assert User.find(1).api_key == '', 'Incorrect api key'
  end
  
  
end
