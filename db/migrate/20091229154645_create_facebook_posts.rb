class CreateFacebookPosts < ActiveRecord::Migration
  def self.up
    create_table :facebook_posts do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :facebook_posts
  end
end
