class ModifyPhotoAlbums < ActiveRecord::Migration
  def self.up
    add_column :photo_albums, :view_count, :integer
    add_column :photo_albums, :title, :string
    add_column :photo_albums, :description, :text
    add_column :photo_albums, :user_id, :integer
  end

  def self.down
    remove_column :photo_albums, :view_count
    remove_column :photo_albums, :title
    remove_column :photo_albums, :description
    remove_column :photo_albums, :user_id
  end
end
