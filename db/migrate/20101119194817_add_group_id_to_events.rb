class AddGroupIdToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :group_id, :integer
  end

  def self.down
    remove_column :events, :group_id
  end
end
