require 'test_helper'

class FriendsControllerTest < ActionController::TestCase


  def test_get_friends_index
    get :index, :user_id => 1
    assert_response :success
    assert_not_nil assigns(:user)
    assert_not_nil assigns(:friends)
    assert_not_nil assigns(:title)
    assert assigns(:friends).length == 2
    assert assigns(:title) == 'My Friends'
  end
  
  
  def test_get_requested_friends_index
    get :index, :user_id => 1, :type => 'requested'
    assert_response :success
    assert_not_nil assigns(:user)
    assert_not_nil assigns(:friends)
    assert_not_nil assigns(:title)
    assert assigns(:friends).length == 1
    assert assigns(:title) == 'My Requested Friends'
  end
  
  
  def test_get_pending_friends_index
    get :index, :user_id => 1, :type => 'pending'
    assert_response :success
    assert_not_nil assigns(:user)
    assert_not_nil assigns(:friends)
    assert_not_nil assigns(:title)
    assert assigns(:friends).length == 1
    assert assigns(:title) == 'My Pending Friends'
  end
  
  
  def test_get_requested_friends
    login_as(:quentin)
    get :requested_friends, :user_id => 1
    assert_response :success
    assert_not_nil assigns(:user)
    assert_not_nil assigns(:friends)
    assert_not_nil assigns(:title)
    assert assigns(:friends).length == 1
    assert assigns(:title) == 'My Requested Friends'    
  end
  
  
  def test_get_pending_friends
    login_as(:quentin)
    get :pending_friends, :user_id => 1
    assert_response :success
    assert_not_nil assigns(:user)
    assert_not_nil assigns(:friends)
    assert_not_nil assigns(:title)
    assert assigns(:friends).length == 1
    assert assigns(:title) == 'My Pending Friends'  
  end
  
  
  def test_show
    get :show, :id => 1
    assert_redirected_to user_path(1)
  end
  
  
  def test_create
    login_as(:quentin)
    # creates a bi-directional friendship, thus friendship count is increased by 2
    assert_difference('Friendship.count', +2) do
      post :create, :friend_id => 9
    end
    assert_redirected_to user_path(9)
  end
  
  
  def test_update
    login_as(:quentin)
    put :update, :friend_id => 7
    assert_redirected_to user_friends_path(users(:quentin))
  end
  
  
  def test_destroy
    login_as(:quentin)
    # deletes both sides of the friendship, so reduces friendships count by 2
    assert_difference('Friendship.count', -2) do
      delete :destroy, :user_id => 1, :id => 5
    end
    assert_redirected_to user_path(1)
  end
  
  
end
