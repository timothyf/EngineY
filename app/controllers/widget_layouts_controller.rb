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
class WidgetLayoutsController < ApplicationController

  # Called via an AJAX method to load a widget into a page
  # This method returns a chunk of HTML which is then displayed in the
  # appropriate position on the page using JavaScript.
  # The views/widgets directory contains the template files that are used
  # to define the widget views.  
  # A template file that contains the text 'home' is a widget displayed on the home page.  
  # A template file that contains the text 'profile' is a widget displayed on the profile page.
  def load
    layout_id = params[:layout_id]
    if layout_id
      @layout = WidgetLayout.find(layout_id) 
      @widget_name = @layout.widget.name  
    else
      @widget_name = params[:name]
      widget = Widget.find_by_name(@widget_name)
      @layout = WidgetLayout.find_by_widget_id(widget.id)
    end
    if @widget_name == 'status_posts_profile'
      activity_widget = Widget.find_by_name('activity_feed_profile')
      @activity_profile_layout_id = WidgetLayout.find_by_widget_id(activity_widget.id).id
    end
    if @widget_name == 'html_content_home'
      @content = HtmlContent.find(@layout.html_content_id)
    end
    user_id = params[:user_id]
    if params[:include_friends] && params[:include_friends] == 'true'
      include_friends = true
    end
    if params[:only_statuses] && params[:only_statuses] == 'true'
      only_statuses = true
    end
    render :template=>'widgets/'+ @widget_name, :locals=>{:include_friends=>include_friends, :only_statuses=>only_statuses, :user_id=>user_id}, :layout => 'widget'
  end
  
  
  def create
    @widget_layout = WidgetLayout.new(params[:widget_layout])
    respond_to do |format|
      if @widget_layout.save
        flash[:notice] = 'WidgetLayout was successfully created.'
        format.html { 
          if params['admin_page']
            redirect_to('/admin/pages')
          else
            redirect_to(@widget_layout) 
          end  
        }
        format.xml  { render :xml => @widget_layout, :status => :created, :location => @widget_layout }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @widget_layout.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @widget_layout = WidgetLayout.find(params[:id])
    respond_to do |format|
      if @widget_layout.update_attributes(params[:widget_layout])
        flash[:notice] = 'WidgetLayout was successfully updated.'
        format.html { 
          if params['admin_page']
            redirect_to('/admin/pages')
          else
            redirect_to(@widget_layout) 
          end  
         }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @widget_layout.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @widget_layout = WidgetLayout.find(params[:id])
    @widget_layout.destroy
    respond_to do |format|
      format.html { redirect_to(widget_layouts_url) }
      format.xml  { head :ok }
    end
  end
  
end
