class CreateNetworks < ActiveRecord::Migration
  def self.up
    create_table :networks do |t|
      t.string :name
      t.string :organization
      t.string :website
      t.text   :description
      t.timestamps
    end
  end

  def self.down
    drop_table :networks
  end
end
