require 'test_helper'


# This class provides tests for the RESTful API of the Follow object.
class FollowsTest < ActionController::IntegrationTest
  
  # GET LIST OF USERS BEING FOLLOWED BY USER, i.e. who do I follow
  # gets followees of user specified by user param, not by user logged in
  def test_get_users_followees
    get "/users/1/follows.json?type=followees&api_key=testapikey"
    assert_response :success
    follows = JSON.parse(response.body)
    assert follows.size == 4, 'Incorrect number of followees'
    assert follows[0]['id'] == 1
    assert follows[0]['followee_id'] == 3
    assert follows[1]['id'] == 3
    assert follows[1]['followee_id'] == 8
    assert follows[2]['id'] == 4
    assert follows[2]['followee_id'] == 9
    assert follows[3]['id'] == 5
    assert follows[3]['followee_id'] == 10
    
    #now get followees of a different user, but same api key
    get "/users/3/follows.json?type=followees&api_key=testapikey"
    assert_response :success
    follows = JSON.parse(response.body)
    assert follows.size == 2, 'Incorrect number of followees'
    assert follows[0]['followee_id'] == 5
    assert follows[1]['followee_id'] == 10
    
    # another way of getting followees
    get "/follows.json?user_id=3&type=followees&api_key=testapikey"
    assert_response :success
    follows = JSON.parse(response.body)
    assert follows.size == 2, 'Incorrect number of followees'
    assert follows[0]['followee_id'] == 5
    assert follows[1]['followee_id'] == 10
  end
  
  
  # GET LIST OF USERS WHO FOLLOW USER
  # gets followers of user specified by user param, not by user logged in
  def test_get_users_who_follow_user
    get "/users/1/follows.json?type=followers&api_key=testapikey"
    assert_response :success
    follows = JSON.parse(response.body)
    assert follows.size == 3, 'Incorrect number of followees'
    assert follows[0]['id'] == 7
    assert follows[0]['follower_id'] == 9
    assert follows[1]['id'] == 8
    assert follows[1]['follower_id'] == 10
    assert follows[2]['id'] == 9
    assert follows[2]['follower_id'] == 11
  end
  
  
  # START FOLLOWING A USER i.e. user 6 starts following user 3
  #  user adding the follow is specified by login, i.e. the apikey
  #  bobbyapikey results in user with ID=6 being logged in
  def test_start_following_a_user
    post "/follows.json?api_key=bobbyapikey&followee_id=3"                             
    assert_response :created
    follow = JSON.parse(response.body) 
    assert follow['follower_id'] == 6
    assert follow['followee_id'] == 3
  end
  
  
  # STOP FOLLOWING A USER
  def test_stop_following_a_user
   # delete "/follows/destroy.json", :api_key => 'testapikey',
   #                             :followee_id => 3
   # assert_response :success
  end
  
  
end