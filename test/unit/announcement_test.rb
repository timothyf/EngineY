require 'test_helper'

class AnnouncementTest < ActiveSupport::TestCase


  def test_log_activity_after_create
    announc = Announcement.create({:title => 'Test Announcement',
                                   :body => 'This is a unit test announcement',
                                   :user_id => '1',
                                   :group_id => '' })
    assert announc, 'Failed to create announcement' 
    act = Activity.find_by_item_id_and_item_type(announc.id, 'Announcement')
    assert act, 'Failed to log activity' 
    assert act.user_id == announc.user_id, 'Incorrecty user id'
    assert act.public == true, 'Should be public'
    assert act.item_id == announc.id, 'Incorrect item id'
    assert act.item_type == 'Announcement', 'Incorrect item_type'
    assert act.action == nil, 'Incorrect action' 
  end
end
