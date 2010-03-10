require 'test_helper'

class ProjectTest < ActiveSupport::TestCase


  def test_log_activity_after_create
    project = Project.create({
                             :user_id => 1,
                             :url => 'www.rubyonrails.com',
                             :name => 'A Test Project',
                             :description => "This project is created for testing"
                           })
    assert project, 'Failed to create link' 
    act = Activity.find_by_item_id_and_item_type(project.id, 'Project')
    assert act, 'Failed to log activity' 
    assert act.user_id == project.user_id, 'Incorrecty user id'
    assert act.public == true, 'Should be public'
    assert act.item_id == project.id, 'Incorrect item id'
    assert act.item_type == 'Project', 'Incorrect item_type'
    assert act.action == nil, 'Incorrect action' 
  end
  
  
  def test_name_validation
    assert projects(:one).valid? == true, 'Expected valid project' 
    projects(:one).name = nil
    assert projects(:one).valid? == false, "Expected invalid project" 
    assert(projects(:one).errors.invalid?(:name))
  end
  
  
  def test_url_validation
    assert projects(:one).valid? == true, 'Expected valid project' 
    projects(:one).url = nil
    assert projects(:one).valid? == false, "Expected invalid project" 
    assert(projects(:one).errors.invalid?(:url))
  end
  
  
  def test_description_validation
    assert projects(:one).valid? == true, 'Expected valid project' 
    projects(:one).description = nil
    assert projects(:one).valid? == false, "Expected invalid project" 
    assert(projects(:one).errors.invalid?(:description))
  end
  
  
end
