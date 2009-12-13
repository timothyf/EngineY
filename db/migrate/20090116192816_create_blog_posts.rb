class CreateBlogPosts < ActiveRecord::Migration
  def self.up
    create_table :blog_posts do |t|
      t.references :user
      t.string     :title
      t.text       :body
      t.integer    :parent_id
      t.boolean    :published
      t.boolean    :featured
      
      # Fields below used for external feed posts
      t.text       :summary
      t.string     :url
      t.datetime   :published_at
      t.string     :guid
      t.timestamps
    end
  end

  def self.down
    drop_table :blog_posts
  end
end
