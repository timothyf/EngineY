class CreateHtmlContents < ActiveRecord::Migration
  def self.up
    create_table :html_contents do |t|
      t.string      :title
      t.text        :body
      t.references  :widget
      t.timestamps
    end
  end

  def self.down
    drop_table :html_contents
  end
end
