class CreateRssFeeds < ActiveRecord::Migration
  def self.up
    create_table :rss_feeds do |t|
      t.string      :name
      t.string      :url
      t.references  :user
      t.boolean     :is_blog
      t.timestamps
    end
  end

  def self.down
    drop_table :rss_feeds
  end
end
