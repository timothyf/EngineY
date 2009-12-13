require 'test_helper'

class LinksControllerTest < ActionController::TestCase
  
  def setup
    login_as(:quentin)
  end
  
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:links)
  end
  

  test "should get new" do
    get :new
    assert_response :success
  end


  test "should create links" do
    assert_difference('Link.count') do
      post :create, :link => {:url=>'http://www.link.com', :title=>'My Link', :user_id=>1 }
    end
    assert_redirected_to links_path
  end


  test "should get edit" do
    get :edit, :id => links(:one).id
    assert_response :success
  end
  

  test "should update links" do
    put :update, :id => links(:one).id, :link => {:url=>'http://www.link.com', :title=>'My Link', :user_id=>1 }
    assert_redirected_to links_path
  end
  

  test "should destroy links" do
    assert_difference('Link.count', -1) do
      delete :destroy, :id => links(:one).id
    end
    assert_redirected_to links_path
  end
  
end
