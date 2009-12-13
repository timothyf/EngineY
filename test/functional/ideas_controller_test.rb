require 'test_helper'

class IdeasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ideas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create idea" do
    assert_difference('Idea.count') do
      post :create, :idea => { }
    end

    assert_redirected_to idea_path(assigns(:idea))
  end

  test "should show idea" do
    get :show, :id => ideas(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ideas(:one).id
    assert_response :success
  end

  test "should update idea" do
    put :update, :id => ideas(:one).id, :idea => { }
    assert_redirected_to idea_path(assigns(:idea))
  end

  test "should destroy idea" do
    assert_difference('Idea.count', -1) do
      delete :destroy, :id => ideas(:one).id
    end

    assert_redirected_to ideas_path
  end
end
