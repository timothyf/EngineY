class ModifyWidgetsAndLayoutsAndPages < ActiveRecord::Migration
  def self.up
    # Modify Pages
    remove_column :pages, :body
    add_column :pages, :name, :string
    
    # Modify Widgets
    remove_column :widgets, :html_content_id
    add_column :widgets, :description, :text
    add_column :widgets, :profile, :boolean

    # Modify Layouts
    add_column :widget_layouts, :html_content_id, :integer   
  end

  def self.down
    # Modify Pages
    add_column :pages, :body, :text
    remove_column :pages, :name
    
    # Modify Widgets
    add_column :widgets, :html_content_id, :integer
    remove_column :widgets, :description
    remove_column :widgets, :profile

    # Modify Layouts
    remove_column :widget_layouts, :html_content_id      
  end
end
