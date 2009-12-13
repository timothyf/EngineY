#   Copyright 2009 Timothy Fisher
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

# == Schema Information
# Schema version: 20090206190209
#
# Table name: states
#
#  id           :integer(4)      not null, primary key
#  name         :string(255)
#  abbreviation :string(255)
#  country_id   :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#

class State < ActiveRecord::Base
  
  has_many :users
  belongs_to :country
  
  
  def self.list
    @@state_list
  end
  
  # Assumes that countries are setup first!!!!
  def self.init_states
    us_id = Country.find_by_abbreviation('US').id
    
    @@state_list =       [
          ['ALASKA', 'AK', us_id],
          ['ALABAMA', 'AL', us_id],
          ['ARKANSAS', 'AR', us_id],
          ['AMERICAN SAMOA', 'AS', us_id],
          ['ARIZONA', 'AZ', us_id],
          ['CALIFORNIA', 'CA', us_id],
          ['COLORADO', 'CO', us_id],
          ['CONNECTICUT', 'CT', us_id],
          ['DISTRICT OF COLUMBIA', 'DC', us_id],
          ['WASHINGTON, DC', 'DC', us_id],
          ['DELAWARE', 'DE', us_id],
          ['FLORIDA', 'FL', us_id],
          ['FEDERATED STATES OF MICRONESIA', 'FM', us_id],
          ['GEORGIA', 'GA', us_id],
          ['GUAM', 'GU', us_id],
          ['HAWAII', 'HI', us_id],
          ['IOWA', 'IA', us_id],
          ['IDAHO', 'ID', us_id],
          ['ILLINOIS', 'IL', us_id],
          ['INDIANA', 'IN', us_id],
          ['KANSAS', 'KS', us_id],
          ['KENTUCKY', 'KY', us_id],
          ['LOUISIANA', 'LA', us_id],
          ['MASSACHUSETTS', 'MA', us_id],
          ['MARYLAND', 'MD', us_id],
          ['MAINE', 'ME', us_id],
          ['MARSHALL ISLANDS', 'MH', us_id],
          ['MICHIGAN', 'MI', us_id],
          ['MINNESOTA', 'MN', us_id],
          ['MISSOURI', 'MO', us_id],
          ['NORTHERN MARIANA ISLANDS', 'MP', us_id],
          ['MISSISSIPPI', 'MS', us_id],
          ['MONTANA', 'MT', us_id],
          ['NORTH CAROLINA', 'NC', us_id],
          ['NORTH DAKOTA', 'ND', us_id],
          ['NEBRASKA', 'NE', us_id],
          ['NEW HAMPSHIRE', 'NH', us_id],
          ['NEW JERSEY', 'NJ', us_id],
          ['NEW MEXICO', 'NM', us_id],
          ['NEVADA', 'NV', us_id],
          ['NEW YORK', 'NY', us_id],
          ['OHIO', 'OH', us_id],
          ['OKLAHOMA', 'OK', us_id],
          ['OREGON', 'OR', us_id],
          ['PENNSYLVANIA', 'PA', us_id],
          ['PUERTO RICO', 'PR', us_id],
          ['PALAU', 'PW', us_id],
          ['RHODE ISLAND', 'RI', us_id],
          ['SOUTH CAROLINA', 'SC', us_id],
          ['SOUTH DAKOTA', 'SD', us_id],
          ['TENNESSEE', 'TN', us_id],
          ['TEXAS', 'TX', us_id],
          ['UTAH', 'UT', us_id],
          ['VIRGINIA', 'VA', us_id],
          ['VIRGIN ISLANDS', 'VI', us_id],
          ['VERMONT', 'VT', us_id],
          ['WASHINGTON', 'WA', us_id],
          ['WISCONSIN', 'WI', us_id],
          ['WEST VIRGINIA', 'WV', us_id],
          ['WYOMING', 'WY', us_id]
        ]
  end
  
end
