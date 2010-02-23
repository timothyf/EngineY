require 'test_helper'

class InvitesControllerTest < ActionController::TestCase
  
  fixtures :users
  
  
  def setup
    login_as :quentin
  end
  
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:invites)
  end


  test "should get new" do
    get :new
    assert_response :success
  end


  test "should create invite" do
    assert_difference('Invite.count') do
      post :create, :invite => {:message => 'Invite Message',
                                :invite_code => '12345',
                                :accepted => false,
                                :email => 'user@test.com',
                                :user_id => 1}
    end
    assert_redirected_to invite_path(assigns(:invite)), 'Incorrrect redirect'
    assert_equal 'Invite was successfully created.', flash[:notice], 'Incorrect flash message'
  end
  
  
  test "should not be allowed to invite twice" do 
    post :create, :invite => {:message => 'Invite Message',
                              :invite_code => '12345',
                              :accepted => false,
                              :email => 'user@test.com',
                              :user_id => 1}
    assert_redirected_to invite_path(assigns(:invite)), 'Incorrrect redirect'
    assert_equal 'Invite was successfully created.', flash[:notice], 'Incorrect flash message'
    
    post :create, :invite => {:message => 'Invite Message',
                              :invite_code => '12345',
                              :accepted => false,
                              :email => 'user@test.com',
                              :user_id => 1}
    assert_response :success, 'Incorrect response'
    assert_not_nil assigns(:invite)
    assert_equal 'You have already invited this user.', flash[:notice], 'Incorrect flash message'
  end


  test "should show invite" do
    get :show, :id => invites(:one).id
    assert_response :success
  end


  test "should get edit" do
    get :edit, :id => invites(:one).id
    assert_response :success
  end


  test "should update invite" do
    put :update, :id => invites(:one).id, :invite => {:message => 'Invite Message',
                                :invite_code => '12345',
                                :accepted => false,
                                :email => 'test@email.com',
                                :user_id => 1}
    assert_redirected_to invite_path(assigns(:invite))
  end
  

  test "should destroy invite" do
    assert_difference('Invite.count', -1) do
      delete :destroy, :id => invites(:one).id
    end
    assert_redirected_to invites_path
  end
end
