class CreateNavItems < ActiveRecord::Migration
  def self.up
    create_table :nav_items do |t|
      t.string      :name
      t.string      :title
      t.string      :url
      t.boolean     :login_required
      t.boolean     :login_allowed
      t.boolean     :admin_required
      t.boolean     :enabled
      t.timestamps
    end
  end

  def self.down
    drop_table :nav_items
  end
end
