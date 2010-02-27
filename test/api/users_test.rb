require 'test_helper'



# This class provides tests for the RESTful API of the User object.
class UsersTest < ActionController::IntegrationTest

  # GET ALL USERS  
  # /users.json
  def test_should_get_all_users_via_API_JSON
    get "/users.json", :api_key=>'testapikey'
    assert_response :success
    users = JSON.parse(response.body) 
    assert users.size == 38, 'Incorrect number of users'
    check_user(users[0]) 
  end
  

  # GET USERS SUBSET
  # /users.json?api_key=testapikey&limit=10
  def test_should_get_subset_users_via_API_JSON
    get "/users.json", :api_key=>'testapikey', :limit=>10
    assert_response :success
    users = JSON.parse(response.body) 
    assert users.size == 10, 'Incorrect number of users'
    check_user(users[0]) 
  end
  
  
  # GET USERS SUBSET WITH OFFSET
  # /users.json?api_key=testapikey&limit=10&offset=20
  def test_should_get_subset_with_offset_users_via_API_JSON
    get "/users.json", :api_key=>'testapikey', :limit=>10, :offset=>20
    assert_response :success
    users = JSON.parse(response.body) 
    assert users.size == 10, 'Incorrect number of users'
    assert users[0]['first_name'] == 'Test23', 'Incorrect first_name'
    assert users[0]['last_name'] == 'User', 'Incorrect last_name'
  end
  
  
  # GET USERS WITH FILTER
  # /users.json?api_key=testapikey&last_name=test
  def test_should_get_filtered_users_via_API_JSON
    get "/users.json?api_key=testapikey&last_name=test"
  #  assert_response :success
  #  users = JSON.parse(response.body) 
  #  assert users.size == 2, 'Incorrect number of users'
  #  assert users[0]['first_name'] == 'quentin', 'Incorrect first_name'
  #  assert users[0]['last_name'] == 'test', 'Incorrect last_name'
  #  assert users[1]['first_name'] == 'aaron', 'Incorrect first_name'
  #  assert users[1]['last_name'] == 'test', 'Incorrect last_name' 
  end
  
  
  # GET ONE USER 
  # /users/1.json
  def test_should_get_one_user_via_API_JSON
    get "users/1.json", :api_key=>'testapikey'
    assert_response :success, "Incorrect response type"
    user = JSON.parse(response.body)
    check_user(user) 
  end
  
  
  # CREATE A USER 
  # /users.xml
  def test_should_create_user_via_API_JSON
      get "/logout"
      post "/users.json", :api_key=>'testapikey',
                           :user => {:first_name => 'unit',
                                     :last_name => 'test',
                                     :twitter_id=>'uttwit',
                                     :login => 'ut1',
                                     :password => '12345',
                                     :password_confirmation => '12345',
                                     :email => 'ut@email.com'}
      assert_response :created, "Incorrect response type"
      user = JSON.parse(response.body)
      check_new_user(user) 
      user = User.find_by_login('ut1')
      assert user.active? == true, 'user should be active'
  end
  
  
  # CREATE A USER
  # /users.json
  def test_should_create_user_via_API_XML
      get "/logout"
      post "/users.xml",  :api_key=>'testapikey',
                          :user => {:first_name => 'unit',
                                     :last_name => 'test',
                                     :twitter_id=>'uttwit',
                                     :login => 'ut2',
                                     :password => '12345',
                                     :password_confirmation => '12345',
                                     :email => 'ut2@email.com'}
      assert_response :created, "Incorrect response type"
      user = User.find_by_login('ut2')
      assert user.active? == true, 'user should be active'
  end
  
  
  private
  def check_user(user)
    assert user['first_name'] == 'quentin', 'Incorrect first_name'
    assert user['last_name'] == 'test', 'Incorrect last_name'
    assert user['twitter_id'] == 'qtest', 'Incorrect twitter_id'
  end
  
  
  def check_new_user(user)
    assert user['first_name'] == 'unit', 'Incorrect first_name'
    assert user['last_name'] == 'test', 'Incorrect last_name'
    assert user['twitter_id'] == 'uttwit', 'Incorrect twitter_id'  
  end
  
  # 
  
end