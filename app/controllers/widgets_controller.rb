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
  
  
  # Called via an AJAX method to load a widget into the home page
  # The widgets to be loaded are defined in the Configuration model class.
  # This method returns a chunk of HTML which is then displayed in the
  # appropriate position on the page using JavaScript.
  # The views/widgets directory contains the template files that are used
  # to define the widget views.  
  # A template file that contains the text 'home' is a widget displayed on the home page.  
  # A template file that contains the text 'profile' is a widget displayed on the profile page.
  def load
    # get name of widget to load
    @widget_name = params[:name]
    content_id = params[:content_id]  # HTML widgets also pass a content_id which is used to identify content in the db 
    if content_id
      @content = HtmlContent.find_by_content_id(content_id)
      if !@content
        # create content
        HtmlContent.create(:title=>'New Content', :body=>'Add Some Content', :content_id=>content_id)
        @content = HtmlContent.find_by_content_id(content_id)
      end
      render :template=>'widgets/html_content_home', :layout => 'widget'
    else
      render :template=>'widgets/'+ @widget_name, :layout => 'widget'
    end
  end
  
  
  # Called via an AJAX method to load a widget into a profile page
  # The widgets to be loaded are defined in the Configuration model class.
  def load_profile_widget
    # get name of widget to load
    @widget_name = params[:name]
    user_id = params[:user_id]
    if params[:include_friends]
      include_friends = true
    end
    if params[:only_statuses]
      only_statuses = true
    end
    # render widget
    render :template=>'widgets/' + @widget_name, :locals=>{:include_friends=>include_friends, :only_statuses=>only_statuses, :user_id=>user_id}, :layout => 'widget'
  end


  def grid_data
    @widgets = Widget.find(:all)
    respond_to do |format|
      format.xml { render :partial => 'widgets/griddata.xml.builder', :layout=>false }
    end
  end
  
  
  # Get settings for a particular widget
  def get_settings  
    render :json=>''
  end

end
