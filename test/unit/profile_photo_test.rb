require 'test_helper'

class ProfilePhotoTest < ActiveSupport::TestCase


  def test_create_profile_photo
    photo = ProfilePhoto.new({:filename => 'test.jpg'})
    photo.uploaded_data = fixture_file_upload(photo.filename, 'image/jpeg')     
    photo.save!
    resizes = Photo.find_all_by_parent_id(photo.id)
    assert resizes.length == 4
    
    resizes.each do |photo|
      assert ['thumb','small','medium','member'].member?(photo.thumbnail)
    end
  end
  
  
end
