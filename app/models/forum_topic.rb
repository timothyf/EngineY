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

class ForumTopic < ActiveRecord::Base
  
  has_many :forum_posts, :order=>'created_at DESC'
  
  has_many :forum_threads, :class_name => 'ForumPost', :order=>'created_at DESC', :conditions=>'parent_id is null'
  
end
