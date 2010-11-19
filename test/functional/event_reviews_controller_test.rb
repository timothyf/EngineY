require 'test_helper'

class EventReviewsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_reviews)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event_review" do
    assert_difference('EventReview.count') do
      post :create, :event_review => { }
    end

    assert_redirected_to event_review_path(assigns(:event_review))
  end

  test "should show event_review" do
    get :show, :id => event_reviews(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => event_reviews(:one).to_param
    assert_response :success
  end

  test "should update event_review" do
    put :update, :id => event_reviews(:one).to_param, :event_review => { }
    assert_redirected_to event_review_path(assigns(:event_review))
  end

  test "should destroy event_review" do
    assert_difference('EventReview.count', -1) do
      delete :destroy, :id => event_reviews(:one).to_param
    end

    assert_redirected_to event_reviews_path
  end
end
