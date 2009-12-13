require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  
  include AuthenticatedTestHelper
  fixtures :users
  
  
  def setup
    login_as :quentin
  end
  
  
  def test_should_get_index
    get :index, :user_id => 1
    assert_response :success
    assert_not_nil assigns(:sent_messages)
    assert_not_nil assigns(:received_messages)
  end


  def test_should_get_new
    get :new
    assert_response :success
  end


  def test_should_create_message
    assert_difference('Message.count') do
      post :create, :message => {:subject => 'a message',
                                 :body => 'message body',
                                 :sender_id => 1,
                                 :recipient_id => 2,
                                 :read => false}
    end
    assert_redirected_to message_path(assigns(:message))
  end


  def test_should_show_message
    get :show, :id => messages(:one).id
    assert_response :success
  end


  def test_should_update_message
    put :update, :id => messages(:one).id, :message => { }
    assert_redirected_to message_path(assigns(:message))
  end


  def test_should_destroy_message
    assert_difference('Message.count', -1) do
      delete :destroy, :id => messages(:one).id
    end
    assert_redirected_to user_messages_url(users(:quentin))
  end
  
end
