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

class GroupsController < ApplicationController
  
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
  
  # must be a group admin to edit or update a group
  before_filter :check_group_auth, :only => [:edit, :update]
  
  # must be an admin to create new groups
  before_filter :check_admin_auth, :only => [:new, :create]
  
  
  def user_data
      @group = Group.find(params[:group_id])
      @users = @group.users
      items = []
      @users.each do |user|
        membership = user.memberships.find_by_group_id(@group.id)
        items.push({:id => user.id,
                    :name => user.name,
                    :email => user.email,
                    :role => membership.role.rolename,
                    :created_at => membership.created_at})
      end
      result = {}
      result[:identifier] = 'id'
      result['label'] = 'id'
      result['items'] = items
      render :json=>result, :layout=>false
  end
  
  
  def check_admin_auth
    if !current_user.is_admin
      access_denied
    end
  end
  
  
  def check_group_auth
    if !current_user.is_group_admin(Group.find(params[:id]))
      access_denied
    end
  end
  
  
  def index
    @section = 'GROUPS'   
    if params[:user_id]
      @user = User.find(params[:user_id])
      @groups = @user.groups
    else 
      @groups = Group.find(:all)
    end  
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
      format.json { render :json => @groups.to_json }
    end
  end


  def show
    @group = Group.find(params[:id])
    @page = Page.find_by_name('group')
    @section = 'GROUP'
    if @group
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @group }
        format.json { render :json => @group } 
      end
    else
      respond_to do |format|
        format.xml { render :status => :unprocessable_entity } 
        format.json { render :status => :unprocessable_entity } 
      end
    end
  end


  def new
    @group = Group.new
  end


  def edit
    @group = Group.find(params[:id])
    @show_full = true
  end


  def create
    sleep 4  # required for photo upload
    @group = Group.new(params[:group])
    @group.creator = current_user;
    respond_to do |format|
      if @group.save
        if params[:group_photo] 
          # save group photo
          @group.profile_photo = ProfilePhoto.create!(:is_profile=>true, :uploaded_data => params[:group_photo]) if params[:group_photo].size != 0 
        end               
        flash[:notice] = 'Group was successfully created.'
        format.html { 
          if params['admin_page']
            redirect_to('/admin/groups')
          else
            redirect_to(@group) 
          end
        }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
        format.json { render :json => @group.to_json, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
        format.json { render :json => @group.errors.to_json, :status => :unprocessable_entity }
      end
    end
  end


  def update
    sleep 4  # required for photo upload
    @group = Group.find(params[:id])
    respond_to do |format|
      if @group.update_attributes(params[:group])       
        if params[:group_photo] && params[:group_photo].size != 0 
          # remove old profile photos
          Photo.destroy_all("group_id = " + @group.id.to_s + " AND is_profile = true")
          profile_photo = ProfilePhoto.create!(:group_id=>@group.id, :is_profile=>true, :uploaded_data => params[:group_photo]) if params[:group_photo].size != 0 
          @group.profile_photo = profile_photo
        end         
        flash[:notice] = 'Group was successfully updated.'
        format.html { 
          if params['admin_page']
            redirect_to('/admin/groups')
          else
            redirect_to(@group) 
          end
        }
        format.xml  { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
        format.json  { render :json => @group.errors.to_json, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    respond_to do |format|
      format.html { redirect_to(groups_url) }
      format.xml  { head :ok }
      format.json { head :ok } 
    end
  end
end
