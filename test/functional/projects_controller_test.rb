require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  
  def setup
    login_as(:quentin)
  end
  
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end


  test "should get new" do
    get :new
    assert_response :success
  end


  test "should create projects" do
    assert_difference('Project.count') do
      post  :create, 
            :project => { :user_id=>1,
                          :url=>'http://www.myproject.org',
                          :name=>'My Super Project',
                          :description=>'About my project.'}
    end
    assert_redirected_to projects_path
  end


  test "should show projects" do
    get :show, :id => projects(:one).id
    assert_response :success
  end


  test "should get edit" do
    get :edit, :id => projects(:one).id
    assert_response :success
  end
  

  test "should update projects" do
    put :update, 
        :id => projects(:one).id, 
        :project => { :user_id=>1,
                          :url=>'http://www.myproject.org',
                          :name=>'My Super Project',
                          :description=>'About my project.'}
    assert_redirected_to projects_path
  end


  test "should destroy projects" do
    assert_difference('Project.count', -1) do
      delete :destroy, :id => projects(:one).id
    end
    assert_redirected_to projects_path
  end
  
end
