class BlogPostTopic < ActiveRecord::Base
  
  belongs_to :user
  has_and_belongs_to_many :blog_posts
  
end
