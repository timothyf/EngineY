class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.string :phone
      t.string :website
      t.boolean :active, :default => true
      t.timestamps
    end

    rename_column :events, :location, :xlocation

    add_column :events, :location_id, :int

    #Move event locations to location while trying to dedupe the location
    Event.find(:all).each do |event|
      newloc = nil
      if (! (event.xlocation.nil? || event.xlocation.empty?))
        newloc = Location.find(:first, :conditions => {
                    :name => event.xlocation,
                })
      end

      if (newloc.nil?)
        newloc = Location.new(
          :name => event.xlocation,
          :street => event.street,
          :city => event.city,
          :phone => event.phone
        )
        newloc.save
      end
      event.location = newloc
      event.save
    end

    remove_column :events, :xlocation
    remove_column :events, :street
    remove_column :events, :city
    remove_column :events, :phone

  end

  def self.down
    add_column :events, :xlocation, :string
    add_column :events, :street, :string
    add_column :events, :city, :string
    add_column :events, :phone, :string
    Event.find(:all).each do |event|
      event.xlocation = event.location.name
      event.street = event.location.street
      event.city = event.location.city
      event.phone = event.location.phone
    end
    drop_table :locations
    remove_column :events, :location_id
    rename_column :events, :xlocation, :location
  end
end
