class CreateBugReports < ActiveRecord::Migration
  def self.up
    create_table :bug_reports do |t|
      t.string      :title
      t.string      :browser
      t.references  :user
      t.text        :description
      t.string      :module
      t.boolean     :resolved,       :default=>false
      t.text        :comment
      t.date        :resolution_date
      t.string      :priority
      t.timestamps
    end
  end

  def self.down
    drop_table :bug_reports
  end
end
