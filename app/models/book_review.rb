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

class BookReview < ActiveRecord::Base
  
  acts_as_taggable_on :tags
  
  belongs_to :user
  
  
  after_create :log_activity
  
  
  def log_activity
    Activity.create!(:item => self, :user => self.user)
  end

  
end
