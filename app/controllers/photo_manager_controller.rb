class PhotoManagerController < ApplicationController
  
  def index
    @albums = PhotoAlbum.find(:all, 
                              :order => 'id DESC')
                         
    @photos_outside_album = Photo.find(:all, 
                               :conditions => ['photo_album_id IS NULL AND thumbnail IS NULL AND is_profile IS NULL'],
                               :order => 'id DESC')
  end
  
  
end
