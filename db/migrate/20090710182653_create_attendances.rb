class CreateAttendances < ActiveRecord::Migration
  def self.up
    create_table :attendances do |t|
      t.integer     :attendee_id
      t.references  :event
      t.string      :status   # either 'yes' or 'maybe'
      t.timestamps
    end
  end

  def self.down
    drop_table :attendances
  end
end
