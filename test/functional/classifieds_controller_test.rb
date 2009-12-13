require 'test_helper'

class ClassifiedsControllerTest < ActionController::TestCase
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:classifieds)
  end


  test "should get new" do
    get :new
    assert_response :success
  end


  test "should create classified" do
    assert_difference('Classified.count') do
      post :create, :classified => { }
    end
    assert_redirected_to classifieds_path
  end
  

  test "should show classified" do
    get :show, :id => classifieds(:one).id
    assert_response :success
  end


  test "should get edit" do
    get :edit, :id => classifieds(:one).id
    assert_response :success
  end


  test "should update classified" do
    put :update, :id => classifieds(:one).id, :classified => { }
    assert_redirected_to classified_path(assigns(:classified))
  end


  test "should destroy classified" do
    assert_difference('Classified.count', -1) do
      delete :destroy, :id => classifieds(:one).id
    end
    assert_redirected_to classifieds_path
  end
end
