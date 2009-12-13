class CreateForumTopics < ActiveRecord::Migration
  def self.up
    create_table :forum_topics do |t|
      t.string      :title
      t.references  :user
      t.text        :description
      t.timestamps
    end
  end

  def self.down
    drop_table :forum_topics
  end
end
