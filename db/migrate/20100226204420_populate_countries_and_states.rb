class PopulateCountriesAndStates < ActiveRecord::Migration
  def self.up
    # Only create states and countries if the user has not already done this
    if !Country.find(:first)
      Country.list.each {|c| Country.create(:abbreviation => c[0], :name => c[1]) }
    end
    if !State.find(:first) 
      State.init_states
      State.list.each {|s| State.create(:name => s[0], :abbreviation => s[1], :country_id => s[2]) }  
    end
  end

  def self.down
    Country.destroy_all
    State.destroy_all
  end
end
