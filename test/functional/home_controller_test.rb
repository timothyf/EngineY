require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert :template=>'index'
    assert_not_nil assigns(:section)
    assert_not_nil assigns(:home_widgets)  
    assert_not_nil assigns(:photos)
    
  end
end
