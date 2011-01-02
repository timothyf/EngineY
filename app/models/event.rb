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
# Table name: events
#
#  id           :integer(4)      not null, primary key
#  name         :string(255)
#  user_id      :integer(4)
#  photo_id     :integer(4)
#  description  :text
#  event_type   :string(255)
#  start_time   :datetime
#  end_time     :datetime
#  location     :string(255)
#  street       :string(255)
#  city         :string(255)
#  website      :string(255)
#  phone        :string(255)
#  organized_by :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Event < ActiveRecord::Base
  
  has_many :attendances, :dependent => :destroy
  has_many :attendees, :through => :attendances, :order => Event.connection.adapter_name == 'PostgreSQL' ? 'RANDOM()' : 'RAND()'
  
  has_one     :profile_photo
  belongs_to  :user  # the creator
  belongs_to  :location
  has_many    :wall_posts, :order=>'created_at DESC'
  
  validates_presence_of :start_time, :end_time, :name
  
  after_create :log_activity
  
  after_destroy :cleanup
  
  
  @@cached_events = nil
  
  def self.cached_events
    @@cached_events ||= Event.find(:all, :select=>"id, name, start_time, end_time, location", :conditions=>'start_time>now()', :order=>'start_time ASC', :limit=>6)
  end
  
  def self.reset_cache
    @@cached_events = nil
  end
  
  
  def cleanup
    Event.reset_cache
  end
  
  
  def log_activity
    Activity.create!(:item => self, :user => self.user)
    Event.reset_cache
  end
  
  
end
