class CreateLayouts < ActiveRecord::Migration
  def self.up
    create_table :layouts do |t|
      t.references  :page
      t.references  :widget
      t.integer     :col_num
      t.integer     :row_num
      t.timestamps
    end
  end

  def self.down
    drop_table :layouts
  end
end
