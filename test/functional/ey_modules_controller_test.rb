require 'test_helper'

class EyModulesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ey_modules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ey_module" do
    assert_difference('EyModule.count') do
      post :create, :ey_module => { }
    end

    assert_redirected_to ey_module_path(assigns(:ey_module))
  end

  test "should show ey_module" do
    get :show, :id => ey_modules(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ey_modules(:one).to_param
    assert_response :success
  end

  test "should update ey_module" do
    put :update, :id => ey_modules(:one).to_param, :ey_module => { }
    assert_redirected_to ey_module_path(assigns(:ey_module))
  end

  test "should destroy ey_module" do
    assert_difference('EyModule.count', -1) do
      delete :destroy, :id => ey_modules(:one).to_param
    end

    assert_redirected_to ey_modules_path
  end
end
