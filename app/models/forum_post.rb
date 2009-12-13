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
# Table name: forum_posts
#
#  id         :integer(4)      not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class ForumPost < ActiveRecord::Base
  include Streamable
    
  acts_as_taggable_on :tags
  
  belongs_to :user  
  belongs_to :forum_topic
  has_many :replies, :class_name => 'ForumPost', :foreign_key =>'parent_id'
  
  after_create :log_activity
  
  
  def short_form
    "Replace this text with short version of post body."
  end
  
  
end
