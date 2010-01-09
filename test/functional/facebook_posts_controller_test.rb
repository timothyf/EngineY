require 'test_helper'

class FacebookPostsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facebook_posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facebook_post" do
    assert_difference('FacebookPost.count') do
      post :create, :facebook_post => { }
    end

    assert_redirected_to facebook_post_path(assigns(:facebook_post))
  end

  test "should show facebook_post" do
    get :show, :id => facebook_posts(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => facebook_posts(:one).id
    assert_response :success
  end

  test "should update facebook_post" do
    put :update, :id => facebook_posts(:one).id, :facebook_post => { }
    assert_redirected_to facebook_post_path(assigns(:facebook_post))
  end

  test "should destroy facebook_post" do
    assert_difference('FacebookPost.count', -1) do
      delete :destroy, :id => facebook_posts(:one).id
    end

    assert_redirected_to facebook_posts_path
  end
end
