class ModifyNetwork < ActiveRecord::Migration
  def self.up
    add_column :networks, :url, :string
    add_column :networks, :admin_email, :string
  end

  def self.down
    remove_column :networks, :url
    remove_column :networks, :admin_email
  end
end
