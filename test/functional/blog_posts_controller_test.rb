require 'test_helper'

class BlogPostsControllerTest < ActionController::TestCase
  
  include AuthenticatedTestHelper
  fixtures :users
  
  
  def setup
    login_as :quentin
  end
  
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:blog_posts)
  end


  def test_should_get_new
    get :new
    assert_response :success
  end


  def test_should_create_blog_post
    assert_difference('BlogPost.count') do
      post :create, :blog_post => {:user_id=>1,
                                   :title=>'Test Post',
                                   :body=>'my test post',
                                   :published=>true,
                                   :featured=>false}
    end

    assert_redirected_to blog_post_path(assigns(:blog_post))
  end

  def test_should_show_blog_post
    get :show, :id => blog_posts(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => blog_posts(:one).id
  #  assert_response :success
  end

  def test_should_update_blog_post
    put :update, :id => blog_posts(:one).id, :blog_post => { }
    assert_redirected_to blog_post_path(assigns(:blog_post))
  end

  def test_should_destroy_blog_post
    assert_difference('BlogPost.count', -1) do
      delete :destroy, :id => blog_posts(:one).id
    end

    assert_redirected_to blog_posts_path
  end
end
