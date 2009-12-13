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


# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  
  #include Facebooker::Rails::Controller

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  :secret => '18dded240a4f5e0ac9b540fd7a8ce7bd'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  
  before_filter :set_vars, :update_session
  before_filter :set_facebook_session
  helper_method :facebook_session

  include AuthenticatedSystem
  
=begin
  def set_facebook_session
    # first, see if we already have a session
    session_set = session_already_secured?
    # if not, see if we can load it from the environment
    unless session_set
      session_set = create_facebook_session
      if session_set
        session[:facebook_session] = @facebook_session
        session[:sig] = params[:session_sig]
      else
        session[:facebook_session] = nil
      end
    end
    if session_set
      #capture_facebook_friends_if_available! 
      #Session.current = facebook_session
    end
    return session_set
  end
  
  
  def session_already_secured?
    (@facebook_session = session[:facebook_session]) && session[:facebook_session].secured?
  end
  
  
  def create_facebook_session
    if params[:session_key]
      secure_with_facebook_params!
    else
      false
    end
  end
  
  
  def secure_with_facebook_params!
      @facebook_session = new_facebook_session
      @facebook_session.secure_with!(params['session_key'], params['session_uid'], params['session_expires'])
      @facebook_session
  end
  
  
  def new_facebook_session
    Facebooker::Session.create(Facebooker.api_key, Facebooker.secret_key)
  end
  
  
  def facebook_session
    session[:facebook_session]
  end
=end 
  
  def set_vars
     @network = Network.network
  end
  
  
  def update_session
#    session.model.update_attribute(:user_id, session[:user_id])
#    if logged_in?
#      # TODO ignore AJAX urls
#      if !request.url.index('widgets/load')
#        session.model.update_attribute(:last_url_visited, request.url)
#      end
#    end
  end
  
  
  # Determine which users are currently signed in
  def who_is_online
    time_window = Time.now.utc - 30.minutes.to_i
    online_sessions = CGI::Session::ActiveRecordStore::Session.find(:all,
                                 :select => "user_id, last_url_visited, updated_at",
                                 :conditions => [ "updated_at > ? and user_id is not null", time_window ],
                                 :limit => 50 )
    online_users = []
    online_sessions.each do |session|
      online_users << User.find(session.user_id)
    end
    online_users
  end
  
end
