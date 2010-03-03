class CreateInvites < ActiveRecord::Migration
  def self.up
    create_table :invites do |t|
      t.references :group   # group being invited to
      t.string    :email    # recipient (invitee)
      t.references :user    # sender    (inviter)
      t.timestamps
      
      # ADDED IN A LATER MIGRATION
      # remove_column :invites, :group_id  
      # add_column :invites, :message, :text
      # add_column :invites, :invite_code, :string
      # add_column :invites, :accepted, :boolean
    end
  end

  def self.down
    drop_table :invites
  end
end
