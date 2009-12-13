class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.references :user
      t.references :group
      t.references :event
      t.string :title
      t.text :description
      t.string :location
      t.integer :parent_id
      t.string :content_type
      t.string :filename   
      t.string :thumbnail
      t.integer :size
      t.integer :width
      t.integer :height
      t.boolean :is_profile
      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
