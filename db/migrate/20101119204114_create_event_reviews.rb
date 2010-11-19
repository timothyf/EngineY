class CreateEventReviews < ActiveRecord::Migration
  def self.up
    create_table :event_reviews do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :event_reviews
  end
end
