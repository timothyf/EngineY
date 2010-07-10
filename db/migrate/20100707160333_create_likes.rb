class CreateLikes < ActiveRecord::Migration
  def self.up
    create_table "likes", :force => true do |t|
        t.references :user,   :null => false
        t.string  :likable_type,:default => "", :null => false,   :limit => 15
        t.integer :likable_id,  :default => 0,  :null => false
        t.timestamps
    end

    add_index "likes", ["user_id"], :name => fk_likes_user
  end

  def self.down
    drop_table :likes
  end
end
