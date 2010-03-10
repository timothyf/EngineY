require 'test_helper'

class JobPostTest < ActiveSupport::TestCase


  def test_log_activity_after_create
    job = JobPost.create({
                             :job_title => 'Test Job Title',
                             :job_id => 123,
                             :company => 'My Company',
                             :website => 'www.mycompany.com',
                             :contact_name => 'Joe Jobbee',
                             :email => 'joe@jobbee.com',
                             :description => 'This is a great job',
                             :featured => false,
                             :end_date => Time.now    
                           })
    assert job, 'Failed to create job post' 
    act = Activity.find_by_item_id_and_item_type(job.id, 'JobPost')
    assert act, 'Failed to log activity' 
    assert act.user_id == nil, 'Incorrecty user id'
    assert act.public == true, 'Should be public'
    assert act.item_id == job.id, 'Incorrect item id'
    assert act.item_type == 'JobPost', 'Incorrect item_type'
    assert act.action == nil, 'Incorrect action' 
  end
  
  
end
