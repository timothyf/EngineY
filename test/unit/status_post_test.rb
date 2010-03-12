require 'test_helper'

class StatusPostTest < ActiveSupport::TestCase


  def test_log_activity_after_create
    post = StatusPost.create({
                             :user_id => 1,
                             :body => 'A Test Status Post'
                           })
    assert post, 'Failed to create status post' 
    act = Activity.find_by_item_id_and_item_type(post.id, 'StatusPost')
    assert act, 'Failed to log activity' 
    assert act.user_id == post.user_id, 'Incorrecty user id'
    assert act.public == true, 'Should be public'
    assert act.item_id == post.id, 'Incorrect item id'
    assert act.item_type == 'StatusPost', 'Incorrect item_type'
    assert act.action == nil, 'Incorrect action' 
  end


end
