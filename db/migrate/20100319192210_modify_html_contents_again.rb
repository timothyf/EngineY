class ModifyHtmlContentsAgain < ActiveRecord::Migration
  def self.up
    remove_column :html_contents, :widget_id
    remove_column :html_contents, :content_id
  end

  def self.down
    add_column :html_contents, :content_id, :string
    add_column :html_contents, :widget_id, :integer
  end
end
