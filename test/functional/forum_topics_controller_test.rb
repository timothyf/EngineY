require 'test_helper'

class ForumTopicsControllerTest < ActionController::TestCase
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:forum_topics)
  end


  def test_should_get_new
    login_as(:quentin)
    get :new
    assert_response :success
  end


  def test_should_create_forum_topic
    login_as(:quentin)
    assert_difference('ForumTopic.count') do
      post :create, :forum_topic => { }
    end
    assert_redirected_to forum_topic_path(assigns(:forum_topic))
  end


  def test_should_update_forum_topic
    login_as(:quentin)
    put :update, :id => forum_topics(:one).id, :forum_topic => { }
    assert_redirected_to forum_topic_path(assigns(:forum_topic))
  end


  def test_should_destroy_forum_topic
    login_as(:quentin)
    assert_difference('ForumTopic.count', -1) do
      delete :destroy, :id => forum_topics(:one).id
    end
    assert_redirected_to forum_topics_path
  end
  
end
