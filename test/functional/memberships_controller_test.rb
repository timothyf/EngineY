require 'test_helper'

class MembershipsControllerTest < ActionController::TestCase
  
  
  def test_find
    get :find, :user_id => 1, :group_id => 1
    assert_response :success
    assert_not_nil assigns(:membership)
    assert assigns(:membership).id == 1
    assert assigns(:membership).role_id == 4
  end
  
  
  def test_create
    assert_difference('Membership.count') do
      post :create, :group_id => 1, :user_id => 8
    end
    assert_redirected_to group_path(1)
  end
  
  
  def test_update
    put :update, :id => memberships(:one).id
    assert_redirected_to membership_path(assigns(:membership).id)
  end
  
  
  def test_destroy
    assert_difference('Membership.count', -1) do
      delete :destroy, :user_id => 1, :group_id => 1
    end
    assert_redirected_to groups_url
  end
  
  
end
