require 'test_helper'


# This class provides tests for the RESTful API of the Group object.
class MembershipsTest < ActionController::IntegrationTest

  fixtures :memberships
  
  
  # GET ONE MEMBERSHIP BY MEMBERSHIP ID
  test "get one membership" do
    get "memberships/2.json", :api_key=>'testapikey'
    assert_response :success
    membership = JSON.parse(response.body)
    assert membership['user_id'] == 1, 'Incorrect user id'
    assert membership['group_id'] == 2, 'Incorrect group id' 
  end
  
  
  # GET ONE MEMBERSHIP BY USER ID AND GROUP ID
  test "get one membership by user and group" do
    get "memberships/find.json?api_key=testapikey&user_id=4&group_id=1"
    assert_response :success
    membership = JSON.parse(response.body)
    assert membership['user_id'] == 4, 'Incorrect user id'
    assert membership['group_id'] == 1, 'Incorrect group id' 
  end
  

  # JOIN A GROUP AS ADMIN
  # User is an admin so he will become a group admin
  def test_should_join_a_group_as_admin_via_API_JSON
      get "/logout"
      post "/memberships.json", :api_key => 'testapikey',
                                :group_id => 1,
                                :user_id => 1
      assert_response :created
      membership = JSON.parse(response.body)
      assert membership['user_id'] == 1, 'Incorrect user id'
      assert membership['group_id'] == 1, 'Incorrect group id'
      assert membership['role_id'].to_i == Role.find_by_rolename('group_admin').id, 'Incorrect role id' 
  end
  
  
  # JOIN A GROUP AS USER
  def test_should_join_a_group_as_user_via_API_JSON
      get "/logout"
      post "/memberships.json", :api_key => 'testapikey',
                                :group_id => 1,
                                :user_id => 3
      assert_response :created
      membership = JSON.parse(response.body)
      assert membership['user_id'] == 3, 'Incorrect user id'
      assert membership['group_id'] == 1, 'Incorrect group id'
      assert membership['role_id'].to_i == Role.find_by_rolename('user').id, 'Incorrect role id' 
  end
  
  
  # PROMOTE A GROUP USER TO GROUP ADMIN
  def test_should_update_group_user_via_API_JSON
    # lookup user's membership
    get "memberships/find.json?api_key=testapikey&user_id=4&group_id=1"
    membership = JSON.parse(response.body)
    membership_id = membership['id']
    assert membership_id == 3, 'Incorrect membership id'
    assert membership['role_id'] == Role.find_by_rolename('user').id, 'Incorrect role id'
    
    # promote user to group admin
    put "/memberships/#{membership_id}.xml", :api_key => 'testapikey',
                             :membership => {:user_id => 4,
                                             :group_id => 1,
                                             :role_id => Role.find_by_rolename('group_admin') }
    assert_response :success
  end
  
  
  # INVITE USER TO GROUP
  def test_should_create_group_invite_via_API_JSON
    
  end
  
  
  # LEAVE A GROUP
  def test_should_leave_a_group_API_JSON
    # join group
    post "/memberships.json", :api_key => 'testapikey',
                              :group_id => 1,
                              :user_id => 3
                              
    # leave group
    delete "/memberships/destroy.json", :api_key => 'testapikey',
                                :user_id => 3,
                                :group_id => 1
    assert_response :success
  end
  
  
end