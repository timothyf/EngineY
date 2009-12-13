class ModifyForumPosts < ActiveRecord::Migration
  def self.up
    add_column :forum_posts, :views, :integer, :default=>0
    add_column :blog_posts, :views, :integer, :default=>0
    add_column :photos, :views, :integer, :default=>0
  end

  def self.down
    remove_column :forum_posts, :views
    remove_column :blog_posts, :views
    remove_column :photos, :views
  end
end
