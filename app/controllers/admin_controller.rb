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
                            
  before_filter :login_required
  
  # Display the Dashboard tab of the Admin page.
  def index
    @page = 'dashboard'
  end
  
  
  # Display the Settings tab of the Admin page.
  def settings
    @page = 'settings'
    @network = Network.find(:first) 
  end
  
  
  def pages
    @widgets = Widget.find(:all)
    @layouts = WidgetLayout.find(:all)
    @pages = Page.find(:all) 
    @html_contents = HtmlContent.find(:all) 
  end
  
  
  # Display the Users tab of the Admin page.
  def users
    @page = 'users'
    respond_to do |format|
      format.html {
        @users = User.find(:all)
        @admins = User.admins_and_creators
      }
      format.json { 
        users = User.find(:all) do
          if contains_search(params)
            login =~ "%#{params[:login]}%" if params[:login].present?
            first_name =~ "%#{params[:first_name]}%" if params[:first_name].present?
            last_name  =~ "%#{params[:last_name]}%" if params[:last_name].present?                
            email     =~ "%#{params[:email]}%" if params[:email].present?   
            activated_at =~ "%#{params[:activated_at]}%" if params[:activated_at].present?     
          end
          paginate :page => params[:page], :per_page => params[:rows]      
          order_by "#{params[:sidx]} #{params[:sord]}"
        end
        
        render :json => users.to_jqgrid_json([:id,:login, :first_name,:last_name,
                                                          :email,:activated_at, 
                                                          :password, :password_confirmation, :admin_flag], 
                                                         params[:page], params[:rows], users.total_entries) }
    end 
  end
  
  
  def admin_users
    respond_to do |format|
      format.html {}
      format.json { 
        @page = 'users'
        admins = User.find(:all, :conditions => ['role_id = ? OR role_id = ?', Role.creator.id, Role.admin.id], :joins => :permissions) do
          if contains_search(params)
            login =~ "%#{params[:login]}%" if params[:login].present?
            first_name =~ "%#{params[:first_name]}%" if params[:first_name].present?
            last_name  =~ "%#{params[:last_name]}%" if params[:last_name].present?                
            email     =~ "%#{params[:email]}%" if params[:email].present?   
            activated_at =~ "%#{params[:activated_at]}%" if params[:activated_at].present?     
          end
          paginate :page => params[:page], :per_page => params[:rows]      
          order_by "#{params[:sidx]} #{params[:sord]}"
        end
        
        render :json => admins.to_jqgrid_json([:id,:login, :first_name,:last_name,
                                                          :email,:activated_at, 
                                                          :password, :password_confirmation], 
                                                         params[:page], params[:rows], admins.total_entries) }
    end 
  end
  
  
  # Display the Groups tab of the Admin page.
  def groups
    @page = 'groups'
    respond_to do |format|
      format.html {
        @groups = Group.find(:all)
      }
      format.json { 
        groups = Group.find(:all) do
          if contains_search(params)
            name =~ "%#{params[:name]}%" if params[:name].present?
            featured =~ "%#{params[:featured]}%" if params[:featured].present?   
            creator_id =~ "%#{params[:creator_id]}%" if params[:creator_id].present? 
          end
          paginate :page => params[:page], :per_page => params[:rows]      
          order_by "#{params[:sidx]} #{params[:sord]}"
        end 
        render :json => groups.to_jqgrid_json([:id,:name, :creator_id, :featured ], 
                                                         params[:page], 
                                                         params[:rows], 
                                                         groups.total_entries) }
    end
  end
  
  
  def group_users
    if params[:id].present?
      users = Group.find(params[:id]).users.find(:all) do
        paginate :page => params[:page], :per_page => params[:rows]      
        order_by "#{params[:sidx]} #{params[:sord]}"        
      end
      total_entries = users.total_entries
    else
      group_users = []
      total_entries = 0
    end
    respond_to do |format|
      format.html {}
      format.json { render :json => users.to_jqgrid_json([:id, :login, :first_name, :last_name, :email], params[:page], params[:rows], total_entries) }
    end
  end

  
  # Display the Events tab of the Admin page.
  def events
    @page = 'events'
    respond_to do |format|
      format.html {
        @events = Event.find(:all)
      }
      format.json { 
        events = Event.find(:all) do
          if contains_search(params)
            name =~ "%#{params[:name]}%" if params[:name].present?
            start_time =~ "%#{params[:start_time]}%" if params[:start_time].present?    
            end_time =~ "%#{params[:end_time]}%" if params[:end_time].present?   
            location =~ "%#{params[:location]}%" if params[:location].present?   
            organizer =~ "%#{params[:organizer]}%" if params[:organizer].present?     
          end
          paginate :page => params[:page], :per_page => params[:rows]      
          order_by "#{params[:sidx]} #{params[:sord]}"
        end
        render :json => events.to_jqgrid_json([:id, :name, :start_time, :end_time, :location, :organizer ], 
                                                         params[:page], params[:rows], events.total_entries) }
    end
  end
  
      
  # Display the Blog Posts tab of the Admin page.
  def blog_posts
    @page = 'blog_posts'
    respond_to do |format|
      format.html {
        @blog_posts = BlogPost.find(:all)
      }
      format.json { 
        blog_posts = BlogPost.find(:all) do
          if contains_search(params)
            user_id     =~ "%#{params[:user_id]}%"    if params[:user_id].present?
            title       =~ "%#{params[:title]}%"      if params[:title].present?    
            parent_id   =~ "%#{params[:parent_id]}%"  if params[:parent_id].present?   
            published    =~ "%#{params[:published]}%"   if params[:published].present?   
            featured   =~ "%#{params[:featured]}%"  if params[:featured].present?     
          end
          paginate :page => params[:page], :per_page => params[:rows]      
          order_by "#{params[:sidx]} #{params[:sord]}"
        end
        render :json => blog_posts.to_jqgrid_json([:id, :user_id, 
                                                          :title, :parent_id, 
                                                          :published, :featured ], 
                                                         params[:page], params[:rows], 
                                                         blog_posts.total_entries) }
    end
  end
  
  
  # Display the Forums tab of the Admin page.
  def forums
    @page = 'forums'
    respond_to do |format|
      format.html {
        @forum_topics = ForumTopic.find(:all)
        @forum_posts = ForumPost.find(:all)
      }
    end
  end
  
  
  def content_new
    @html_content = HtmlContent.new
    render 'html_content_form'
  end
  
  
  def content_edit
    @html_content = HtmlContent.find(params[:id])
    render 'html_content_form'
  end
  
  
  def layout_new
    @widget_layout = WidgetLayout.new
    render 'widget_layout_form'
  end
  
  
  def layout_edit
    @widget_layout = WidgetLayout.find(params[:id])
    render 'widget_layout_form'
  end
  
  
  def layout_delete
    @layout = WidgetLayout.find(params[:id])
    @layout.destroy
    redirect_to '/admin/pages'
  end
  
  
  def forum_topic_new
    @forum_topic = ForumTopic.new
    render 'forum_topic_form'
  end
  
  
  def blog_post_edit
    @blog_post = BlogPost.find(params[:id])
    render 'blog_post_form'
  end
  
  
  def group_new
    @group = Group.new
    render 'group_form'
  end
  
  
  def group_edit
    @group = Group.find(params[:id])
    @show_full = true
    render 'group_form'
  end
  
  
  def event_new
    @event = Event.new
    render 'event_form'
  end
  
  
  def event_edit
    @event = Event.find(params[:id])
    render 'event_form'
  end
  
  
  def user_new
    @user = User.new
    render 'user_form'
  end
  
  
  def user_edit
    @user = User.find(params[:id])
    render 'user_form'
  end
  
  
  def user_activate
    @user = User.find(params[:id])
    @user.activate
    redirect_to '/admin/users'
  end
  
  
  def user_delete
    @user = User.find(params[:id])
    @user.destroy
    redirect_to '/admin/users'
  end
  
  
  def user_promote
    @user = User.find(params[:id])
    @user.make_site_admin
    redirect_to '/admin/users'
  end
  
  
  def network_name
    @network = Network.find(:first)
  end
  
  
  def network_description
    @network = Network.find(:first)
  end
  
  
  def privacy_edit
    if HtmlContent.find_by_content_id('privacy')
      @privacy = HtmlContent.find_by_content_id('privacy')
    else
      @privacy = HtmlContent.new
    end
  end
  
  
  def save_privacy
    if params[:id] && params[:id] != ''
      privacy = HtmlContent.find(params[:id])
      privacy.update_attributes(:body => params[:privacy_text]) 
    else
      privacy = HtmlContent.new
      privacy.body = params[:privacy_text]
      privacy.content_id = 'privacy'
      privacy.save
    end    
    redirect_to :action => 'settings' 
  end
  
  
  # Used to display the current Analytics code
  def analytics_code
    if HtmlContent.find_by_content_id('analytics')
      @analytics = HtmlContent.find_by_content_id('analytics')
    else
      @analytics = HtmlContent.new
    end
  end
  
  
  # Used to save the analytics code
  def save_analytics
    if params[:id] && params[:id] != ''
      analytics = HtmlContent.find(params[:id])
      analytics.update_attributes(:body => params[:analytics_text]) 
    else
      analytics = HtmlContent.new
      analytics.body = params[:analytics_text]
      analytics.content_id = 'analytics'
      analytics.save
    end    
    redirect_to :action => 'settings' 
  end
  
  
  # Used to save the network name or description
  def save_network
    network = Network.find(params[:id]) 
    if params[:network_name]
      network.update_attributes(:name => params[:network_name]) 
    end
    if params[:network_description]
      network.update_attributes(:description => params[:network_description]) 
    end  
    redirect_to :action => 'settings' 
  end
  
  
  # This method is called when the admin user Edits and saves a user via the Ajax form
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
        user = User.find(params[:id])
        user.update_attributes(user_params)
      end
      if params[:admin_flag] == 'on'
        user.make_site_admin
      end
    end
    render :nothing => true
  end
  
  
  # This method is called when the admin user Edits and saves a group via the Ajax form
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
  
 
  # This method is called when the admin user Edits and saves an event via the Ajax form
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
  
  
  # Get the member list in a variety of formats
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
  
  private
  def contains_search(params)
    params[:_search] == "true"
  end
  
  
end
