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

class AnnouncementsController < ApplicationController

  before_filter :login_required, :only => [:new, :edit, :create, :update, :destroy]
  
  
  def index
    @announcements = Announcement.paginate(:all, :page => params[:page], :order => 'created_at DESC') 
    @announcement_count = Announcement.count
    respond_to do |format|
      format.html { render :template=>'announcements/announcements_list' } 
      format.xml  { render :xml => @announcements }
      format.json { render :json => @announcements } 
    end
  end


  def new
    @announcement = Announcement.new
  end


  def edit
    @announcement = Announcement.find(params[:id])
  end


  def create
    @announcement = Announcement.new(params[:announcement])
    @announcement.user = current_user
    respond_to do |format|
      if @announcement.save
        flash[:notice] = 'Announcement was successfully created.'
        format.html { redirect_to('/') }
        format.xml  { render :xml => @announcement, :status => :created, :location => @announcement }
        format.json  { render :json => @announcement, :status => :created, :location => @announcement }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @announcement.errors, :status => :unprocessable_entity }
        format.json  { render :json => @announcement.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @announcement = Announcement.find(params[:id])
    respond_to do |format|
      if @announcement.update_attributes(params[:announcement])
        flash[:notice] = 'Announcement was successfully updated.'
        format.html { redirect_to('/') }
        format.xml  { head :ok }
        format.json { head :ok } 
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @announcement.errors, :status => :unprocessable_entity }
        format.json { render :json => @announcement.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @announcement = Announcement.find(params[:id])
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to('/') }
      format.xml  { head :ok }
      format.json { head :ok } 
    end
  end
end
