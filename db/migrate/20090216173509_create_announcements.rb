class CreateAnnouncements < ActiveRecord::Migration
  def self.up
    create_table :announcements do |t|
      t.string      :title
      t.text        :body
      t.references  :user
      t.references  :group
      t.timestamps
    end
  end

  def self.down
    drop_table :announcements
  end
end
