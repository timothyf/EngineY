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

class ProfilePhoto < Photo
  
  belongs_to :user
  belongs_to :group
  belongs_to :event
  
  has_many :activities, :source=>:item, :source_type=>'Photo'
  
  has_attachment :content_type => :image, 
                 :storage => :file_system, 
                 :max_size => 50.megabyte,
                 :resize_to => '175x175',
                 :thumbnails => { :thumb => '32x32>', 
                                  :small => '48x48', 
                                  :medium => '82x82',
                                  :member => '96x96'}
                                  
                                
end
