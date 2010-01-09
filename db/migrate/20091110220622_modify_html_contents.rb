class ModifyHtmlContents < ActiveRecord::Migration
  def self.up
    add_column :html_contents, :content_id, :string
  end

  def self.down
    remove_column :html_contents, :content_id
  end
end
