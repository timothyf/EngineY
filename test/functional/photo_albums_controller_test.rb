require 'test_helper'

class PhotoAlbumsControllerTest < ActionController::TestCase
  
  fixtures :users
  
  
  def setup
    login_as :quentin
  end
  
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:photo_albums)
  end


  def test_should_get_new
    get :new
    assert_response :success
  end


  def test_should_create_photo_album
    assert_difference('PhotoAlbum.count') do
      post :create, :photo_album => {:title => 'test album',
                                     :description => 'test album desc',
                                     :user_id => 1}
    end
    assert_redirected_to photo_album_path(assigns(:photo_album))
  end
  

  def test_should_get_edit
    get :edit, :id => photo_albums(:one).id
    assert_response :success
  end


  def test_should_update_photo_album
    put :update, :id => photo_albums(:one).id, :photo_album => {:title => 'test album',
                                     :description => 'test album desc',
                                     :user_id => 1}
    assert_redirected_to photo_album_path(assigns(:photo_album))
  end


  def test_should_destroy_photo_album
    assert_difference('PhotoAlbum.count', -1) do
      delete :destroy, :id => photo_albums(:one).id
    end
    assert_redirected_to photo_albums_path
  end
  
end
