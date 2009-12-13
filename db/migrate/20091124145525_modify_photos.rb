class ModifyPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :view_count, :integer
    add_column :photos, :photo_album_id, :integer
  end

  def self.down
    remove_column :photos, :photo_album_id
    remove_column :photos, :view_count
  end
end
