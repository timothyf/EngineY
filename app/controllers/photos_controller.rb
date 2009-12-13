#   Copyright 2009 Timothy Fisher
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

class PhotosController < ApplicationController

  include ViewCountable
  
  before_filter :login_required, :only => [:new, :edit, :create, :update]


  # This method is called via AJAX to add a comment to a photo
  def add_comment
    @photo = Photo.find(params[:photo_id])
    comment = Comment.new
    comment.comment = params[:comment][:comment]
    comment.user = current_user
    @photo.comments << comment
    respond_to do |format|
      format.html { render :partial=>'photo_comments' } 
      format.xml  { head :ok }
    end
  end
  

  def index
    @section = 'PHOTOS' 
    @photos = Photo.non_profile_photos
  end
  
  
  def show
    @photo = Photo.find(params[:id])
    update_view_count(@photo) if current_user && current_user.id != @photo.user_id
  end
  
  
  def new
    @photo = Photo.new
  end
  
  
  def edit
    @photo = Photo.find(params[:id])
  end
  
  
  def create
    sleep 5
    @photo = Photo.new(params[:photo])
    @photo.user = current_user;
    if @photo.save
      flash[:notice] = 'Photo was successfully created.'
      redirect_to edit_photo_url(@photo)     
    else
      render :action => :new
    end
  end
  
  
  def update
    @photo = Photo.find(params[:id])
    respond_to do |format|
      if @photo.update_attributes(params[:photo])  
        flash[:notice] = 'Photo was successfully updated.'
        format.html { redirect_to(@photo) }
        format.xml  { head :ok }
      else
        puts @photo.errors.to_xml
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to(photos_url) }
      format.xml  { head :ok }
    end
  end

end
