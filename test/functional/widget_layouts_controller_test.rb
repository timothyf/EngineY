require 'test_helper'

class WidgetLayoutsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:widget_layouts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create widget_layout" do
    assert_difference('WidgetLayout.count') do
      post :create, :widget_layout => { }
    end

    assert_redirected_to widget_layout_path(assigns(:widget_layout))
  end

  test "should show widget_layout" do
    get :show, :id => widget_layouts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => widget_layouts(:one).to_param
    assert_response :success
  end

  test "should update widget_layout" do
    put :update, :id => widget_layouts(:one).to_param, :widget_layout => { }
    assert_redirected_to widget_layout_path(assigns(:widget_layout))
  end

  test "should destroy widget_layout" do
    assert_difference('WidgetLayout.count', -1) do
      delete :destroy, :id => widget_layouts(:one).to_param
    end

    assert_redirected_to widget_layouts_path
  end
end
