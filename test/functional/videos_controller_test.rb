require 'test_helper'

class VideosControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:videos)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_video
    assert_difference('Video.count') do
      post :create, :video => { }
    end

    assert_redirected_to video_path(assigns(:video))
  end

  def test_should_show_video
    get :show, :id => videos(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => videos(:one).id
    assert_response :success
  end

  def test_should_update_video
    put :update, :id => videos(:one).id, :video => { }
    assert_redirected_to video_path(assigns(:video))
  end

  def test_should_destroy_video
    assert_difference('Video.count', -1) do
      delete :destroy, :id => videos(:one).id
    end

    assert_redirected_to videos_path
  end
end
