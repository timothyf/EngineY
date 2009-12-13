class ModifyInvites < ActiveRecord::Migration
  def self.up
    remove_column :invites, :group_id  
    add_column :invites, :message, :text
    add_column :invites, :invite_code, :string
    add_column :invites, :accepted, :boolean
    # already has user_id, and email
  end

  def self.down
  end
end
