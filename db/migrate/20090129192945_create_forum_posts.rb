class CreateForumPosts < ActiveRecord::Migration
  def self.up
    create_table :forum_posts do |t|
      t.references :user
      t.string     :title
      t.text       :body
      t.integer    :parent_id
      t.references :forum_topic
      t.boolean    :featured
      t.timestamps
    end
  end

  def self.down
    drop_table :forum_posts
  end
end
