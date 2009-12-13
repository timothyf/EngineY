class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.references :user
      t.string :url
      t.string :name
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
