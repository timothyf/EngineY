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

class WallPostsController < ApplicationController

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
  

  def new
    @wall_post = WallPost.new
  end


  def edit
    @wall_post = WallPost.find(params[:id])
  end


  def create
    @wall_post = WallPost.new(params[:wall_post])
    if params[:group_id]
      @wall_post.group_id = params[:group_id]
    elsif params[:event_id]
      @wall_post.event_id = params[:event_id]
    else
      @wall_post.user_id = params[:user_id]
    end
    @wall_post.sender_id = current_user.id
    respond_to do |format|
      if @wall_post.save
        flash[:notice] = 'WallPost was successfully created.'
        if params[:group_id]
          @parent = Group.find(params[:group_id])
        elsif params[:event_id]
          @parent = Event.find(params[:event_id])
        else
          # TODO send email notification to recipient user
          
          @user = User.find(params[:user_id])
          @parent = @user
        end
        format.html { render :partial => 'shared/wall_posts', :locals=>{:parent=>@parent}, :layout=>false }
      else
        format.html { render :action => "new" }
      end
    end
  end


  def update
    @wall_post = WallPost.find(params[:id])
    respond_to do |format|
      if @wall_post.update_attributes(params[:wall_post])
        flash[:notice] = 'WallPost was successfully updated.'
        format.html { redirect_to(@wall_post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wall_post.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @wall_post = WallPost.find(params[:id])
    if @wall_post.group_id
      @parent = Group.find(@wall_post.group_id)
    elsif @wall_post.event_id
       @parent = Event.find(@wall_post.event_id)
    else
      @user = User.find(@wall_post.user_id)
      @parent = @user
    end
    
    @wall_post.destroy
    respond_to do |format|
      format.html { render :partial => 'shared/wall_posts', :locals=>{:parent=>@parent}, :layout=>false }
      format.xml  { head :ok }
    end
  end
end
