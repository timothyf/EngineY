require 'test_helper'


# This class provides tests for the RESTful API of the Group object.
class GroupsTest < ActionController::IntegrationTest
    
  # /groups.json
  test "get all groups" do
    get "/groups.json"
    assert_response :success
    groups = JSON.parse(response.body) 
    assert groups.size == 2
    check_group(groups[0]) 
  end
  
  
  # /groups/1.json
  test "get one group" do
    get "groups/1.json"
    assert_response :success
    group = JSON.parse(response.body)
    check_group(group) 
  end
  
  
  # /groups.xml
  def test_should_not_create_group_via_API
      get "/logout"
      post "/groups.xml", :group => {:name=>'unit test group',
                                 :description=>'my desc',
                                 :featured=>false}
      assert_response 401
  end
  
  
  # /groups.xml
  def test_should_create_group_via_API
      get "/logout"
      post "/groups.xml", :api_key=>'testapikey',
                          :group => {:name=>'unit test group',
                                     :description=>'my desc',
                                     :featured=>false}
      assert_response :created
      puts response.body
  end
  
  
  # /groups.json
  def test_should_create_group_via_API
      get "/logout"
      post "/groups.json", :api_key=>'testapikey',
                           :group => {:name=>'unit test group',
                                      :description=>'my desc',
                                      :featured=>false}
      assert_response :created
      puts response.body
      group = JSON.parse(response.body)
      check_new_group(group) 
  end
  
  
  private
  def check_group(group)
    assert group['name'] == 'Test Group 1', 'Incorrect name'
    assert group['private'] == false, 'Incorrect private'
    assert group['featured'] == false, 'Incorrect featured'
    assert group['creator_id'] == 1, 'Incorrect creator_id'
    assert group['description'] == 'group description', 'Incorrect description'
  end
  
  def check_new_group(group)
    assert group['name'] == 'unit test group', 'Incorrect name'
    assert group['private'] == false, 'Incorrect private'
    assert group['featured'] == false, 'Incorrect featured'
    assert group['creator_id'] == 1, 'Incorrect creator_id'
    assert group['description'] == 'my desc', 'Incorrect description'
  end
  
  # 
  
end