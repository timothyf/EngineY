require 'test_helper'

class StatusPostsControllerTest < ActionController::TestCase
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:status_posts)
  end


  def test_should_get_new
    login_as(:quentin)
    get :new
    assert_response :success
  end


  def test_should_create_status_post
    login_as(:quentin)
    assert_difference('StatusPost.count') do
      post :create, :status_post => { :body => 'My new status' }
    end
    assert_redirected_to user_path(users(:quentin))
    assert_not_nil assigns(:status_post) 
    assert assigns(:status_post).body == 'My new status', 'Incorrect status_post body'
    assert assigns(:status_post).user_id == 1, 'Incorrect status_post user id' 
  end


  def test_should_get_edit
    login_as(:quentin)
    get :edit, :id => status_posts(:one).id
    assert_response :success
  end


  def test_should_update_status_post
    login_as(:quentin)
    put :update, :id => status_posts(:one).id, :status_post => { :body => 'Updated Status Post' }
    assert_redirected_to status_post_path(assigns(:status_post))
    assert_not_nil assigns(:status_post) 
    assert assigns(:status_post).body == 'Updated Status Post', 'Incorrect status_post body'
    assert assigns(:status_post).user_id == 1, 'Incorrect status_post user id'
  end


  def test_should_destroy_status_post
    login_as(:quentin)
    assert_difference('StatusPost.count', -1) do
      delete :destroy, :id => status_posts(:one).id
    end
    assert_redirected_to status_posts_path
  end
  
end
