class CreateBookReviews < ActiveRecord::Migration
  def self.up
    create_table :book_reviews do |t|
      t.string      :name
      t.string      :release_date
      t.string      :publisher
      t.string      :website
      t.string      :buy_link
      t.text        :review
      t.references  :user
      t.string      :image_url
      t.boolean     :featured,  :default=>false
      t.timestamps
    end
  end

  def self.down
    drop_table :book_reviews
  end
end
