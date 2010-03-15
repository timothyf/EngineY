require 'test_helper'

class ActivityFeedHelperTest < ActionView::TestCase
  
  def test_friendship_activity
    message = activity_feed_message(activities(:friendship_act))
    assert_not_nil message
    # Don't test the date part, because that will always change
    assert message[0..134] == '<a href="http://test.host/users/1">quentin test</a> became friends with <a href="/users/8">Test8 User</a>  <span class="activity_date">'
  end
  
  
  def test_event_activity
    message = activity_feed_message(activities(:event_act))
    assert_not_nil message
    # Don't test the date part, because that will always change
    assert message[0..137] == '<a href="http://test.host/users/1">quentin test</a> added a new event - <a href="/events/1">Test Event 1</a>  <span class="activity_date">'
  end
  
  
  def test_user_activity
    message = activity_feed_message(activities(:user_act))
    assert_not_nil message
    assert message[0..88] == '<a href="http://test.host/users/1">quentin test</a> joined.  <span class="activity_date">'
  end
  
  
  def test_photo_activity
    message = activity_feed_message(activities(:photo_act))
    assert_not_nil message
    assert message.include?('<a href="/users/1">quentin test</a> uploaded a photo - <a href="/photos/1"><img alt="Test_small"')
  end
  
  
  def test_group_activity
    message = activity_feed_message(activities(:group_act))
    assert_not_nil message
    assert message[0..89] == 'A new group was created, <a href="http://test.host/groups/1">Test Group 1</a> <span class='
  end
  
  
  def test_blog_post_activity
    message = activity_feed_message(activities(:blog_post_act))
    assert_not_nil message
    assert message.include?('<a href="http://test.host/users/1">quentin test</a> posted a new blog entry, <a href="/blog_posts/1">Test Post</a>.  <span class="activity_date">')
  end
  
  
  def test_attendance_activity
    message = activity_feed_message(activities(:attendance_act))
    assert_not_nil message
    assert message.include?('<a href="http://test.host/users/1">quentin test</a> is attending the event, <a href="events/1">Test Event 1</a>.  <span class="activity_date">')
  end
  
  
  def test_membership_activity
    message = activity_feed_message(activities(:membership_act))
    assert_not_nil message
    assert message.include?('<a href="http://test.host/users/1">quentin test</a> joined the group, <a href="/groups/1">Test Group 1</a>.  <span class="activity_date">')
  end
  
  
  def test_forum_post_activity
    message = activity_feed_message(activities(:forum_post_act))
    assert_not_nil message
    assert message.include?('<a href="http://test.host/users/1">quentin test</a> posted a new message to the forum, <a href="/forum_posts/1">Topic 1 Post 1</a>.  <span class="activity_date">')
  end
  
  
  def test_job_post_activity
    message = activity_feed_message(activities(:job_post_act))
    assert_not_nil message
  end
  
  
  def test_book_review_activity
    message = activity_feed_message(activities(:book_review_act))
    assert_not_nil message
  end
  
  
  def test_status_post_activity
    message = activity_feed_message(activities(:status_post_act))
    assert_not_nil message
  end
  
  
  def test_link_activity
    message = activity_feed_message(activities(:link_act))
    assert_not_nil message
  end
  
  
  def test_project_activity
    message = activity_feed_message(activities(:project_act))
    assert_not_nil message
  end
  
  
  def test_announcement_activity
    message = activity_feed_message(activities(:announcement_act))
    assert_not_nil message
  end
  
  
  def test_classified_activity
    message = activity_feed_message(activities(:classified_act))
    assert_not_nil message
  end
  
  
end
