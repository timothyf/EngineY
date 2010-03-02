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

class PhotoAlbumsController < ApplicationController
  
  include ViewCountable
  
  before_filter :login_required, :only => [:new, :edit, :create, :update]

  def index
    @photo_albums = PhotoAlbum.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photo_albums }
    end
  end
  
  
  def show
    @photo_album = PhotoAlbum.find(params[:id])
    update_view_count(@photo_album) if current_user && current_user.id != @photo_album.user_id 
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo_album }
    end
  end


  def new
    @photo_album = PhotoAlbum.new
  end


  def edit
    @photo_album = PhotoAlbum.find(params[:id])
  end


  def create
    @photo_album = PhotoAlbum.new(params[:photo_album])
    @photo_album.user_id = current_user.id
    respond_to do |format|
      if @photo_album.save
        flash[:notice] = 'PhotoAlbum was successfully created.'
        format.html { redirect_to(@photo_album) }
        format.xml  { render :xml => @photo_album, :status => :created, :location => @photo_album }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo_album.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @photo_album = PhotoAlbum.find(params[:id])
    respond_to do |format|
      if @photo_album.update_attributes(params[:photo_album])
        flash[:notice] = 'PhotoAlbum was successfully updated.'
        format.html { redirect_to(@photo_album) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo_album.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @photo_album = PhotoAlbum.find(params[:id])
    @photo_album.destroy
    respond_to do |format|
      format.html { redirect_to(photo_albums_url) }
      format.xml  { head :ok }
    end
  end
  
end
