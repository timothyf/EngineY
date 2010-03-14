require 'test_helper'

class AdminControllerTest < ActionController::TestCase


  
  def setup
    login_as :quentin
  end
  
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:page)
    assert assigns(:page) == 'dashboard', 'Incorrect page name'
  end
  
  
  def test_should_get_settings
    get :settings
    assert_response :success
    assert_not_nil assigns(:page)
    assert_not_nil assigns(:network)
    assert assigns(:page) == 'settings', 'Incorrect page name'
  end
  
  
  def test_should_get_users
    get :users
    assert_response :success
    assert_not_nil assigns(:page)
    assert_not_nil assigns(:users)
    assert_not_nil assigns(:admins)
    assert assigns(:page) == 'users', 'Incorrect page name'
    assert assigns(:users).length == 40, 'Incorrect number of users'
    assert assigns(:admins).length == 2, 'Incorrect number of admins'
  end
  
  
  def test_should_get_groups
    get :groups
    assert_response :success
    assert_not_nil assigns(:page)
    assert_not_nil assigns(:groups)
    assert assigns(:page) == 'groups', 'Incorrect page name'
    assert assigns(:groups).length == 2, 'Incorrect number of groups'
  end
  
  
  def test_should_get_events
    get :events
    assert_response :success
    assert_not_nil assigns(:page)
    assert_not_nil assigns(:events)
    assert assigns(:page) == 'events', 'Incorrect page name'
    assert assigns(:events).length == 2, 'Incorrect number of events'
  end
  
  
  def test_should_get_blog_posts
    get :blog_posts
    assert_response :success
    assert_not_nil assigns(:page)
    assert_not_nil assigns(:blog_posts)
    assert assigns(:page) == 'blog_posts', 'Incorrect page name'
    assert assigns(:blog_posts).length == 2, 'Incorrect number of blog posts'
  end
  
  
  def test_get_blog_post_edit
    get :blog_post_edit, :id => 2
    assert_response :success
    assert_not_nil assigns(:blog_post)
    assert assigns(:blog_post).id == 2
  end
  
  
  def test_get_group_new
    get :group_new
    assert_response :success
    assert_not_nil assigns(:group)
  end
  
  
  def test_get_group_edit
    get :group_edit, :id => 2
    assert_response :success
    assert_not_nil assigns(:group)
    assert_not_nil assigns(:show_full)
    assert assigns(:group).id == 2
    assert assigns(:show_full) == true
  end
  
  
  def test_get_event_new
    get :event_new
    assert_response :success
    assert_not_nil assigns(:event)    
  end
  
  
  def test_get_event_edit
    get :event_edit, :id => 1
    assert_response :success
    assert_not_nil assigns(:event)
    assert assigns(:event).id == 1    
  end
  
  
  def test_get_user_new
    get :user_new
    assert_response :success
    assert_not_nil assigns(:user) 
  end
  
  
  def test_get_user_edit
    get :user_edit, :id => 1
    assert_response :success
    assert_not_nil assigns(:user)
    assert assigns(:user).id == 1
  end
  
  
  def test_get_user_delete
    assert_difference('User.count', -1) do
      get :user_delete, :id => 3
    end
    assert_redirected_to '/admin/users'
  end
  
  
  def test_get_user_activate
    get :user_activate, :id => 2
    assert_redirected_to '/admin/users'
  end
  
  
  def test_get_user_promote
    assert User.find(3).is_admin == false
    get :user_promote, :id => 3
    assert_redirected_to '/admin/users'
    assert User.find(3).is_admin == true
  end
  
  
  def test_get_network_name
    get :network_name
    assert_response :success
    assert_not_nil assigns(:network)
  end
  
  
  def test_get_network_description
    get :network_description
    assert_response :success
    assert_not_nil assigns(:network)
  end
  
  
  def test_get_privacy_edit
    get :privacy_edit
    assert_response :success
    assert_not_nil assigns(:privacy)
  end
  
  
  def test_get_save_privacy
    get :save_privacy, :id => 1, :privacy_text => 'This is a test privacy statement.'
    assert_redirected_to '/admin/settings'
  end
  
  
  def test_get_analytics_code
    get :analytics_code
    assert_response :success
    assert_not_nil assigns(:analytics)
  end
  
  
  def test_get_save_analytics
    get :save_analytics, :id => 1, :analytics_text => 'This is some analytics code.'
    assert_redirected_to '/admin/settings'
  end
  
  
  def test_get_save_network
    
  end
  
  
  def test_post_user_data
    
  end
  
  
  def test_post_group_data
    
  end
  
  
  def test_post_event_data
    
  end
  
  
  def test_get_pending_users
    get :pending_users
    assert_response :success
    assert_not_nil assigns(:pending_users)
  end
  
  
end
