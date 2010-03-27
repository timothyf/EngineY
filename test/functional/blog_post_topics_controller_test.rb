require 'test_helper'

class BlogPostTopicsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:blog_post_topics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create blog_post_topic" do
    assert_difference('BlogPostTopic.count') do
      post :create, :blog_post_topic => { }
    end

    assert_redirected_to blog_post_topic_path(assigns(:blog_post_topic))
  end

  test "should show blog_post_topic" do
    get :show, :id => blog_post_topics(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => blog_post_topics(:one).to_param
    assert_response :success
  end

  test "should update blog_post_topic" do
    put :update, :id => blog_post_topics(:one).to_param, :blog_post_topic => { }
    assert_redirected_to blog_post_topic_path(assigns(:blog_post_topic))
  end

  test "should destroy blog_post_topic" do
    assert_difference('BlogPostTopic.count', -1) do
      delete :destroy, :id => blog_post_topics(:one).to_param
    end

    assert_redirected_to blog_post_topics_path
  end
end
