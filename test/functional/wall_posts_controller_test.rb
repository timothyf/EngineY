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
    wpost = assigns(:wall_post)
    parent = assigns(:parent)
    assert parent.class.to_s == 'User'
    assert_not_nil wpost
    assert_not_nil parent
    assert_not_nil assigns(:user)
    assert wpost.user_id == 1, 'Incorrect use id'
    assert wpost.sender_id == 1, 'Incorrect sender id'
    assert wpost.message == 'Hello World', 'Incorrect message'
  end
  
  
  def test_create_wall_post_for_group
    assert_difference('WallPost.count') do
      post :create, :group_id=>2, :wall_post => {:user_id=>1, :sender_id=>1, :message=>'Hello World' }
    end
    assert_response :success
    wpost = assigns(:wall_post)
    parent = assigns(:parent)
    assert parent.class.to_s == 'Group'
    assert_not_nil parent
    assert_not_nil wpost
    assert wpost.group_id == 2, 'Incorrect group id'
    assert wpost.user_id == 1, 'Incorrect use id'
    assert wpost.sender_id == 1, 'Incorrect sender id'
    assert wpost.message == 'Hello World', 'Incorrect message'
  end
  
  
  def test_create_wall_post_for_event
    assert_difference('WallPost.count') do
      post :create, :event_id=>2, :wall_post => {:user_id=>1, :sender_id=>1, :message=>'Hello World' }
    end
    assert_response :success
    wpost = assigns(:wall_post)
    parent = assigns(:parent)
    assert parent.class.to_s == 'Event'
    assert_not_nil parent
    assert_not_nil wpost
    assert wpost.event_id == 2, 'Incorrect event id'
    assert wpost.user_id == 1, 'Incorrect use id'
    assert wpost.sender_id == 1, 'Incorrect sender id'
    assert wpost.message == 'Hello World', 'Incorrect message'
  end


  def test_should_get_edit
    get :edit, :id => wall_posts(:one).id
    assert_response :success
  end


  def test_should_update_wall_post
    put :update, :id => wall_posts(:one).id, :wall_post => {:user_id=>1, 
                                                            :sender_id=>1, 
                                                            :message=>'New Hello World' }
    assert_redirected_to wall_post_path(assigns(:wall_post))
  end


  def test_should_destroy_user_wall_post
    assert_difference('WallPost.count', -1) do
      delete :destroy, :id => wall_posts(:one).id
    end
    assert_response :success
    assert_not_nil assigns(:user)
    assert_not_nil assigns(:parent)
    assert assigns(:parent).class.to_s == 'User'
  end
  
  
  def test_should_destroy_group_wall_post
    assert_difference('WallPost.count', -1) do
      delete :destroy, :id => wall_posts(:two).id
    end
    assert_response :success
    assert_not_nil assigns(:parent)
    assert assigns(:parent).class.to_s == 'Group'
  end
  
  
  def test_should_destroy_event_wall_post
    assert_difference('WallPost.count', -1) do
      delete :destroy, :id => wall_posts(:three).id
    end
    assert_response :success
    assert_not_nil assigns(:parent)
    assert assigns(:parent).class.to_s == 'Event'
  end
  
  
end
