class ModifySessions < ActiveRecord::Migration
  def self.up
    add_column :sessions, :user_id, :integer
    add_column :sessions, :last_url_visited, :string
  end

  def self.down
    remove_column :sessions, :user_id
    remove_column :sessions, :last_url_visited
  end
end
