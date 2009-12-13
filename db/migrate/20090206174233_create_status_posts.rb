class CreateStatusPosts < ActiveRecord::Migration
  def self.up
    create_table :status_posts do |t|
      t.references  :user
      t.string      :body
      t.timestamps
    end
  end

  def self.down
    drop_table :status_posts
  end
end
