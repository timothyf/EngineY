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
#
class PhotoAlbum < ActiveRecord::Base
  
  has_many :photos, :dependent => :destroy
  belongs_to :user
  
  validates_presence_of :user_id
  validates_presence_of :title  


  def owner
    self.user
  end
  
  
  def cover_photo
    if photos && photos.size>0
      photos[0]
    else
      nil
    end
  end
  
end
