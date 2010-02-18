require 'test_helper'
require 'rest_client'

# Make sure that the server is running before running this test.
# This class provides tests for the RESTful API of the User object.
class UsersTest < ActiveSupport::TestCase

  # http://localhost:3000/users.json
  test "get all users" do
    result = RestClient.get 'http://localhost:3000/users.json'
    users = JSON.parse(result)
    assert users.size == 10
    check_user(users[0])
  end
  
  
  # http://localhost:3000/users/1.json
  test "get one user" do
    result = RestClient.get 'http://localhost:3000/users/1.json'
    user = JSON.parse(result)
    check_user(user) 
  end
  
  
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