class Location < ActiveRecord::Base
  
# == Schema Information
# Schema version: 20101212153538
#
# Table name: locations
#  name     :string(255)
#  street       :string(255)
#  city         :string(255)
#  website      :string(255)
#  phone        :string(255)
#  created_at   :datetime
#  updated_at   :datetime

  has_many :events

end
