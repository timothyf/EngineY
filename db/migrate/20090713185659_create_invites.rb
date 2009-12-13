class CreateInvites < ActiveRecord::Migration
  def self.up
    create_table :invites do |t|
      t.references :group   # group being invited to
      t.string    :email    # recipient (invitee)
      t.references :user    # sender    (inviter)
      t.timestamps
    end
  end

  def self.down
    drop_table :invites
  end
end
