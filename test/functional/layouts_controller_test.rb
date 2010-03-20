require 'test_helper'

class LayoutsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:layouts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create layout" do
    assert_difference('Layout.count') do
      post :create, :layout => { }
    end

    assert_redirected_to layout_path(assigns(:layout))
  end

  test "should show layout" do
    get :show, :id => layouts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => layouts(:one).to_param
    assert_response :success
  end

  test "should update layout" do
    put :update, :id => layouts(:one).to_param, :layout => { }
    assert_redirected_to layout_path(assigns(:layout))
  end

  test "should destroy layout" do
    assert_difference('Layout.count', -1) do
      delete :destroy, :id => layouts(:one).to_param
    end

    assert_redirected_to layouts_path
  end
end
