require 'test_helper'

class BookReviewsControllerTest < ActionController::TestCase
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:book_reviews)
  end


  def test_should_get_new
    login_as(:quentin)
    get :new
    assert_response :success
  end
  

  def test_should_create_book_review
    login_as(:quentin)
    assert_difference('BookReview.count') do
      post :create, :book_review => {:name=>'Test Review',
                                     :publisher=>'Marvel',
                                     :website=>'website.com',
                                     :user_id=>1,
                                     :featured=>false}
    end
    assert_redirected_to book_review_path(assigns(:book_review))
  end
  

  def test_should_show_book_review
    get :show, :id => book_reviews(:one).id
    assert_response :success
  end
  

  def test_should_get_edit
    login_as(:quentin)
    get :edit, :id => book_reviews(:one).id
    assert_response :success
  end
  

  def test_should_update_book_review
    login_as(:quentin)
    put :update, :id => book_reviews(:one).id, :book_review => { }
    assert_redirected_to book_review_path(assigns(:book_review))
  end


  def test_should_destroy_book_review
    login_as(:quentin)
    assert_difference('BookReview.count', -1) do
      delete :destroy, :id => book_reviews(:one).id
    end
    assert_redirected_to book_reviews_path
  end
  
end
