require 'test_helper'

class WidgetsControllerTest < ActionController::TestCase

  
  def test_load
    get :load, :name => 'blog_posts_home'
    assert_response :success
  end
  
  
  def test_load_profile_widget
    get :load_profile_widget, :name => 'blog_posts_profile', :user_id => 1
    assert_response :success
  end
  
  
  def test_grid_data
    get :grid_data, :rows => 10
    assert_response :success
    assert_not_nil assigns(:widgets)
  end
  
  
end
