class CreateEyModules < ActiveRecord::Migration
  def self.up
    create_table :ey_modules do |t|
      t.string :name
      t.timestamps
    end
    add_column :widgets, :ey_module_id, :integer
  end

  def self.down
    drop_table :ey_modules
  end
end
