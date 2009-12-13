require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  
  fixtures :users
  
  
  def setup
    login_as :quentin
  end
  
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end


  def test_should_get_new
    get :new
    assert_response :success
  end


  def test_should_create_event
    assert_difference('Event.count') do
      post :create, :event => {:name=>'Test Event',
                               :user_id=>1,
                               :description=>'Event Desc',
                               :event_type=>'party',
                               :location=>'Compuware HQ',
                               :street=>'Fort',
                               :city=>'Detroit',
                               :website=>'website.com',
                               :phone=>'555-1212',
                               :organized_by=>'test dude',
                               :start_time=>Time.now,
                               :end_time=>Time.now }
    end

    assert_redirected_to event_path(assigns(:event))
  end


  def test_should_show_event
    get :show, :id => events(:one).id
    assert_response :success
  end


  def test_should_get_edit
    get :edit, :id => events(:one).id
    assert_response :success
  end


  def test_should_update_event
    put :update, :id => events(:one).id, :event => {:name=>'Test Event',
                                                   :user_id=>1,
                                                   :description=>'Event Desc',
                                                   :event_type=>'party',
                                                   :location=>'Compuware HQ',
                                                   :street=>'Fort',
                                                   :city=>'Detroit',
                                                   :website=>'website.com',
                                                   :phone=>'555-1212',
                                                   :organized_by=>'test dude',
                                                   :start_time=>Time.now,
                                                   :end_time=>Time.now}
    assert_redirected_to event_path(assigns(:event))
  end


  def test_should_destroy_event
    assert_difference('Event.count', -1) do
      delete :destroy, :id => events(:one).id
    end
    assert_redirected_to events_path
  end
  
end
