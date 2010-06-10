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

require 'digest/md5'

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # if the user is currently logged in as an admin or creator return true
  def logged_in_as_admin?
    if logged_in? && (current_user.roles.include?(Role.creator) || current_user.roles.include?(Role.admin))
      return true
    else
      return false
    end
  end
  
  
  def display_widget(widget)
    if widget.protected == false || logged_in?
      render :partial => widget.path, :locals => {:widget=>widget}
    end
  end
  
  
  # Return a short snippet of the content passed in as 'text'
  #   text = text to shorten
  #   wordcount = number of words to display
  #   omission = text to display at end if text has been shortened
  def snippet(text, wordcount, omission)
    text.split[0..(wordcount-1)].join(" ") + (text.split.size > wordcount ? " " + omission : "")
  end
  
  
  # Check to see if the user is an admin or owner of the content
  def can_edit(item, user)
    if logged_in? && (user.is_admin || user.id == item.user.id)
      return true
    else
      return false
    end
  end
  
  
  # Display a Gravatar for a user
  # See www.gravatar.com for more info
  def gravatar_url_for(email, options = {})      
    url_for( {:gravatar_id => Digest::MD5.hexdigest(email), 
              :host => 'www.gravatar.com',                     
              :protocol => 'http://', 
              :only_path => false, 
              :controller => 'avatar.php'}.merge(options))  
  end
  
end
