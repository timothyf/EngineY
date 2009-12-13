class CreatePhotoAlbums < ActiveRecord::Migration
  def self.up
    create_table :photo_albums do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :photo_albums
  end
end
