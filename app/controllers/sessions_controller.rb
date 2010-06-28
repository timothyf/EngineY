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

# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem


  def new
end


  def test
    render :template=>'sessions/test'
  end

  
  # Called to login a user who has already logged in via Facebook on the frontend
  # The facebook session is sent back to the server.
  def facebook_login
    
    # if user can not be mapped to an existing user via email hash or facebook_id,
    # render the facebook login page which asks the user to create a local account
    # by entering a login and email address, or login to connect the 2 accounts.
  end
  

  # Called to log a user in.
  # Authenticate the user, then flush expired sessions from the sessions table
  # Update the last_seen_at and login_count attributes for the user
  def create
    user = User.find_by_login(params[:login])
    if (user && !user.enabled) 
      # user exists but is not enabled
      respond_to do |format|
        format.html {
          flash[:notice] = "User has not been approved by an Admin"
          render :action => 'new'
        }
        format.xml  {
          data = {} 
          render :xml => data.to_xml(:dasherize => false), :status => 403
        }
        format.json  {
          data = {} 
          render :json => data.to_json(:dasherize => false), :status => 403
        }
      end
    elsif (user && !user.active?)
      # user exists but is not yet activated
      respond_to do |format|
        format.html {
          flash[:notice] = "You have not activated your account yet.  Please check your email"
          render :action => 'new'
        }
        format.xml  {
          data = {} 
          render :xml => data.to_xml(:dasherize => false), :status => 403
        }
        format.json  {
          data = {} 
          render :json => data.to_json(:dasherize => false), :status => 403
        }
      end
    else
      self.current_user = User.authenticate(params[:login], params[:password])
      if logged_in?
        expire_action :controller => :home, :action => :index
        flush_expired_sessions
        login_count = self.current_user.login_count
        login_count = login_count + 1
        self.current_user.update_attribute('login_count', login_count)
        self.current_user.update_attribute('last_seen_at',Time.zone.now)
        if params[:remember_me] == "1"
          current_user.remember_me unless current_user.remember_token?
          cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
        end
        #redirect_back_or_default('/')
        #flash[:notice] = "Logged in successfully"
        respond_to do |format|
          format.html {
            redirect_back_or_default('/')
            flash[:notice] = "Logged in successfully"
          }
          format.xml  {
            render :xml => self.current_user.to_xml(:dasherize => false)
          }
          format.json  {
            render :json => self.current_user.to_json(:dasherize => false)
          }
        end           
      else
        respond_to do |format|
          format.html {
            flash[:notice] = "Incorrect username or password"
            render :action => 'new'
          }
          format.xml  {
            data = {} 
            render :xml => data.to_xml(:dasherize => false), :status => 403
          }
          format.json  {
            data = {} 
            render :json => data.to_json(:dasherize => false), :status => 403
          }
        end
      end
    end
  end


  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    #expire_action :controller => :home, :action => :index
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end
  
  
  private 
  def flush_expired_sessions
      sessions = ActiveRecord::SessionStore::Session.find(:all)
      sessions.each do |session|
        if session.updated_at < 30.minutes.ago
          session.destroy
        end
      end 
  end
  
end
