class AddEmailOptInToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :receive_emails, :boolean, :default => true
  end

  def self.down
    remove_column :users, :receive_emails
  end
end
