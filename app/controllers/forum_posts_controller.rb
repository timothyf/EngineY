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

class ForumPostsController < ApplicationController

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
     
  before_filter :set_section
  
  before_filter :login_required, :only => [:new, :edit, :create, :update, :destroy]
  
  
  def set_section
    @section = 'FORUM' 
  end
  
  
  def grid_data
    if params[:forum_topic_id]
      @forum_topic = ForumTopic.find(params[:forum_topic_id])
      @forum_posts = @forum_topic.forum_threads
    else
      if current_user
        # just get posts for current user
        @forum_posts = current_user.forum_posts
      end
    end
    respond_to do |format|
      format.xml { render :partial => 'forum_posts/griddata.xml.builder', :layout=>false }
    end
  end
  
  
  def index
    if params[:forum_topic_id]
      @forum_topic = ForumTopic.find(params[:forum_topic_id])
      @forum_posts = @forum_topic.forum_threads
    else
      if current_user
        # just get posts for current user
        @forum_posts = current_user.forum_posts
      else
        redirect_to(forum_topics_url)
        return
      end
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @forum_posts }
    end
  end


  def show
    @forum_post = ForumPost.find(params[:id])
    if @forum_post.parent_id != nil
      @forum_post = ForumPost.find(@forum_post.parent_id)
    end
    @forum_post.update_attributes(:views=>@forum_post.views+1)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @forum_post }
    end
  end


  def new
    @forum_post = ForumPost.new
    #@forum_topic_id = params[:forum_topic_id]
    @forum_post.forum_topic_id = params[:forum_topic_id]
   respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @forum_post }
    end
  end


  def edit
    @forum_post = ForumPost.find(params[:id])
  end


  def create
    @forum_post = ForumPost.new(params[:forum_post])
    @forum_post.user = current_user;
    respond_to do |format|
      if @forum_post.save
        if params[:ajax_call]
          @forum_post = ForumPost.find(@forum_post.parent_id)
          format.html { render :partial=>'forum_post_replies', :layout=>false }
        else
          flash[:notice] = 'ForumPost was successfully created.'
          format.html { redirect_to(@forum_post) }
          format.xml  { render :xml => @forum_post, :status => :created, :location => @forum_post }
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @forum_post.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @forum_post = ForumPost.find(params[:id])
    respond_to do |format|
      if @forum_post.update_attributes(params[:forum_post])
        flash[:notice] = 'ForumPost was successfully updated.'
        format.html { redirect_to(@forum_post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @forum_post.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @forum_post = ForumPost.find(params[:id])
    @forum_post.destroy
    respond_to do |format|
      format.html { redirect_to(forum_posts_url) }
      format.xml  { head :ok }
    end
  end
end
