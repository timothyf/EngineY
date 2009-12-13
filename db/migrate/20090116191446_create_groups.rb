class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string      :name
      t.text        :description
      t.references  :photo
      t.integer     :creator_id
      t.boolean     :featured
      t.text        :announcements
      t.boolean     :private,       :default=>false
      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
