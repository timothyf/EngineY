class CreateWidgets < ActiveRecord::Migration
  def self.up
    create_table :widgets do |t|
      t.string  :name
      t.string  :title
      t.text    :body #removed
      t.boolean :active
      t.integer :page_order #removed
      t.string  :path #removed
      t.string  :index_url #removed
      t.integer :col_num #removed
      t.boolean :menu_item #removed
      t.boolean :protected
      t.timestamps
      
      # Added in later modify migration
      # add_column :widgets, :html_content_id, :integer
    end
  end

  def self.down
    drop_table :widgets
  end
end
