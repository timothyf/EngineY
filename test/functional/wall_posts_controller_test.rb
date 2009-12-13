require 'test_helper'

class WallPostsControllerTest < ActionController::TestCase
  
  include AuthenticatedTestHelper
  fixtures :users
  
  
  def setup
    login_as :quentin
  end


  def test_should_get_new
    get :new
    assert_response :success
  end


  def test_create_wall_post_for_user
    assert_difference('WallPost.count') do
      post :create, :user_id=>1, :wall_post => {:user_id=>1, :sender_id=>1, :message=>'Hello World' }
    end
    assert_response :success
  end


  def test_should_get_edit
    get :edit, :id => wall_posts(:one).id
    assert_response :success
  end


  def test_should_update_wall_post
    put :update, :id => wall_posts(:one).id, :wall_post => { }
    assert_redirected_to wall_post_path(assigns(:wall_post))
  end


  def test_should_destroy_wall_post
    assert_difference('WallPost.count', -1) do
      delete :destroy, :id => wall_posts(:one).id
    end
  assert_response :success
  end
end
