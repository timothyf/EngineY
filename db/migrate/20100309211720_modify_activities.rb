class ModifyActivities < ActiveRecord::Migration
  def self.up
    # drop activity_types table
    change_column_default('activities', 'public', true)
  end

  def self.down
    # add activity_types table
  end
end
