# Todo: use assert_seelect? Only avail in edge?
#   http://nubyonrails.com/articles/test-your-helpers

require File.join(File.dirname(__FILE__), 'test_helper')

class String
  def nstrip
    self.gsub(/\n+/, '')
  end

  def nstrip!
    self.gsub!(/\n+/, '')
  end
end

class TwelveHourTimeTest < Test::Unit::TestCase
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::FormOptionsHelper
  include ActionView::Helpers::DateHelper

  def test_24_to_12_hour
    assert_equal(12, _12_hour(0), "12 AM")
    assert_equal(1, _12_hour(1), "1 AM")
    assert_equal(12, _12_hour(12), "12 PM")
    assert_equal(1, _12_hour(13), "1 PM")
    assert_equal(12, _12_hour(24), "12 AM")
  end

  def test_select_hour_12
    time = Time.parse '2005-07-27 15:03:34'

    options = options_for_select((1..12).to_a.map { |h| "%02d" % h }, "03")
    expected = select_tag 'date[hour]', options, :id => 'date_hour'
    actual = select_hour time, :twelve_hour => true
    assert_equal(expected.nstrip, actual.nstrip, "12 hour select")
  end

  def test_select_hour_24
    time = Time.parse '2005-07-27 15:03:34'

    options = options_for_select((0..23).to_a.map { |h| "%02d" % h }, "15")
    expected = select_tag 'date[hour]', options, :id => 'date_hour'
    expected.nstrip!

    actual = select_hour time, :twelve_hour => false 
    assert_equal(expected, actual.nstrip, "24 hour select, explicit")

    actual = select_hour time
    assert_equal(expected, actual.nstrip, "24 hour select, default")
  end
end
