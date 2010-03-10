require 'test_helper'

class AttendanceTest < ActiveSupport::TestCase


  def test_log_activity_after_create
    attend = Attendance.create({:attendee_id => '3',
                                :event_id => '2',
                                :status => '' })
    assert attend, 'Failed to create attendance' 
    act = Activity.find_by_item_id_and_item_type(attend.id, 'Attendance')
    assert act, 'Failed to log activity' 
    assert act.user_id == attend.attendee_id, 'Incorrecty user id'
    assert act.public == true, 'Should be public'
    assert act.item_id == attend.id, 'Incorrect item id'
    assert act.item_type == 'Attendance', 'Incorrect item_type'
    assert act.action == nil, 'Incorrect action' 
  end
  
end
