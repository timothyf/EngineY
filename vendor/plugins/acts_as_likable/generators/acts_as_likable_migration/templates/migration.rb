class ActsAsLikableMigration < ActiveRecord::Migration
  def self.up
    create_table :likes, :force => true do |t|
      t.references :user, :null => false
      t.references :likable, :polymorphic => true, :null => false
      t.timestamps
    end

    add_index :likes, [:likable_type, :likable_id], :name => 'index_likable_type'
    add_index :likes, [:user_id], :name => 'fk_likes_user'
  end

  def self.down
    drop_table :likes
  end
end
