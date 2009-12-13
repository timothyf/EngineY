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
    #type = params[:type]
    @user = User.find(params[:user_id])
    #if type == 'friends'
      @friends = @user.friends
      @title = "My Friends"
    #end
  end
  
  
  # Lists the requested friends of the specified user
  def requested_friends
    @user = User.find(params[:user_id])
    @friends = @user.requested_friends
    @title = "My Requested Friends"
    render :template=>'friends/index'
  end
  
  
  # Lists the pending friends of the specified user
  def pending_friends
    @user = User.find(params[:user_id])
    @friends = @user.pending_friends
    @title = "My Pending Friends"
    render :template=>'friends/index'
  end
  
  
  def show
    redirect_to user_path(params[:id])
  end
  
  
  def new
    @friendship1 = Friendship.new
    @friendship2 = Friendship.new
  end
  
  
  # Create a new friendship request
  def create
    @user = User.find(current_user)
    @friend = User.find(params[:friend_id])
    if Friendship.request(@user, @friend)
      redirect_to user_path(@friend)
    else
      redirect_to user_path(current_user)
    end
  end
  
  
  def update 
    @user = User.find(current_user)
    @friend = User.find(params[:id])
    #params[:friendship1] = {:user_id => @user.id, :friend_id => @friend.id, :status => 'accepted'}
    #params[:friendship2] = {:user_id => @friend.id, :friend_id => @user.id, :status => 'accepted'}
    #@friendship1 = Friendship.find_by_user_id_and_friend_id(@user.id, @friend.id)
    #@friendship2 = Friendship.find_by_user_id_and_friend_id(@friend.id, @user.id)
    #if @friendship1.update_attributes(params[:friendship1]) && @friendship2.update_attributes(params[:friendship2])
    if Friendship.accept(@user, @friend)
      flash[:notice] = 'Friend sucessfully accepted!'
      redirect_to user_friends_path(current_user)
    else
      redirect_to user_path(current_user)
    end
  end
  
  
  def destroy
    @user = User.find(params[:user_id])
    @friend = User.find(params[:id])
    Friendship.breakup(@user, @friend)
    redirect_to user_path(@user)
  end
  
end
