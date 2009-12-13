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

class VideosController < ApplicationController

  def index
    @section = 'VIDEOS' 
    @videos = Video.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @videos }
    end
  end


  def show
    @video = Video.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @video }
    end
  end


  def new
    @video = Video.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @video }
    end
  end


  def edit
    @video = Video.find(params[:id])
  end


  def create
    @video = Video.new(params[:video])
    respond_to do |format|
      if @video.save
        flash[:notice] = 'Video was successfully created.'
        format.html { redirect_to(@video) }
        format.xml  { render :xml => @video, :status => :created, :location => @video }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @video = Video.find(params[:id])
    respond_to do |format|
      if @video.update_attributes(params[:video])
        flash[:notice] = 'Video was successfully updated.'
        format.html { redirect_to(@video) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    respond_to do |format|
      format.html { redirect_to(videos_url) }
      format.xml  { head :ok }
    end
  end
end
