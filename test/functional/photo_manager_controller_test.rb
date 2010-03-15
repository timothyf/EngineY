require 'test_helper'

class PhotoManagerControllerTest < ActionController::TestCase


  def test_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:albums)
    assert_not_nil assigns(:photos_outside_album)
    assert assigns(:albums).size == 2
    assert assigns(:photos_outside_album).size == 1
    assert assigns(:albums)[0].id == 2
    assert assigns(:albums)[1].id == 1
    assert assigns(:photos_outside_album)[0].id = 2
  end
  
  
end
