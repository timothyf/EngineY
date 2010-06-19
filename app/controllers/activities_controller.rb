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

class ActivitiesController < ApplicationController
  
  def index
    if params[:user_id]
      # show activities for the specified user
      @user = User.find(params[:user_id])
      @activities = @user.activities.paginate(:all, :page => params[:page], :order => 'created_at DESC')
      @activities_count = @user.activities.length      
    else
      # show all activities
      @activities = Activity.paginate(:all, :page => params[:page], :order => 'created_at DESC') 
      @activities_count = Activity.count
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @activities }
      format.rss { render :layout => false }
      format.json { render :json => @activities }
    end
  end
  
  
  # Show a single activity
  def show
    @activity = Activity.find(params[:id])
  end
  
end
