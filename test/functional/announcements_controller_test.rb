require 'test_helper'

class AnnouncementsControllerTest < ActionController::TestCase
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:announcements)
  end


  def test_should_get_new
    login_as(:quentin)
    get :new
    assert_response :success
  end


  def test_should_create_announcement
    login_as(:quentin)
    assert_difference('Announcement.count') do
      post :create, :announcement => { :title=>'Test Announcement', :body=>'Test Announcement Body' }
    end
    assert_redirected_to root_path
  end


  def test_should_get_edit
    login_as(:quentin)
    get :edit, :id => announcements(:one).id
    assert_response :success
  end
  

  def test_should_update_announcement
    login_as(:quentin)
    put :update, :id => announcements(:one).id, :announcement => { :title=>'Test Announcement', :body=>'Test Announcement Body' }
    assert_redirected_to root_path
  end
  

  def test_should_destroy_announcement
    login_as(:quentin)
    assert_difference('Announcement.count', -1) do
      delete :destroy, :id => announcements(:one).id
    end
    assert_redirected_to root_path
  end
  
end
