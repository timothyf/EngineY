class ModifyWidgets < ActiveRecord::Migration
  def self.up
    remove_column :widgets, :body
    remove_column :widgets, :page_order
    remove_column :widgets, :path
    remove_column :widgets, :index_url
    remove_column :widgets, :col_num
    remove_column :widgets, :menu_item
    
    add_column :widgets, :html_content_id, :integer
  end

  def self.down
    add_column :widgets, :body, :text
    add_column :widgets, :page_order, :integer
    add_column :widgets, :path, :string
    add_column :widgets, :index_url, :string
    add_column :widgets, :col_num, :integer
    add_column :widgets, :menu_item, :boolean
    
    remove_column :widgets, :html_content_id
  end
end
