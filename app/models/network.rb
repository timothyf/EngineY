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
# Table name: networks
#
#  id           :integer(4)      not null, primary key
#  name         :string(255)
#  organization :string(255)
#  website      :string(255)
#  description  :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Network < ActiveRecord::Base
  
  validates_presence_of :name, :organization, :website, :description
  

  @@network = nil
  
  def self.network
    @@network ||= Network.find(:first)
  end
  
  
  def init_network
      # Populate Roles
      Role.destroy_all
      ['creator', 
       'administrator', 
       'group_admin',
       'user', 
       'contributor'].each {|r| Role.create(:rolename => r) }
   end
  
end
