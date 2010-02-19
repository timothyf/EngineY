require 'test_helper'


# This class provides tests for the RESTful API of the Project object.
class ProjectsTest < ActionController::IntegrationTest
  
  # GET ALL PROJECTS  
  # /projects.json
  test "get all projects" do
    get "/projects.json"
    assert_response :success
    projects = JSON.parse(response.body) 
    assert projects.size == 2
    check_project(projects[0]) 
  end
  
  
  # GET ONE PROJECT
  # /projects/1.json
  test "get one project" do
    get "projects/1.json"
    assert_response :success
    project = JSON.parse(response.body)
    check_project(project) 
  end
  
  
  # TRY TO CREATE A PROJECT
  # /projects.xml
  def test_should_not_create_project_via_API_XML
      get "/logout"
      post "/projects.xml", :project => {:user_id => 1,
                                     :url => 'http://www.apiproject.com',
                                     :name => 'API Project',
                                     :description => 'API Project Desc' }
      assert_response 401
  end

  
  # CREATE A PROJECT
  # /projects.xml
  def test_should_create_project_via_API_XML
      get "/logout"
      post "/projects.xml", :api_key=>'testapikey',
                          :project => {:user_id => 1,
                                     :url => 'http://www.apiproject.com',
                                     :name => 'API Project',
                                     :description => 'API Project Desc' }
      assert_response :created
  end
  
  
  # CREATE A PROJECT
  # /projects.json
  def test_should_create_project_via_API_JSON
    get "/logout"
    post "/projects.json", :api_key => 'testapikey',
                         :project => {:user_id => 1,
                                     :url => 'http://www.apiproject.com',
                                     :name => 'API Project',
                                     :description => 'API Project Desc' }
    assert_response :created
    project = JSON.parse(response.body)
    check_new_project(project) 
  end
  
  
  # TRY TO UPDATE A PROJECT
  def test_should_update_project_via_API_XML
    get "/logout"
    put "/projects/1.xml", :project => {:user_id => 1,
                                     :url => 'http://www.apiproject.com',
                                     :name => 'API Project',
                                     :description => 'API Project Desc' }
    assert_response 401
  end
  
  
  # UPDATE A PROJECT
  def test_should_update_project_via_API_XML
    get "/logout"
    put "/projects/1.xml", :api_key => 'testapikey',
                         :project => {:user_id => 1,
                                     :url => 'http://www.apiproject.com',
                                     :name => 'API Project',
                                     :description => 'API Project Desc' }
    assert_response :success
  end
  
  
  # UPDATE A PROJECT
  def test_should_update_project_via_API_JSON
    get "/logout"
    put "/projects/1.json", :api_key => 'testapikey',
                         :project => {:user_id => 1,
                                     :url => 'http://www.apiproject.com',
                                     :name => 'API Project',
                                     :description => 'API Project Desc' }
    assert_response :success
  end
  
  
  private
  def check_project(project)
    assert project['user_id'] == 1, 'Incorrect user id'
    assert project['url'] == 'http://www.project.com', 'Incorrect url'
    assert project['name'] == 'Test Project', 'Incorrect name'
    assert project['description'] == 'Test Project Desc', 'Incorrect description'
  end
  
  def check_new_project(project)
    assert project['user_id'] == 1, 'Incorrect user id'
    assert project['url'] == 'http://www.apiproject.com', 'Incorrect url'
    assert project['name'] == 'API Project', 'Incorrect name'
    assert project['description'] == 'API Project Desc', 'Incorrect description'
  end
  
  # 
  
end