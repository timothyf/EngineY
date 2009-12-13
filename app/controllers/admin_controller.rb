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
  
  before_filter :login_required
  
  # Display the admin home page
  def index
    
  end
  
  
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
  
end
