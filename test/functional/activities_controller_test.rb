require 'test_helper'

class ActivitiesControllerTest < ActionController::TestCase

  def test_should_get_index
    login_as(:quentin)
    get :index
    assert_response :success
    assert_not_nil assigns(:activities)
  end
  
end
