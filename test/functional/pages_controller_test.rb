require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  
  
  def test_should_create_page
    assert_difference('Page.count') do
      post :create, :page => {:title=>'page title',
                              :permalink=>'link',
                              :name=>'page name'}
    end
    assert_redirected_to page_path(assigns(:page))
  end


  def test_should_show_page
    get :show, :title => pages(:one).title
    assert_response :success
  end


  def test_should_update_page
    put :update, :id => pages(:one).id, :page => {:title=>'page title 2',
                                                  :permalink=>'link',
                                                  :name=>'page name 2' }
    assert_redirected_to page_path(assigns(:page))
  end
  

  def test_should_destroy_page
    assert_difference('Page.count', -1) do
      delete :destroy, :id => pages(:one).id
    end
    assert_redirected_to pages_path
  end
  
  
end
