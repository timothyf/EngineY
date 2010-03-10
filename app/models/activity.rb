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
# Table name: activities
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  public     :boolean(1)
#  item_id    :integer(4)
#  item_type  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Activity < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :item, :polymorphic => true
  has_many :feeds
  
  GLOBAL_FEED_SIZE = 10
  
  cattr_reader :per_page
  @@per_page = 15
  
  
  def self.global_feed
    find(:all, :order => 'created_at DESC', :limit => GLOBAL_FEED_SIZE)
  end
  
  
  # This method returns the activity stream as an array of text messages
  # It is currently not used.
  def self.activity_stream
    stream = []
    activities = find(:all, :order => 'created_at DESC')
    activities.each do |activity|
     # activity_msg = ActivityStreamHelper.activity_feed_message(activity)
     # stream.push activity_msg
    end
    stream
  end
  
end
