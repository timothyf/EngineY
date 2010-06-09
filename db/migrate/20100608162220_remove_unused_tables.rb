class RemoveUnusedTables < ActiveRecord::Migration
  def self.up
    drop_table :content_pages
    drop_table :layouts
  end

  def self.down
  end
end
