require 'test_helper'

class CountryTest < ActiveSupport::TestCase

  
  def test_get_country_list
    list = Country.list
    assert list.size == 238, 'Incorrect country list length'
  end
  
  
  def test_verify_2_digit_country_codes
    list = Country.list
    list.each do |country|
      assert country[0].size == 2, 'Incorrect country code length' 
    end
  end
  
  
end
