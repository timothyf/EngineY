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
  
  
  def stats
    @page = 'stats'
  end
  
  
  def photos
    @page = 'photos'
    @photos = Photo.find(:all) 
  end
  
  
  def contents
    @page = 'contents'
    @html_contents = HtmlContent.find(:all)
  end
  
  
  def modules
    @page = 'modules'
    @widgets = Widget.find(:all)
    @layouts = WidgetLayout.find(:all)
    @pages = Page.find(:all)
    @modules = EyModule.find(:all)
  end
  
  
  def pages
    @page = 'pages'
    @pages = Page.find(:all) 
  end
  
  
  def tabs
    @page = 'tabs'
    @tabs = NavItem.find(:all)
  end
  
  
  # Display the Users tab of the Admin page.
  def users
    @page = 'users'
    respond_to do |format|
      format.html {
        @users = User.find(:all)
        @admins = User.admins_and_creators
        @pending_users = User.pending_users
      }
      format.json {}
    end 
  end
  
  
  def admin_users
    respond_to do |format|
      format.html {}
      format.json {}
    end 
  end
  
  
  # Display the Groups tab of the Admin page.
  def groups
    @page = 'groups'
    respond_to do |format|
      format.html {
        @groups = Group.find(:all)
      }
      format.json { }
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
      format.json {}
    end
  end

  
  # Display the Events tab of the Admin page.
  def events
    @page = 'events'
    respond_to do |format|
      format.html {
        @events = Event.find(:all)
      }
      format.json {}
    end
  end

  def locations
    @page = 'locations'
    respond_to do |format|
      format.html {
        @locations = Location.find(:all)
      }
      format.json{}
    end
  end
  
      
  # Display the Blog Posts tab of the Admin page.
  def blog_posts
    @page = 'blog_posts'
    @blog_post_topics = BlogPostTopic.find(:all)
    respond_to do |format|
      format.html {
        @blog_posts = BlogPost.find(:all, :order => 'created_at DESC')
      }
      format.json {}
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
  
  
  def api_keys
    @users = User.with_api_key
  end
  
  
  def api_test
    
  end
  
  
  def module_new
    @module = EyModule.new
    render 'module_form'
  end
  
  
  def module_edit
    @module = EyModule.find(params[:id])
    render 'module_form'
  end
  
  
  def module_delete
    
  end
  
  
  def page_new
    @page = Page.new
    render 'page_form'
  end
  
  
  def page_edit
    @page = Page.find(params[:id])
    render 'page_form'
  end
  
  
  def page_delete
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to '/admin/pages'
  end
  
  
  def content_new
    @html_content = HtmlContent.new
    render 'html_content_form'
  end
  
  
  def content_edit
    @html_content = HtmlContent.find(params[:id])
    render 'html_content_form'
  end
  
  
  def content_delete
    
  end
  
  
  def widget_new
    @widget = Widget.new
    render 'widget_form'
  end
  
  
  def widget_edit
    @widget = Widget.find(params[:id])
    render 'widget_form'
  end
  
  
  def widget_delete

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
  
  
  def blog_post_new
    @blog_post = BlogPost.new
    @blog_post_topics = BlogPostTopic.find(:all)
    render 'blog_post_form'
  end
  
  
  def blog_post_edit
    @blog_post = BlogPost.find(params[:id])
    @blog_post_topics = BlogPostTopic.find(:all)
    render 'blog_post_form'
  end
  
  
  def blog_post_delete
    @blog_post = BlogPost.find(params[:id])
    @blog_post.destroy
    redirect_to '/admin/blog_posts'
  end
  
  
  # Exports all blog posts to an XML or JSON file
  def blog_post_export
    headers['Content-Type'] = "text/xml"
    headers['Content-Disposition'] = 'attachment; filename="blog_posts_export.xml"'
    @posts = BlogPost.find(:all)
    render :template=>'blog_posts/export.xml.builder', :xml=>@posts, :type => :builder 
  end
  
  
  # Imports blog posts from an XML or JSON file into the database
  def blog_post_import
    require 'rexml/document'
    doc = REXML::Document.new(params[:blog_posts_file].read) 
    doc.elements.each("posts/post") do |element| 
      blog_post = BlogPost.create(
          :user => current_user,
          :title => element.elements["title"].text,
          :body => element.elements["body"].text,
          :created_at => element.elements["created_at"].text,
          :updated_at => element.elements["created_at"].text,
          :views => element.elements["views"].text,
          :published => false
      )
      
      # process topics
      element.elements.each("topics/topic") do |topic_el|
        topic = topic_el.elements["name"].text
        bp_topic = BlogPostTopic.find_or_create_by_name(topic)
        blog_post.blog_post_topics << bp_topic
        blog_post.save
      end
      
      # process tags
      tags = []
      element.elements.each("tags/tag") do |tag_el|
        tags << tag_el.elements["name"].text
      end
      blog_post.tag_list = tags.join(',')
      blog_post.save
    end
    redirect_to '/admin/blog_posts'
  end
  
  
  def photo_add
    sleep 5
    @photo = Photo.new(params[:photo])
    @photo.user = current_user;
    if @photo.save
      flash[:notice] = 'Photo was successfully created.'
      redirect_to '/admin/photos'    
    else
      redirect_to '/admin/photos'
    end
  end
  
  
  def photo_delete
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to '/admin/photos'
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
    @locations = Location.find(:all, :order => "name")
    render 'event_form'
  end
  
  
  def event_edit
    @event = Event.find(params[:id])
    @locations = Location.find(:all, :order => "name")
    render 'event_form'
  end

  def location_new
    @location = Location.new
    render 'location_form'
  end

  def location_edit
    @location = Location.find(params[:id])
    render 'location_form'
  end
  
  
  def user_new
    @user = User.new
    render 'user_form'
  end
  
  
  def user_edit
    @user = User.find(params[:id])
    render 'user_form'
  end
  
  
  def user_approve
    @user = User.find(params[:id])
    @user.approve
    redirect_to '/admin/users'
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
  
  
  def network_url
    @network = Network.find(:first)
  end
  
  
  def network_admin_email
    @network = Network.find(:first)
  end
  
  
  def network_description
    @network = Network.find(:first)
  end
  
  
  def privacy_edit
    if HtmlContent.find_by_title('privacy')
      @privacy = HtmlContent.find_by_title('privacy')
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
      privacy.title = 'privacy'
      privacy.save
    end    
    redirect_to :action => 'settings' 
  end
  
  
  # Used to display the current Analytics code
  def analytics_code
    if HtmlContent.find_by_title('?analytics?')
      @analytics = HtmlContent.find_by_title('?analytics?')
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
      analytics.title = '?analytics?'
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
    if params[:network_url]
      network.update_attributes(:url => params[:network_url]) 
    end
    if params[:network_admin_email]
      network.update_attributes(:admin_email => params[:network_admin_email]) 
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
                      :location_id => params[:location_id],
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
