class CreateWallPosts < ActiveRecord::Migration
  def self.up
    create_table :wall_posts do |t|
      t.references :user
      t.references :group
      t.references :event
      t.integer :sender_id
      t.text :message
      t.timestamps
    end
  end

  def self.down
    drop_table :wall_posts
  end
end
