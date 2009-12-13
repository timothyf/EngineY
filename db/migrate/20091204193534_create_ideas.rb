class CreateIdeas < ActiveRecord::Migration
  def self.up
    create_table :ideas do |t|
      t.string  :title
      t.text    :description
      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :ideas
  end
end
