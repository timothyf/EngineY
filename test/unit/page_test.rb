require 'test_helper'

class PageTest < ActiveSupport::TestCase


  def test_to_param
    param = pages(:one).to_param
    assert param == "1-1.permalink.com"
  end
  
  
  def test_permalink_creation_on_create
    page = Page.create(
                  :title => 'Test Page',
                  :name => 'Test page'
                )
     assert page.permalink == 'test_page'
     assert page.title == 'Test Page'
     assert page.name == 'Test page'
  end
  
  
end
