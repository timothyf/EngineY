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

class StatusPostsController < ApplicationController

  before_filter :login_required, :only => [:new, :edit, :create, :update, :destroy]
  
  
  def index
    if params[:user_id]
      # show status posts for the specified user
      @user = User.find(params[:user_id])
      @status_posts = @user.status_posts
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @status_posts }
        format.json  { render :json => @status_posts.to_json }
      end
    else
      @status_posts = StatusPost.find(:all)
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @status_posts }
        format.json  { render :json => @status_posts.to_json }
      end
    end
  end
  
  
  def show 
    @status_post = StatusPost.find(params[:id])
    respond_to do |format|
      format.xml { render :xml => @status_post } 
      format.json { render :json => @status_post.to_json } 
    end
  end


  def new
    @status_post = StatusPost.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @status_post }
    end
  end


  def edit
    @status_post = StatusPost.find(params[:id])
  end


  def create
    @status_post = StatusPost.new(params[:status_post])
    @status_post.user_id = current_user.id
    if @status_post.save
      respond_to do |format|
          flash[:notice] = 'StatusPost was successfully created.'
          format.html { render :json => @status_post.to_json, :status => :created, :location => @status_post }
          format.xml  { render :xml => @status_post, :status => :created, :location => @status_post }
          format.json  { render :json => @status_post.to_json, :status => :created, :location => @status_post }
      end
    else
      respond_to do |format|
        format.html { redirect_to(user_path(current_user)) }
        format.xml  { render :xml => @status_post.errors, :status => :unprocessable_entity }
        format.json  { render :json => @status_post.errors.to_json, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @status_post = StatusPost.find(params[:id])
    respond_to do |format|
      if @status_post.update_attributes(params[:status_post])
        flash[:notice] = 'StatusPost was successfully updated.'
        format.html { redirect_to(@status_post) }
        format.xml  { head :ok }
        format.json { head :ok } 
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @status_post.errors, :status => :unprocessable_entity }
        format.json  { render :json => @status_post.errors.to_json, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @status_post = StatusPost.find(params[:id])
    @status_post.destroy
    respond_to do |format|
      format.html { redirect_to(status_posts_url) }
      format.xml  { head :ok }
      format.json { head :ok } 
    end
  end
end
