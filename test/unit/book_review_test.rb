require 'test_helper'

class BookReviewTest < ActiveSupport::TestCase


  def test_log_activity_after_create
    review = BookReview.create({:name => 'Test Book Review',
                                :release_date => Time.now,
                                :publisher => "O'Reilly",
                                :website => 'www.coolbook.com',
                                :buy_link => 'www.coolbook.com/buy',
                                :review => 'I thought this was a great and cool book.',
                                :user_id => '1',
                                :image_url => 'www.coolbook.com/image.jpg',
                                :featured => false })
    assert review, 'Failed to create book review' 
    act = Activity.find_by_item_id_and_item_type(review.id, 'BookReview')
    assert act, 'Failed to log activity' 
    assert act.user_id == review.user_id, 'Incorrecty user id'
    assert act.public == true, 'Should be public'
    assert act.item_id == review.id, 'Incorrect item id'
    assert act.item_type == 'BookReview', 'Incorrect item_type'
    assert act.action == nil, 'Incorrect action' 
  end
  
  
end

