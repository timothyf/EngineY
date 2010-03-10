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
# Table name: blog_posts
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  title      :string(255)
#  body       :text
#  published  :boolean(1)
#  featured   :boolean(1)
#  created_at :datetime
#  updated_at :datetime
#

class BlogPost < ActiveRecord::Base
  include Streamable
  
  acts_as_commentable
  acts_as_taggable_on :tags
  
  belongs_to :user 
  has_many :replies, :as => :item
  
  validates_length_of :title, :maximum=>200
  validates_length_of :body,  :maximum=>5000
  
  after_create :log_activity_if_published
  
  cattr_reader :per_page
  @@per_page = 6
  
  
  # Blog Posts can be in a published or draft state.  This method will move
  # a blog post into the published state.
  def publish
    if update_attribute('published', true)
      log_activity
      true
    else
      false
    end
  end

  
  # This method is used to update the database with posts from an external feed
  def self.update_from_feed(feed_url, user_id)
    posts = RssReader.all_posts(feed_url)
    add_posts(posts, user_id)
  end

  
  def short_form
    body[0..39] 
  end
  
  
  def log_activity_if_published
    if published
      log_activity
    end
  end
  
  
  private
  
  # Add blog posts that do not yet exist in the database.
  def self.add_posts(posts, user_id)
    posts.each do |post|
      unless exists? :guid => post.guid
        create!(
          :user_id      => user_id,
          :title        => post.title,
          :summary      => post.description,
          :url          => post.link,
          :published_at => post.pubDate,
          :guid         => post.guid
        )
      end
    end
  end

  
end
