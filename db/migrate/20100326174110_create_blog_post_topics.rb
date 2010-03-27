class CreateBlogPostTopics < ActiveRecord::Migration
  def self.up
    create_table :blog_post_topics do |t|
      t.references :user
      t.string     :name
      t.integer    :parent_id
      t.boolean    :default
      t.timestamps
    end
    
    create_table :blog_post_topics_blog_posts, :id => false do |t|
      t.references :blog_post
      t.references :blog_post_topic
      t.timestamps
    end
    
  end

  def self.down
    drop_table :blog_post_topics
    drop_table :blog_post_topics_blog_posts
  end
end
