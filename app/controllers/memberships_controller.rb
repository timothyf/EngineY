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


=begin
  This class handles group memberships.
  A membership consists of a user, a group, and a role.
=end
class MembershipsController < ApplicationController
  
  # Show the members of a group
  def index
    
  end
  
  
  # Add a user to a group
  def create
    group_id = params[:group_id]
    user = User.find(params[:user_id])
    if user.is_admin
      role = Role.find_by_rolename('group_admin')
    else
      role = Role.find_by_rolename('user')
    end
    @membership = Membership.create({:group_id=>params[:group_id], 
                                     :user_id=>user.id,
                                     :role_id=>role.id})
    if @membership.save
      redirect_to group_path(group_id)
    else
      redirect_to group_path(group_id)
    end
  end
  
  
  # Changes a membership, typically used to change the role of a user, i.e.
  # to promote or demote a member from the group admin role.
  def update
    render :text=>'admin = '+params[:admin]
  end
  
  
  # Remove a user from a group
  def destroy
    
  end
  
end