require 'test_helper'


# This class provides tests for the RESTful API of the Invite object.
class FriendshipsTest < ActionController::IntegrationTest
  
  # GET A USERS FRIENDS
  # /users/1/friends
  test "get a users friends" do
    get "/users/1/friends.json", :api_key=>'testapikey'
    assert_response :success
    friends = JSON.parse(response.body) 
    assert friends.size == 2, 'Incorrect number of friends expected'
    check_friend(friends[0]) 
  end
  
  
  # GET A USERS REQUESTED FRIENDS
  # /users/1/friends.json?type=requested
  test "get a users requested friends" do
    get "/users/1/friends.json?type=requested&api_key=testapikey"
    assert_response :success
    friends = JSON.parse(response.body) 
    assert friends.size == 1, 'Incorrect number of friends expected'
    
    assert friends[0]['id'] == 2, 'Incorrect friend id'
    assert friends[0]['login'] == 'aaron', 'Incorrect friend login'
    assert friends[0]['first_name'] == 'aaron', 'Incorrect friend first name' 
    assert friends[0]['last_name'] == 'test', 'Incorrect friend last name'
  end
  
  
  # GET A USERS PENDING FRIENDS
  # /users/1/friends.json?type=pending
  test "get a users pending friends" do
    get "/users/1/friends.json?type=pending&api_key=testapikey"
    assert_response :success
    friends = JSON.parse(response.body) 
    assert friends.size == 1, 'Incorrect number of friends expected'
    
    assert friends[0]['id'] == 3, 'Incorrect friend id'
    assert friends[0]['login'] == 'sfisher', 'Incorrect friend login'
    assert friends[0]['first_name'] == 'sam', 'Incorrect friend first name' 
    assert friends[0]['last_name'] == 'fisher', 'Incorrect friend last name'
  end
  
  
  # CREATE A FRIEND REQUEST
  # /users/1/friends.json
  test "create a friend request" do
    post "/users/1/friends.json", :api_key => 'testapikey',
                                  :user_id => 1,
                                  :friend_id => 6                               
    assert_response :created
    friend = JSON.parse(response.body) 
    assert friend['id'] == 6, 'Incorrect friend id'
    assert friend['login'] == 'bobby', 'Incorrect friend login'
  end
  
  
  # ACCEPT A FRIEND REQUEST
  # /users/1/friends/update
  test "accept a friend request" do
    get '/logout'
    # first create the request
    post "/users/6/friends.json", :api_key => 'bobbyapikey',
                                  :user_id => 6,
                                  :friend_id => 1  
    assert_response :created
    get '/logout'
    
    # now accept the reqeust
    put "/users/1/friends/6.json", :api_key => 'testapikey',
                                   :user_id => 1,
                                   :friend_id => 6                               
    assert_response :created
    friend = JSON.parse(response.body) 
    assert friend['id'] == 6, 'Incorrect friend id'
    assert friend['login'] == 'bobby', 'Incorrect friend login'
  end
  

  private
  def check_friend(friend)
    assert friend['id'] == 4, 'Incorrect friend id'
    assert friend['login'] == 'henry', 'Incorrect friend login'
    assert friend['first_name'] == 'henry', 'Incorrect friend first name' 
    assert friend['last_name'] == 'test', 'Incorrect friend last name'
  end
  
end