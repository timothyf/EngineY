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

class BlogPost < ActiveRecord::Base
  include Streamable
  
  acts_as_commentable
  acts_as_taggable_on :tags
  
  has_and_belongs_to_many :blog_post_topics
  
  belongs_to :user 
  has_many :replies, :as => :item
  
  validates_length_of :title, :maximum=>200
  validates_length_of :body,  :maximum=>15000
  
  attr_accessor :blog_post_topic_list
  
  after_create :log_activity_if_published
  
  #after_save :update_blog_post_topics
  
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
  
  
  def update_blog_post_topics
    blog_post_topics.delete_all
    selected_blog_post_topics = blog_post_topic_list.nil? ? [] : blog_post_topic_list.keys.collect{|id| BlogPostTopic.find_by_id(id)}
    selected_blog_post_topics.each {|blog_post_topic| self.blog_post_topics << blog_post_topic}
  end
  
  
  # Returns an array of months that contain blog posts
  #   ['01/2010','12/2009', '11/2009']
  def self.months_with_posts
    posts = BlogPost.find(:all)
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
