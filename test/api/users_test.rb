require 'test_helper'



# This class provides tests for the RESTful API of the User object.
class UsersTest < ActionController::IntegrationTest

  # /users.json
  test "get all users" do
    get "/users.json"
    assert_response :success
    users = JSON.parse(response.body) 
    assert users.size == 2
    check_user(users[0]) 
  end
  
  
  # /users/1.json
  test "get one user" do
    get "users/1.json"
    assert_response :success
    user = JSON.parse(response.body)
    check_user(user) 
  end
  
  
  # /users.xml
  def test_should_create_user_via_API
      get "/logout"
      post "/users.xml", :user => {:first_name => 'unit',
                                   :last_name => 'test',
                                   :twitter_id=>'uttwit',
                                   :login => 'ut',
                                   :password => '12345',
                                   :password_confirmation => '12345',
                                   :email => 'ut@email.com'}
      assert_response :created
  end
  
  
  # /users.json
  def test_should_create_user_via_API
      get "/logout"
      post "/users.json", :user => {:first_name => 'unit',
                                     :last_name => 'test',
                                     :twitter_id=>'uttwit',
                                     :login => 'ut2',
                                     :password => '12345',
                                     :password_confirmation => '12345',
                                     :email => 'ut2@email.com'}
      assert_response :created
      user = JSON.parse(response.body)
      check_new_user(user) 
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