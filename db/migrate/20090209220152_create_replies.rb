class CreateReplies < ActiveRecord::Migration
  def self.up
    create_table :replies do |t|
      t.text        :body
      t.references  :user
      t.integer     :item_id    # parent item id
      t.string      :item_type
      t.timestamps
    end
  end

  def self.down
    drop_table :replies
  end
end
