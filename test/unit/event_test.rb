require 'test_helper'

class EventTest < ActiveSupport::TestCase


  def test_start_time_validation
    assert events(:one).valid? == true, 'Expected valid event' 
    events(:one).start_time = nil
    assert events(:one).valid? == false, "Expected invalid event" 
    assert(events(:one).errors.invalid?(:start_time))
  end
  

  def test_end_time_validation
    assert events(:one).valid? == true, 'Expected valid event' 
    events(:one).end_time = nil
    assert events(:one).valid? == false, "Expected invalid event" 
    assert(events(:one).errors.invalid?(:end_time))
  end


  def test_name_validation
    assert events(:one).valid? == true, 'Expected valid event' 
    events(:one).name = nil
    assert events(:one).valid? == false, "Expected invalid event" 
    assert(events(:one).errors.invalid?(:name)) 
  end
  
  
  def test_log_activity_after_create
    event = Event.create({
                          :name => 'Test Event',
                          :user_id => 1,
                          :photo_id => 2,
                          :description => 'A new event for testing',
                          :event_type => 'Test',
                          :start_time => Time.now,
                          :end_time => Time.now,
                          :location => 'Michigan, USA',
                          :street => 'Richmond',
                          :city => 'Southgate',
                          :website => 'www.myevent.com',
                          :phone => '555-1212',
                          :organized_by => 'Joe Tester'              
                           })
    assert event, 'Failed to create book review' 
    act = Activity.find_by_item_id_and_item_type(event.id, 'Event')
    assert act, 'Failed to log activity' 
    assert act.user_id == event.user_id, 'Incorrecty user id'
    assert act.public == true, 'Should be public'
    assert act.item_id == event.id, 'Incorrect item id'
    assert act.item_type == 'Event', 'Incorrect item_type'
    assert act.action == nil, 'Incorrect action' 
  end
  
  

end
