require 'test_helper'

class AttendancesControllerTest < ActionController::TestCase


  def test_get_index
    get :index, :event_id => 1
    assert_response :success
    assert_not_nil assigns(:event)
    assert_not_nil assigns(:attendees)
    assert_not_nil assigns(:title)
    assert assigns(:attendees).length == 2, 'Incorrect number of attendees'
    assert (assigns(:attendees)[0].id == 3) || (assigns(:attendees)[0].id == 1)
    assert assigns(:attendees)[1].id == 1 || assigns(:attendees)[1].id == 3
    assert assigns(:event).id == 1
    assert assigns(:title) == 'Attendees for Test Event 1'
  end
  
  
  def test_create
    post :create, :event_id => 1, :user_id => 1
    assert_not_nil assigns(:attendance)
    assert assigns(:attendance).event_id == 1, 'Incorrect event id'
    assert assigns(:attendance).attendee_id == 1, 'Incorrect user id'
    assert_redirected_to event_path(1)
  end
  
  
  def test_destroy
    assert_difference('Attendance.count', -1) do
      delete :destroy, :user_id => '3', :event_id => '1'
    end
    assert_redirected_to event_path(1)
  end
  
  
end
