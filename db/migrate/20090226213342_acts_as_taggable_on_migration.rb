class ActsAsTaggableOnMigration < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name
    end
    
    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :taggable_id
      t.integer :tagger_id
      t.string :tagger_type
      
      # You should make sure that the column created is
      # long enough to store the required class names.
      t.string :taggable_type
      t.string :context
      
      t.datetime :created_at
    end
    
    add_index :taggings, :tag_id
    add_index :taggings, [:taggable_id, :taggable_type, :context]
  end
  
  def self.down
    drop_table :taggings
    drop_table :tags
  end
end
