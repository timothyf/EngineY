require 'test_helper'

class LinkTest < ActiveSupport::TestCase


  def test_log_activity_after_create
    link = Link.create({
                             :user_id => 1,
                             :title => 'Ruby on Rails',
                             :url => 'www.rubyonrails.com'
                           })
    assert link, 'Failed to create link' 
    act = Activity.find_by_item_id_and_item_type(link.id, 'Link')
    assert act, 'Failed to log activity' 
    assert act.user_id == link.user_id, 'Incorrecty user id'
    assert act.public == true, 'Should be public'
    assert act.item_id == link.id, 'Incorrect item id'
    assert act.item_type == 'Link', 'Incorrect item_type'
    assert act.action == nil, 'Incorrect action' 
  end
  
  
  def test_title_validation
    assert links(:one).valid? == true, 'Expected valid link' 
    links(:one).title = nil
    assert links(:one).valid? == false, "Expected invalid link" 
    assert(links(:one).errors.invalid?(:title))
  end
  

  def test_url_validation
    assert links(:one).valid? == true, 'Expected valid link' 
    links(:one).url = nil
    assert links(:one).valid? == false, "Expected invalid link" 
    assert(links(:one).errors.invalid?(:url))
  end
  
end
