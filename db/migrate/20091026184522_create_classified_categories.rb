class CreateClassifiedCategories < ActiveRecord::Migration
  def self.up
    create_table :classified_categories do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :classified_categories
  end
end
