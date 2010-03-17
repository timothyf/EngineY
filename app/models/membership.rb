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

# == Schema Information
# Schema version: 20090206190209
#
# Table name: memberships
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  group_id   :integer(4)
#  role_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Membership < ActiveRecord::Base
  
  include Streamable 
  acts_as_streamable
  
  belongs_to :user
  belongs_to :group
  belongs_to :role


  # Returns a count of the number of users that are in groups
  def self.user_count
    memberships = Membership.find(:all)
    # now make unique based on user_id
    users = memberships.map do |membership|
      membership.user_id
    end
    users.uniq.size
  end
  
end
