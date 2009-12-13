class CreateBlogMirrors < ActiveRecord::Migration
  def self.up
    create_table :blog_mirrors do |t|
      t.string      :url
      t.references  :user
      t.timestamps
    end
  end

  def self.down
    drop_table :blog_mirrors
  end
end
