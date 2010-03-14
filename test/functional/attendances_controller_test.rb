require 'test_helper'

class AttendancesControllerTest < ActionController::TestCase


  def test_get_index
    get :index, :event_id => 1
    assert_response :success
    assert_not_nil assigns(:event)
    assert_not_nil assigns(:attendees)
    assert_not_nil assigns(:title)
  end
  
  
  def test_create
    post :create, :event_id => 1, :user_id => 1
    assert_redirected_to event_path(1)
  end
  
  
end
