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

=begin
  This controller provides functionality related to the ability to create and
  manage friends.  The friends functionality is similar to the friends feature
  of the Facebook site.
=end
class FriendsController < ApplicationController
  
  before_filter :login_required, :except => [:index, :show]
  
  # Lists all friends of the specified user
  def index
    @user = User.find(params[:user_id])
    type = params[:type]
    if type
      if type == 'requested'
        @friends = @user.requested_friends
        @title = 'My Requested Friends'
      elsif type == 'pending'
        @friends = @user.pending_friends
        @title = 'My Pending Friends'
      end
    else
      @title = 'My Friends'
      @friends = @user.friends
    end
    respond_to do |format|
      format.html {  } 
      format.xml  { render :xml => @friends }
      format.json { render :json => @friends.to_json }
    end
  end
  
  
  # Lists the requested friends of the specified user
  def requested_friends
    @user = User.find(params[:user_id])
    @friends = @user.requested_friends
    @title = "My Requested Friends"
    respond_to do |format|
      format.html { render :template=>'friends/index' } 
      format.xml  { render :xml => @friends }
      format.json { render :json => @friends.to_json }
    end
  end
  
  
  # Lists the pending friends of the specified user
  def pending_friends
    @user = User.find(params[:user_id])
    @friends = @user.pending_friends
    @title = "My Pending Friends"
    respond_to do |format|
      format.html { render :template=>'friends/index' } 
      format.xml  { render :xml => @friends }
      format.json { render :json => @friends.to_json }
    end
  end
  
  
  def show
    redirect_to user_path(params[:id])
  end
  
  
  # Create a new friendship request
  def create
    @user = User.find(current_user)
    @friend = User.find(params[:friend_id])  
    respond_to do |format|
      format.html { 
        if Friendship.request(@user, @friend)
          redirect_to user_path(@friend)
        else
          redirect_to user_path(current_user)
        end
      }
      format.xml { 
        if Friendship.request(@user, @friend)
          render :xml => @friend, :status => :created 
        else
           render :xml => {:error=>'Could not create request'}, :status => :unprocessable_entity
        end
      }
      format.json { 
        if Friendship.request(@user, @friend)
          render :json => @friend.to_json, :status => :created 
        else
          render :json => {:error=>'Could not create request'}.to_json, :status => :unprocessable_entity
        end
      }
    end

  end
  
  
  def update 
    @user = User.find(current_user)
    @friend = User.find(params[:id])
    if Friendship.accept(@user, @friend)
      respond_to do |format|
        format.html { 
          flash[:notice] = 'Friend sucessfully accepted!'
          redirect_to user_friends_path(current_user)
         }
         format.xml { render :xml => @friend, :status => :created }
         format.json { render :json => @friend.to_json, :status => :created }
      end
    else
      respond_to do |format|
        format.html { redirect_to user_path(current_user) }
        format.xml  { render :xml => {:error=>'unable to save'}, :status => :unprocessable_entity }
        format.json { render :json => {:error=>'unable to save'}.to_json, :status => :unprocessable_entity }
      end
    end
  end
  
  
  def destroy
    @user = User.find(params[:user_id])
    @friend = User.find(params[:id])
    Friendship.breakup(@user, @friend)
    redirect_to user_path(@user)
  end
  
end
