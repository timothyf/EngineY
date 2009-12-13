class CreateActivityTypes < ActiveRecord::Migration
  def self.up
    create_table :activity_types do |t|
      t.string :name
      t.timestamps
    end
    
    ActivityType.create :name=>'PHOTO'
    ActivityType.create :name=>'BLOG'
    ActivityType.create :name=>'FRIEND'
  end

  def self.down
    drop_table :activity_types
  end
end
