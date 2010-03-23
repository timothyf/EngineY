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
  
end
