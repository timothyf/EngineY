class CreateClassifieds < ActiveRecord::Migration
  def self.up
    create_table :classifieds do |t|
      t.string :title
      t.string :description
      t.references :user
      t.references :classified_category
      t.timestamps
    end
  end

  def self.down
    drop_table :classifieds
  end
end
