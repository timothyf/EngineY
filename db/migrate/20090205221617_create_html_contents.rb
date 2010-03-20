class CreateHtmlContents < ActiveRecord::Migration
  def self.up
    create_table :html_contents do |t|
      t.string      :title
      t.text        :body
      t.references  :widget
      t.timestamps
      
      # Added in later modify migration
      # add_column :html_contents, :content_id, :string
      
      # Removed in later modify migration
      # remove_column :html_contents, :widget_id
      # remove_column :html_contents, :content_id
    end
  end

  def self.down
    drop_table :html_contents
  end
end
