require 'test_helper'


# This class provides tests for the RESTful API of the Group object.
class GroupsTest < ActionController::IntegrationTest
  
  # GET ALL GROUPS  
  # /groups.json
  test "get all groups" do
    get "/groups.json"
    assert_response :success
    groups = JSON.parse(response.body) 
    assert groups.size == 2
    check_group(groups[0]) 
  end
  
  
  # GET ONE GROUP
  # /groups/1.json
  test "get one group" do
    get "groups/1.json"
    assert_response :success
    group = JSON.parse(response.body)
    check_group(group) 
  end
  
  
  # TRY TO CREATE A GROUP
  # /groups.xml
  def test_should_not_create_group_via_API_XML
      get "/logout"
      post "/groups.xml", :group => {:name=>'unit test group',
                                 :description=>'my desc',
                                 :featured=>false}
      assert_response 401
  end
  
  
  # CREATE A GROUP
  # /groups.xml
  def test_should_create_group_via_API_XML
      get "/logout"
      post "/groups.xml", :api_key=>'testapikey',
                          :group => {:name=>'unit test group',
                                     :description=>'my desc',
                                     :featured=>false}
      assert_response :created
  end
  
  
  # CREATE A GROUP
  # /groups.json
  def test_should_create_group_via_API_JSON
    get "/logout"
    post "/groups.json", :api_key => 'testapikey',
                         :group => {:name=>'unit test group',
                                    :description=>'my desc',
                                    :featured=>false }
    assert_response :created
    group = JSON.parse(response.body)
    check_new_group(group) 
  end
  
  
  # TRY TO UPDATE A GROUP
  def test_should_update_group_via_API_XML
    get "/logout"
    put "/groups/1.xml", :group => { :name=>'renamed unit test group',
                                     :description=>'my new desc',
                                     :featured=>false }
    assert_response 401
  end
  
  
  # UPDATE A GROUP
  def test_should_update_group_via_API_XML
    get "/logout"
    put "/groups/1.xml", :api_key => 'testapikey',
                         :group => { :name=>'renamed unit test group',
                                     :description=>'my new desc',
                                     :featured=>false }
    assert_response :success
  end
  
  
  # UPDATE A GROUP
  def test_should_update_group_via_API_JSON
    get "/logout"
    put "/groups/1.json", :api_key => 'testapikey',
                         :group => { :name=>'renamed unit test group',
                                     :description=>'my new desc',
                                     :featured=>false }
    assert_response :success
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