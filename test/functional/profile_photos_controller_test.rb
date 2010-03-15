require 'test_helper'

class ProfilePhotosControllerTest < ActionController::TestCase


  def setup
    login_as :user9
    @imgdata = fixture_file_upload('rails.png', 'image/png')
  end
  

  def test_create
    # difference will be 5 due to different image sizes that are created
    assert_difference('Photo.count', 5) do
      post :create, :profile_photo => {:user_id=>9,
                                       :title=>'some title',
                                       :description=>'some desc',
                                       :filename=>'filename',
                                       :size=>200,
                                       :width=>75,
                                       :height=>100,
                                       :is_profile=>true,
                                       :uploaded_data => @imgdata}
    end
    assert_redirected_to edit_user_path(9)
  end
  
  
  def test_create_with_existing_profile_pic
    login_as :quentin
    # difference will be 4 due to different image sizes that are created and one being replaced
    assert_difference('Photo.count', 4) do
      post :create, :profile_photo => {:user_id=>1,
                                       :title=>'some title',
                                       :description=>'some desc',
                                       :filename=>'filename',
                                       :size=>200,
                                       :width=>75,
                                       :height=>100,
                                       :is_profile=>true,
                                       :uploaded_data => @imgdata}
    end
    assert_redirected_to edit_user_path(1)
  end
  
  
end
