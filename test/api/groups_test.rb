require 'test_helper'
require 'rest_client'

# Make sure that the server is running before running this test.
# This class provides tests for the RESTful API of the Group object.
class GroupsTest < ActiveSupport::TestCase

  # http://localhost:3000/groups.json
  test "get all groups" do
    result = RestClient.get 'http://localhost:3000/groups.json'
    groups = JSON.parse(result)
    assert groups.size == 2
    check_group(groups[0])
  end
  
  
  # http://localhost:3000/groups/1.json
  test "get one group" do
    result = RestClient.get 'http://localhost:3000/groups/1.json'
    puts result
    group = JSON.parse(result)
    check_group(group) 
  end
  
  
  def check_group(user)
    assert user['name'] == 'Detroit Ruby User Group', 'Incorrect name'
    assert user['private'] == false, 'Incorrect private'
    assert user['featured'] == false, 'Incorrect featured'
    assert user['creator_id'] == 1, 'Incorrect creator_id'
    assert user['description'] == 'The Detroit Ruby User Group', 'Incorrect description'
  end
  
  
  # 
  
end