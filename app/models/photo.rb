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
# Table name: photos
#
#  id           :integer(4)      not null, primary key
#  user_id      :integer(4)
#  group_id     :integer(4)
#  event_id     :integer(4)
#  title        :string(255)
#  description  :text
#  location     :string(255)
#  parent_id    :integer(4)
#  content_type :string(255)
#  filename     :string(255)
#  thumbnail    :string(255)
#  size         :integer(4)
#  width        :integer(4)
#  height       :integer(4)
#  is_profile   :boolean(1)
#  created_at   :datetime
#  updated_at   :datetime
#

class Photo < ActiveRecord::Base
  
  acts_as_commentable
  acts_as_taggable_on :tags
  
  belongs_to :user
  belongs_to :photo_album
  
  #has_many :activities, :source=>:item, :source_type=>'Photo', :dependent=>:destroy
  
  has_attachment :content_type => :image, 
                 :storage => :file_system, 
                 :max_size => 50.megabyte,
                 :resize_to => '640x640>',
                 :thumbnails => { :thumb => '32x32>', 
                                  :small => '48x48', 
                                  :medium => '82x82',
                                  :member => '96x96',
                                  :display => '175x175'}                  

  validates_as_attachment
  
  after_create :log_create_activity
  
  after_destroy :log_destroy_activity
  
  
  def self.non_profile_photos
    Photo.find(:all, :conditions => {:thumbnail => nil, :is_profile => nil})
  end
  
  
  def log_create_activity
    Photo.log_activity(self, 'create')
  end
  
  
  def log_destroy_activity
    Photo.log_activity(self, 'destroy')
  end
  
  
  def log_activity
    Photo.log_activity(self)
  end
  
  
  class << self
    def log_activity(photo, action)
      # only log non-thumbnail photos
      if (photo.thumbnail == nil && photo.is_profile != true)
        Activity.create!(:item => photo, :user => photo.user, :action => action)
      end
    end
  end
  
end
