require 'test_helper'

class WidgetsControllerTest < ActionController::TestCase

  
  def test_grid_data
    get :grid_data, :rows => 10
    assert_response :success
    assert_not_nil assigns(:widgets)
  end
  
  
end
