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
module ViewCountable
  
  protected
  
  # Update the view_count for the item passed in
  # In addition to storing view counts in the database, a flag
  # meaning the specific item has already been viewed is stored 
  # as a cookie on the end user's machine.  This prevents a
  # single user from driving up the view count for an item.
  def update_view_count(viewed_item)     
    viewed_item_class = viewed_item.class.to_s.underscore.downcase
    items_viewed = (cookies[viewed_item_class] || '').split(',') 
    # items_viewed now contains an array of item ids that have been viewed already

    # Make sure the user has not already viewed this item
    unless items_viewed.include?(viewed_item.id.to_s)
      add_to_viewed_items_cookie(viewed_item, items_viewed)
      viewed_item.class.update_counters(viewed_item.id, {:view_count => 1}) 
    end
  end
  
  
  def add_to_viewed_items_cookie(viewed_item, items_viewed)
    items_viewed << viewed_item.id.to_s
    cookies[viewed_item] = items_viewed.join(',')
  end
  
end