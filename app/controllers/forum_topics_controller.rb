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

class ForumTopicsController < ApplicationController

  before_filter :set_section
  
  before_filter :login_required, :only => [:new, :edit, :create, :update, :destroy]
  
  # must be an admin to create new forum topics
  before_filter :check_admin_auth, :only => [:new, :create, :update, :destroy]
  
  
  def check_admin_auth
    if !current_user.is_admin
      access_denied
    end
  end
  
  
  def set_section
    @section = 'FORUM' 
  end
  
  
  def index
    @forum_topics = ForumTopic.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @forum_topics }
      format.json { render :json => @forum_topics.to_json } 
    end
  end
  
  
  def show
    @forum_topic = ForumTopic.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render :xml => @forum_topic }
      format.json { render :json => @forum_topic.to_json } 
    end
  end


  def new
    @forum_topic = ForumTopic.new
  end


  def create
    @forum_topic = ForumTopic.new(params[:forum_topic])
    respond_to do |format|
      if @forum_topic.save
        flash[:notice] = 'ForumTopic was successfully created.'
        format.html { 
          if params['admin_page']
            redirect_to('/admin/forums')
          else
            redirect_to(@forum_topic) 
          end
         }
        format.xml  { render :xml => @forum_topic, :status => :created, :location => @forum_topic }
        format.json { render :json => @forum_topic.to_json, :status => :created, :location => @forum_topic} 
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @forum_topic.errors, :status => :unprocessable_entity }
        format.json { render :json => @forum_topic.errors.to_json, :status => :unprocessable_entity} 
      end
    end
  end


  def update
    @forum_topic = ForumTopic.find(params[:id])
    respond_to do |format|
      if @forum_topic.update_attributes(params[:forum_topic])
        flash[:notice] = 'ForumTopic was successfully updated.'
        format.html { redirect_to(@forum_topic) }
        format.xml  { head :ok }
        format.json { head :ok } 
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @forum_topic.errors, :status => :unprocessable_entity }
        format.json { render :json => @forum_topic.errors.to_json, :status => :unprocessable_entity } 
      end
    end
  end


  def destroy
    @forum_topic = ForumTopic.find(params[:id])
    @forum_topic.destroy
    respond_to do |format|
      format.html { redirect_to(forum_topics_url) }
      format.xml  { head :ok }
      format.json { head :ok } 
    end
  end
end
