class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.references  :user         # who performed the activity
      t.boolean     :public
      t.integer     :item_id      # which item was the activity performed on
      t.string      :item_type    # what type of item was it (photo, user, blog_post, etc)
      t.string      :action       # what action was performed on the item (create, destroy, update, etc)
      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
