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
# Table name: roles
#
#  id         :integer(4)      not null, primary key
#  rolename   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Role < ActiveRecord::Base
  
  has_many :permissions, :dependent => :destroy
  has_many :users, :through => :permissions 
  has_many :memberships
  
  
  @@creator = nil
  
  def self.creator
    @@creator ||= Role.find_by_rolename('creator')
  end
  
  def self.admin
    @@admin ||= Role.find_by_rolename('administrator')
  end
  
  
end
