require 'test_helper'

class ActivityTest < ActiveSupport::TestCase

  def test_global_feed
    result = Activity.global_feed
    assert result
  end
  
end
