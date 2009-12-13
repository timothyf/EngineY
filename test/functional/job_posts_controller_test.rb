require 'test_helper'

class JobPostsControllerTest < ActionController::TestCase
 
  include AuthenticatedTestHelper
  fixtures :users
  
  
  def setup
    login_as :quentin
  end
  
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:job_posts)
  end
  

  def test_should_get_new
    get :new
    assert_template 'new'
    assert_response :success
  end


  def test_should_create_job_post
    assert_difference('JobPost.count') do
      post :create, :job_post => {:job_title=>'super job',
                                  :job_id=>1,
                                  :company=>'Goodco',
                                  :website=>'website.com',
                                  :contact_name=>'contactman',
                                  :email=>'mail@mail.com',
                                  :description=>'an ok job',
                                  :featured=>false,
                                  :end_date=>Time.now}
    end
    assert_redirected_to job_posts_url
  end


  def test_should_get_edit
    get :edit, :id => job_posts(:one).id
    assert_template 'edit'
    assert_response :success
  end


  def test_should_update_job_post
    put :update, :id => job_posts(:one).id, :job_post => { }
    assert_redirected_to job_posts_url
  end


  def test_should_destroy_job_post
    assert_difference('JobPost.count', -1) do
      delete :destroy, :id => job_posts(:one).id
    end
    assert_redirected_to job_posts_path
  end
  
end
