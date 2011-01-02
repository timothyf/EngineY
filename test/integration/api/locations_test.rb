require 'test_helper'
require 'json'


# This class provides tests for the RESTful API of the Locat object.
class LocationsTest < ActionController::IntegrationTest

  # GET ALL LOCATIONS
  # /locations.json
  test "get all locations" do
    get "/locations.json", :api_key=>'testapikey'
    assert_response :success
    locations = JSON.parse(response.body)
    assert_equal 2, locations.size
    check_location(locations[1])
  end

  def check_location(loc)
    assert_equal "Name", loc['name']
    assert_equal "1 Main", loc['street']
    assert_equal "Detroit", loc['city']
    assert_equal "Michigan", loc['state']
    assert_equal "USA", loc['country']
    assert_equal "3033333333", loc['phone']
  end

end

