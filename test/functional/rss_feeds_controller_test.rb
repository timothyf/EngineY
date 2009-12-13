require 'test_helper'

class RssFeedsControllerTest < ActionController::TestCase
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:rss_feeds)
  end


  def test_should_get_new
    get :new
    assert_response :success
  end


  def test_should_create_rss_feed
    assert_difference('RssFeed.count') do
      post :create, :rss_feed => { }
    end
    assert_redirected_to rss_feed_path(assigns(:rss_feed))
  end


  def test_should_get_edit
    get :edit, :id => rss_feeds(:one).id
    assert_response :success
  end
  

  def test_should_update_rss_feed
    put :update, :id => rss_feeds(:one).id, :rss_feed => { }
    assert_redirected_to rss_feed_path(assigns(:rss_feed))
  end


  def test_should_destroy_rss_feed
    assert_difference('RssFeed.count', -1) do
      delete :destroy, :id => rss_feeds(:one).id
    end
    assert_redirected_to rss_feeds_path
  end
  
end
