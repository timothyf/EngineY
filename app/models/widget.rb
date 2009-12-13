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
# Table name: widgets
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  title      :string(255)
#  body       :text
#  active     :boolean(1)
#  page_order :integer(4)
#  path       :string(255)
#  index_url  :string(255)
#  col_num    :integer(4)
#  menu_item  :boolean(1)
#  protected  :boolean(1)
#  created_at :datetime
#  updated_at :datetime
#

class Widget < ActiveRecord::Base
  
  has_one :html_content
  
  
end
