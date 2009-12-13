class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.references :user
      t.references :photo
      t.text :description
      t.string :event_type
      t.datetime :start_time
      t.datetime :end_time
      t.string :location
      t.string :street
      t.string :city
      t.string :website
      t.string :phone
      t.string :organized_by
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
