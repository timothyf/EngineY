class CreateEventReviews < ActiveRecord::Migration
  def self.up
    create_table :event_reviews do |t|
      t.references  :event
      t.references  :group
      t.references  :user
      t.string      :title
      t.text        :body
      t.timestamps
    end
  end

  def self.down
    drop_table :event_reviews
  end
end
