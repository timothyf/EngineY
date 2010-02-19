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
  def test_should_not_create_user_via_API
      get "/logout"
      post "/users.xml", :user => {:name=>'unit test user',
                                 :description=>'my desc',
                                 :featured=>false}
      assert_response 401
  end
  
  
  # /users.xml
  def test_should_create_user_via_API
      get "/logout"
      post "/users.xml", :api_key=>'testapikey',
                          :user => {:name=>'unit test user',
                                     :description=>'my desc',
                                     :featured=>false}
      assert_response :created
      puts response.body
  end
  
  
  # /users.json
  def test_should_create_user_via_API
      get "/logout"
      post "/users.json", :api_key=>'testapikey',
                           :user => {:name=>'unit test user',
                                      :description=>'my desc',
                                      :featured=>false}
      assert_response :created
      puts response.body
      user = JSON.parse(response.body)
      check_new_user(user) 
  end
  
  
  private
  def check_user(user)
    assert user['first_name'] == 'Timothy', 'Incorrect first_name'
    assert user['last_name'] == 'Fisher', 'Incorrect last_name'
    assert user['twitter_id'] == 'tfisher', 'Incorrect twitter_id'
    assert user['city'] == 'Flat Rock', 'Incorrect city'
    assert user['receive_emails'] == true , 'Incorrect receive_emails'
    assert user['facebook_url'] == 'http://www.facebook.com/trfisher', 'Incorrect facebook_url'
  end
  
  
  # 
  
end