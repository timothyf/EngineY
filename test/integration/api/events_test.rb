require 'test_helper'
require 'json'


# This class provides tests for the RESTful API of the Event object.
class EventsTest < ActionController::IntegrationTest
  
  # GET ALL EVENTS  
  # /events.json
  test "get all events" do
    get "/events.json", :api_key=>'testapikey'
    assert_response :success
    events = JSON.parse(response.body) 
    assert events.size == 2
    check_event(events[0]) 
  end
  
  
  # GET ONE EVENT
  # /events/1.json
  test "get one event" do
    get "events/1.json", :api_key=>'testapikey'
    assert_response :success
    event = JSON.parse(response.body)
    check_event(event) 
  end
  
  
  # TRY TO CREATE A EVENT
  # /events.xml
  def test_should_not_create_event_via_API_XML
      get "/logout"
      post "/events.xml", :event => {:name => 'Test API Event 1',
                                   :start_time => Time.now.to_s(:db),
                                   :end_time => Time.now.to_s(:db),
                                   :user_id => 1,
                                   :description => 'Test API Event 1 Desc',
                                   :event_type => 'API Type',
                                   :location_id => 1,
                                   :website => 'http://www.test.com',
                                   :organized_by => 'API Testers of America'}
      assert_response 401
  end
  

  
  # CREATE A EVENT
  # /events.xml
  def test_should_create_event_via_API_XML
      get "/logout"



      post "/events.xml", :api_key=>'testapikey',
                          :event => {:name => 'Test API Event 1',
                                   :start_time => Time.now.to_s(:db),
                                   :end_time => Time.now.to_s(:db),
                                   :user_id => 1,
                                   :description => 'Test API Event 1 Desc',
                                   :event_type => 'API Type',
                                   :location_id => 1,
                                   :website => 'http://www.test.com',
                                   :organized_by => 'API Testers of America'}
      assert_response :created
  end
  
  
  # CREATE A EVENT
  # /events.json
  def test_should_create_event_via_API_JSON
    get "/logout"
    post "/events.json", :api_key => 'testapikey',
                         :event => {:name => 'Test API Event 1',
                                   :start_time => Time.now.to_s(:db),
                                   :end_time => Time.now.to_s(:db),
                                   :user_id => 1,
                                   :description => 'Test API Event 1 Desc',
                                   :event_type => 'API Type',
                                   :location_id => 1,
                                   :street => 'Testers Rd.',
                                   :city => 'TestTown',
                                   :website => 'http://www.test.com',
                                   :phone => '555-555-5555',
                                   :organized_by => 'API Testers of America'}
    assert_response :created
    event = JSON.parse(response.body)
    check_new_event(event) 
  end
  
  
  # TRY TO UPDATE A EVENT
  def test_should_update_event_via_API_XML
    get "/logout"
    put "/events/1.xml", :event => {:name => 'Test API Event 1',
                                   :start_time => Time.now.to_s(:db),
                                   :end_time => Time.now.to_s(:db),
                                   :user_id => 1,
                                   :description => 'Test API Event 1 Desc',
                                   :event_type => 'API Type',
                                   :location => 'Testville, USA',
                                   :street => 'Testers Rd.',
                                   :city => 'TestTown',
                                   :website => 'http://www.test.com',
                                   :phone => '555-555-5555',
                                   :organized_by => 'API Testers of America'}
    assert_response 401
  end
  
  
  # UPDATE A EVENT
  def test_should_update_event_via_API_XML
    get "/logout"
    put "/events/1.xml", :api_key => 'testapikey',
                         :event => {:name => 'Test API Event 1',
                                   :start_time => Time.now.to_s(:db),
                                   :end_time => Time.now.to_s(:db),
                                   :user_id => 1,
                                   :description => 'Test API Event 1 Desc',
                                   :event_type => 'API Type',
                                   :location_id => 1,
                                   :street => 'Testers Rd.',
                                   :city => 'TestTown',
                                   :website => 'http://www.test.com',
                                   :phone => '555-555-5555',
                                   :organized_by => 'API Testers of America'}
    assert_response :success
  end
  
  
  # UPDATE A EVENT
  def test_should_update_event_via_API_JSON
    get "/logout"
    put "/events/1.json", :api_key => 'testapikey',
                         :event => {:name => 'Test API Event 1',
                                   :start_time => Time.now.to_s(:db),
                                   :end_time => Time.now.to_s(:db),
                                   :user_id => 1,
                                   :description => 'Test API Event 1 Desc',
                                   :event_type => 'API Type',
                                   :location_id => 1,
                                   :street => 'Testers Rd.',
                                   :city => 'TestTown',
                                   :website => 'http://www.test.com',
                                   :phone => '555-555-5555',
                                   :organized_by => 'API Testers of America'}
    assert_response :success
  end
  
  
  private
  def check_event(event)
    assert event['name'] == 'Test Event 1', 'Incorrect name'
    assert event['description'] == 'Test Event 1 Desc', 'Incorrect description'
    assert event['event_type'] == 'Test Type', 'Incorrect event type'
    assert event['location_id'] == 1
    assert event['street'] == 'Testers Rd.', 'Incorrect street'
    assert event['city'] == 'TestTown', 'Incorrect city'
  end
  
  def check_new_event(event)
    assert event['name'] == 'Test API Event 1', 'Incorrect name'
    assert event['description'] == 'Test API Event 1 Desc', 'Incorrect description'
    assert event['event_type'] == 'API Type', 'Incorrect event type'
    assert event['location_id'] == 1
    assert event['street'] == 'Testers Rd.', 'Incorrect street'
    assert event['city'] == 'TestTown', 'Incorrect city'
  end
  
  # 
  
end