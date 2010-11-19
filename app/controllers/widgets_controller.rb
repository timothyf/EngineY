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

# Each content box displayed on the home and profile page is considered a widget.
# Most widgets are loaded dynamically via a JavaScript AJAX call after the page
# has loaded.  This class contains methods to handle those dynamic widget load calls
# from the JavaScript.
class WidgetsController < ApplicationController
  
  before_filter :login_required, :only => [:new, :edit, :create, :update]


  # Called via an AJAX method to render a widget into a page
  # This method returns a chunk of HTML which is then displayed in the
  # appropriate position on the page using JavaScript.
  # The views/widgets directory contains the template files that are used
  # to define the widget views.  
  # Params:
  # @user_id = the ID of the currently logged on user
  # @widget_id = the ID of the WidgetLayout which points to a widget to load
  # @name = the name of a widget to load
  def render_widget
    user_id = params[:user_id]
    @group_id = params[:group_id]
    layout_id = params[:widget_id]
    @layout = WidgetLayout.find(layout_id)
    @widget_name = params[:name]
    render :template=>'widgets/'+ @widget_name, :locals=>{:user_id=>user_id}, :layout => 'widget'
  end
  
  
  def grid_data
    @widgets = Widget.find(:all)
    respond_to do |format|
      format.xml { render :partial => 'widgets/griddata.xml.builder', :layout=>false }
    end
  end
  
  
  # Used by an Admin function to create a new Widget
  def create
    @widget = Widget.new(params[:widget])
    respond_to do |format|
      if @widget.save
        flash[:notice] = 'Widget was successfully created.'
        format.html { 
          if params['admin_page']
            redirect_to('/admin/modules')
          else
            redirect_to(@widget) 
          end  
        }
        format.xml  { render :xml => @widget, :status => :created, :location => @widget }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @widget.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  # Used by an Admin function to update an existing widget
  def update
    @widget = Widget.find(params[:id])
    respond_to do |format|
      if @widget.update_attributes(params[:widget])
        flash[:notice] = 'Widget was successfully updated.'
        format.html { 
          if params['admin_page']
            redirect_to('/admin/modules')
          else
            redirect_to(@widget) 
          end  
         }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @widget.errors, :status => :unprocessable_entity }
      end
    end
  end


  # Used by an Admin function to delete an existing widget layout.
  def destroy
    @widget = Widget.find(params[:id])
    @widget.destroy
    respond_to do |format|
      format.html { redirect_to(widgets_url) }
      format.xml  { head :ok }
    end
  end

end
