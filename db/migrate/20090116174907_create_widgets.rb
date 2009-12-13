class CreateWidgets < ActiveRecord::Migration
  def self.up
    create_table :widgets do |t|
      t.string  :name
      t.string  :title
      t.text    :body
      t.boolean :active
      t.integer :page_order
      t.string  :path
      t.string  :index_url
      t.integer :col_num
      t.boolean :menu_item
      t.boolean :protected
      t.timestamps
    end
  end

  def self.down
    drop_table :widgets
  end
end
