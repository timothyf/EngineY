class CreateConfigSettings < ActiveRecord::Migration
  def self.up
    create_table :config_settings do |t|
      t.string      :name
      t.string      :value
      t.timestamps
    end
  end

  def self.down
    drop_table :config_settings
  end
end
