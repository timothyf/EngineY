require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  
  include AuthenticatedTestHelper
  fixtures :users
  
  
  
  def setup
    login_as :quentin
    @imgdata = fixture_file_upload('rails.png', 'image/png')
  end
  
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:photos)
  end


  def test_should_get_new
    get :new
    assert_response :success
  end


  def test_should_create_photo
    # difference will be 6 due to different image sizes that are created
    assert_difference('Photo.count', 6) do
      post :create, :photo => {:user_id=>1,
                               :title=>'some title',
                               :description=>'some desc',
                               :filename=>'filename',
                               :thumbnail=>'thumbnail',
                               :size=>200,
                               :width=>75,
                               :height=>100,
                               :is_profile=>true,
                               :uploaded_data => @imgdata}
    end
    assert_redirected_to edit_photo_url(assigns(:photo))
  end


  def test_should_show_photo
    get :show, :id => photos(:one).id
    assert_response :success
  end


  def test_should_get_edit
    get :edit, :id => photos(:one).id
    assert_response :success
  end
  

  def test_should_update_photo
    put :update, :id => photos(:one).id, :photo => {:user_id=>1,
                                                   :title=>'some title',
                                                   :description=>'some desc',
                                                   :filename=>'filename',
                                                   :thumbnail=>'thumbnail',
                                                   :is_profile=>true,
                                                   :content_type=>'image/png',
                                                   :size=>'200'}
    assert_redirected_to photo_path(assigns(:photo))
  end

  
end
