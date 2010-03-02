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

class AdminController < ApplicationController
  
  before_filter :login_required
  
  # Display the admin home page
  def index
    @stats
    @page = 'dashboard'
  end
  
  
  def settings
    @page = 'settings'
    @network = Network.find(:first) 
  end
  
  
  def users
    @page = 'users'
    users = User.find(:all) do
      if params[:_search] == "true"
        login =~ "%#{params[:login]}%" if params[:login].present?
        first_name =~ "%#{params[:first_name]}%" if params[:first_name].present?
        last_name  =~ "%#{params[:last_name]}%" if params[:last_name].present?                
        email     =~ "%#{params[:email]}%" if params[:email].present?   
        activated_at =~ "%#{params[:activated_at]}%" if params[:activated_at].present?     
      end
      paginate :page => params[:page], :per_page => params[:rows]      
      order_by "#{params[:sidx]} #{params[:sord]}"
    end

    respond_to do |format|
      format.html
      format.json { render :json => users.to_jqgrid_json([:id,:login, :first_name,:last_name,
                                                          :email,:activated_at, 
                                                          :password, :password_confirmation], 
                                                         params[:page], params[:rows], users.total_entries) }
    end 
  end
  
  
  def groups
    @page = 'groups'
    groups = Group.find(:all) do
      if params[:_search] == "true"
        name =~ "%#{params[:name]}%" if params[:name].present?
        featured =~ "%#{params[:featured]}%" if params[:featured].present?   
        creator_id =~ "%#{params[:creator_id]}%" if params[:creator_id].present? 
      end
      paginate :page => params[:page], :per_page => params[:rows]      
      order_by "#{params[:sidx]} #{params[:sord]}"
    end

    respond_to do |format|
      format.html
      format.json { render :json => groups.to_jqgrid_json([:id,:name, :creator_id, :featured ], 
                                                         params[:page], 
                                                         params[:rows], 
                                                         groups.total_entries) }
    end
  end
  
  
  def events
    @page = 'events'
    events = Event.find(:all) do
      if params[:_search] == "true"
        name =~ "%#{params[:name]}%" if params[:name].present?
        start_time =~ "%#{params[:start_time]}%" if params[:start_time].present?    
        end_time =~ "%#{params[:end_time]}%" if params[:end_time].present?   
        location =~ "%#{params[:location]}%" if params[:location].present?   
        organizer =~ "%#{params[:organizer]}%" if params[:organizer].present?     
      end
      paginate :page => params[:page], :per_page => params[:rows]      
      order_by "#{params[:sidx]} #{params[:sord]}"
    end

    respond_to do |format|
      format.html
      format.json { render :json => events.to_jqgrid_json([:id, :name, :start_time, :end_time, :location, :organizer ], 
                                                         params[:page], params[:rows], events.total_entries) }
    end
  end
  
      
  def blog_posts
    @page = 'blog_posts'
    blog_posts = BlogPost.find(:all) do
      if params[:_search] == "true"
        user_id     =~ "%#{params[:user_id]}%"    if params[:user_id].present?
        title       =~ "%#{params[:title]}%"      if params[:title].present?    
        parent_id   =~ "%#{params[:parent_id]}%"  if params[:parent_id].present?   
        published    =~ "%#{params[:published]}%"   if params[:published].present?   
        featured   =~ "%#{params[:featured]}%"  if params[:featured].present?     
      end
      paginate :page => params[:page], :per_page => params[:rows]      
      order_by "#{params[:sidx]} #{params[:sord]}"
    end
    respond_to do |format|
      format.html
      format.json { render :json => blog_posts.to_jqgrid_json([:id, :user_id, 
                                                          :title, :parent_id, 
                                                          :published, :featured ], 
                                                         params[:page], params[:rows], 
                                                         blog_posts.total_entries) }
    end
  end
  
  
  def post_user_data
    if params[:oper] == "del"
      User.find(params[:id]).destroy
    else
      user_params = { :login => params[:login], 
                      :first_name => params[:first_name], 
                      :last_name => params[:last_name], 
                      :email => params[:email],
                      :password => params[:password],
                      :password_confirmation => params[:password_confirmation]}
      if params[:id] == "_empty"
        user = User.create(user_params)
        user.activate
      else
        User.find(params[:id]).update_attributes(user_params)
      end
    end
    render :nothing => true
  end
  
  
  def post_group_data
    if params[:oper] == "del"
      Group.find(params[:id]).destroy
    else
      if params[:featured] == "49"
        featured = 1
      else
        featured = 0
      end
      group_params = {:name => params[:name], 
                      :featured => featured}
      if params[:id] == "_empty"
        group = Group.create(group_params)
      else
        Group.find(params[:id]).update_attributes(group_params)
      end
    end
    render :nothing => true
  end
  
 
  def post_event_data
    if params[:oper] == "del"
      Event.find(params[:id]).destroy
    else
      event_params = {:name => params[:name], 
                      :start_time => params[:start_time],
                      :end_time => params[:end_time],
                      :location => params[:location],
                      :organizer => params[:organizer]}
      if params[:id] == "_empty"
        event = Event.create(event_params)
      else
        Event.find(params[:id]).update_attributes(event_params)
      end
    end
    render :nothing => true
  end
  
  
  def export_member_list
    format = params[:format]
    if format == 'pdf'
      @list = User.pdf_list
    elsif format == 'txt'
      @list = User.txt_list
    elsif format == 'xls'
      @list = User.xls_list
    end
  end
  
  # Erase all database tables
  # VERY DANGEROUS FUNCTION
  def reset_db
    
  end
  
  
  # A pending user can be identified by looking at the enabled flag and the activiation_code field
  # Pending users will have enabled set to false and activation_code will be populated.
  def pending_users
    @pending_users = User.find(:all, :conditions => {:enabled => false, :activation_code => !nil})
    render :partial => 'pending_users'
  end
  
  
  # Approve a user who is waiting to activate his account
  def approve_user
    # set the enabled flag to true for the user
    # send out approval notification
  end

  
  # Reject a user who has signed up but is not  yet active
  def reject_user
    # set the enabled flag to false for the user
    # clear activation code (prevents user from showing up as pending user)
    # send out rejection notification
  end
  
end
