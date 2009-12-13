class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      t.string :name
      t.string :abbreviation
      t.references :country
      t.timestamps
    end
  end

  def self.down
    drop_table :states
  end
end
