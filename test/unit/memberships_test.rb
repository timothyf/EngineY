require 'test_helper'

class MembershipsTest < ActiveSupport::TestCase


  def test_log_activity_after_create
    membership = Membership.create({
                             :user_id => 1,
                             :group_id => 1,
                             :role_id => 3 
                           })
    assert membership, 'Failed to create membership' 
    act = Activity.find_by_item_id_and_item_type(membership.id, 'Membership')
    assert act, 'Failed to log activity' 
    assert act.user_id == membership.user_id, 'Incorrecty user id'
    assert act.public == true, 'Should be public'
    assert act.item_id == membership.id, 'Incorrect item id'
    assert act.item_type == 'Membership', 'Incorrect item_type'
    assert act.action == nil, 'Incorrect action' 
  end
  
  
  def test_user_count
    count = Membership.user_count
    assert count == 2, 'Unexpected membership count'
  end
  
  
end
