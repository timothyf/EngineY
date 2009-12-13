require 'test_helper'

class HtmlContentsControllerTest < ActionController::TestCase
  
  def setup
    login_as(:quentin)
  end
  
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:html_contents)
  end


  def test_should_get_new
    get :new
    assert_response :success
  end
  

  def test_should_create_html_content
    assert_difference('HtmlContent.count') do
      post :create, :html_content => { }
    end
    assert_redirected_to html_content_path(assigns(:html_content))
  end


  def test_should_get_edit
    get :edit, :id => html_contents(:one).id
    assert_response :success
  end


  def test_should_update_html_content
    put :update, :id => html_contents(:one).id, :html_content => { }
    assert_redirected_to root_path
  end


  def test_should_destroy_html_content
    assert_difference('HtmlContent.count', -1) do
      delete :destroy, :id => html_contents(:one).id
    end
    assert_redirected_to html_contents_path
  end
  
end
