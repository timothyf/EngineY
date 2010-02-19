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

class EventsController < ApplicationController

  uses_tiny_mce :options => {
                              :theme => 'advanced',
                              :theme_advanced_toolbar_location => "top",
                              :theme_advanced_toolbar_align => "left",
                              :theme_advanced_resizing => true,
                              :theme_advanced_resize_horizontal => false,
                              :theme_advanced_buttons1 => "forecolor,backcolor,bullist,numlist,separator,outdent,indent,separator,undo,redo,separator,link,unlink,anchor,image,cleanup,help,code",
                              :theme_advanced_buttons2 => "",
                              :theme_advanced_buttons3 => ""
                            }
  
  before_filter :login_required, :only => [:new, :edit, :create, :update]
  
  # only event creator or an admin can edit or update an event.
  before_filter :check_auth, :only => [:edit, :update]
  
  def check_auth
    
  end
  
  
  # Does not include past events
  def index
    @section = 'EVENTS' 
    @events = Event.find(:all, :conditions=>'start_time>now()', :order=>'start_time ASC')
    respond_to do |format|
      format.html { render :template => 'events/index' }
      format.xml  { render :xml => @events }
      format.json { render :json => @events.to_json }
    end
  end
  
  
  # Includes past events
  def full_index
    @section = 'EVENTS' 
    @past_events = true
    @events = Event.find(:all, :order=>'start_time ASC')
    respond_to do |format|
      format.html { render :template => 'events/index' }
      format.xml  { render :xml => @events }
      format.json { render :json => @events.to_json }
    end
  end


  def show
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
      format.json { render :json => @event.to_json } 
    end
  end


  def new
    @event = Event.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end


  def edit
    @event = Event.find(params[:id])
  end


  def create
    sleep 4  # required for photo upload
    @event = Event.new(params[:event])
    @event.user = current_user
    respond_to do |format|
      if @event.save
        if params[:event_photo]  
          # save event photo
          @event.profile_photo = ProfilePhoto.create!(:is_profile=>true, :uploaded_data => params[:event_photo]) if params[:event_photo].size != 0 
          #profile_photo = ProfilePhoto.create!(:uploaded_data => params[:event_photo]) if params[:event_photo].size != 0 
          #profile_photo.event_id = @event.id;
          #profile_photo.is_profile = true;
          #@event.profile_photo = profile_photo
        end   
        Event.reset_cache
        flash[:notice] = 'Event was successfully created.'
        format.html { redirect_to(@event) }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
        format.json { render :json => @event.to_json, :status => :created, :location => @event } 
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
        format.json { render :json => @event.errors.to_json, :status => :unprocessable_entity } 
      end
    end
  end 


  def update
    @event = Event.find(params[:id])
    respond_to do |format|
      if @event.update_attributes(params[:event])
        flash[:notice] = 'Event was successfully updated.'
        format.html { redirect_to(@event) }
        format.xml  { head :ok }
        format.json { head :ok } 
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
        format.json { render :json => @event.errors.to_json, :status => :unprocessable_entity } 
      end
    end
  end


  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
      format.json { head :ok } 
    end
  end
  
end
