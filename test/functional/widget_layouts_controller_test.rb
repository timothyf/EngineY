require 'test_helper'

class WidgetLayoutsControllerTest < ActionController::TestCase
  
  
  def test_create_widget_layout
    assert_difference('WidgetLayout.count') do
      post :create, :widget_layout => { }
    end
    assert_redirected_to widget_layout_path(assigns(:widget_layout))
  end
  

  def test_update_widget_layout
    put :update, :id => widget_layouts(:one).to_param, :widget_layout => { }
    assert_redirected_to widget_layout_path(assigns(:widget_layout))
  end


  def test_destroy_widget_layout
    assert_difference('WidgetLayout.count', -1) do
      delete :destroy, :id => widget_layouts(:one).to_param
    end
    assert_redirected_to widget_layouts_path
  end
end
