require 'test_helper'

class PhotoTest < ActiveSupport::TestCase

  def setup
    photo_fixtures
  end
  
  
  def test_uploaded_photo
    photos = Photo.find(:all)
    # 6 photos for each photo uploaded (4*6 = 24) (due to resizings)
    assert photos.length == 24, 'Incorrect photos count'
    assert photos[0].id == 1, 'Incorrect photo id'
    assert photos[0].user_id == 1, 'Incorrect user id'
    assert photos[0].title == 'Test Photo 1', 'Incorrect title'
    assert photos[0].filename == 'test.jpg', 'Incorrect filename'
    assert photos[0].content_type == 'image/jpeg', 'Incorrect content type'
    assert photos[0].is_profile == nil, 'Incorrect is profile flag'
    assert photos[0].thumbnail == nil, 'Incorrect thumbnail'
    #assert photos[0].size == 8908, 'Incorrect photo size'
    #assert photos[0].size == 23066, 'Incorrect photo size'
    assert photos[0].height == 235, 'Incorrect height'
    assert photos[0].width == 180, 'Incorrect width'
    
    resizes = Photo.find_all_by_parent_id(photos[0].id)
    assert resizes.length == 5
    resizes.each do |photo|
      assert ['thumb','small','medium','member','display'].member?(photo.thumbnail)
    end
  end
  
  
  def test_get_non_profile_photos
    photos = Photo.non_profile_photos
    assert photos.length == 2
    assert photos[0].filename == 'test.jpg'
    assert photos[1].filename == 'test.jpg'
  end
  
 
  def test_log_activity_after_create
    photo = Photo.new({:filename => 'test.jpg'})
    photo.uploaded_data = fixture_file_upload(photo.filename, 'image/jpeg')     
    photo.save!
    assert photo, 'Failed to create photo' 
    act = Activity.find_by_item_id_and_item_type(photo.id, 'Photo')
    assert act, 'Failed to log activity' 
    assert act.user_id == photo.user_id, 'Incorrecty user id'
    assert act.public == true, 'Should be public'
    assert act.item_id == photo.id, 'Incorrect item id'
    assert act.item_type == 'Photo', 'Incorrect item_type'
    assert act.action == 'create', 'Incorrect action' 
  end  
  
  
  def test_log_activity_after_detroy
    photo = Photo.new({:filename => 'test.jpg'})
    photo.uploaded_data = fixture_file_upload(photo.filename, 'image/jpeg')     
    photo.save!
    act = Activity.find_all_by_item_id_and_item_type(photo.id, 'Photo')
    assert act.length == 1, 'Incorrect activity count'
    photo = Photo.find(photo.id)
    photo.destroy
    act = Activity.find_all_by_item_id_and_item_type(photo.id, 'Photo')
    assert act.length == 2, 'Incorrect activity count'
    assert act[0].action == 'create', 'Incorrect action' 
    assert act[1].action == 'destroy', 'Incorrect action'
  end

  
end
