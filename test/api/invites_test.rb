require 'test_helper'


# This class provides tests for the RESTful API of the Invite object.
class InvitesTest < ActionController::IntegrationTest
  
  # GET ALL INVITES  
  # /invites.json
  test "get all invites" do
    get "/invites.json"
    assert_response :success
    invites = JSON.parse(response.body) 
    assert invites.size == 2
    check_invite(invites[0]) 
  end
  
  
  # GET ONE INVITE
  # /invites/1.json
  test "get one invite" do
    get "invites/1.json"
    assert_response :success
    invite = JSON.parse(response.body)
    check_invite(invite) 
  end
  
  
  # TRY TO CREATE A INVITE
  # /invites.xml
  def test_should_not_create_invite_via_API_XML
      get "/logout"
      post "/invites.xml", :invite => {:message => 'API Invite 1',
                                       :accepted => false,
                                       :email => 'test@email.com',
                                       :user_id => 1 }
      assert_response 401
  end

  
  # CREATE A INVITE
  # /invites.xml
  def test_should_create_invite_via_API_XML
      get "/logout"
      post "/invites.xml", :api_key=>'testapikey',
                          :invite => {:message => 'API Invite 1',
                                       :accepted => false,
                                       :email => 'test@email.com',
                                       :user_id => 1 }
      assert_response :created
  end
  
  
  # CREATE A INVITE
  # /invites.json
  def test_should_create_invite_via_API_JSON
    get "/logout"
    post "/invites.json", :api_key => 'testapikey',
                         :invite => {:message => 'API Invite 1',
                                       :accepted => false,
                                       :email => 'test@email.com',
                                       :user_id => 1 }
    assert_response :created
    invite = JSON.parse(response.body)
    check_new_invite(invite) 
  end
  
  
  # TRY TO UPDATE A INVITE
  def test_should_update_invite_via_API_XML
    get "/logout"
    put "/invites/1.xml", :invite => {:message => 'API Invite 1',
                                       :accepted => false,
                                       :email => 'test@email.com',
                                       :user_id => 1 }
    assert_response 401
  end
  
  
  # UPDATE A INVITE
  def test_should_update_invite_via_API_XML
    get "/logout"
    put "/invites/1.xml", :api_key => 'testapikey',
                         :invite => {:message => 'API Invite 1',
                                       :accepted => false,
                                       :email => 'test@email.com',
                                       :user_id => 1 }
    assert_response :success
  end
  
  
  # UPDATE A INVITE
  def test_should_update_invite_via_API_JSON
    get "/logout"
    put "/invites/1.json", :api_key => 'testapikey',
                         :invite => {:message => 'API Invite 1',
                                       :accepted => false,
                                       :email => 'test@email.com',
                                       :user_id => 1 }
    assert_response :success
  end
  
  
  private
  def check_invite(invite)
    assert invite['message'] == 'Invite 1', 'Incorrect message'
    assert invite['invite_code'] == 'invite_code1', 'Incorrect invite code'
    assert invite['accepted'] == false, 'Incorrect accepted'
    assert invite['email'] == 'test@email.com', 'Incorrect email'
    assert invite['user_id'] == 1, 'Incorrect user id'
  end
  
  def check_new_invite(invite)
    assert invite['message'] == 'API Invite 1', 'Incorrect message'
    assert invite['accepted'] == false, 'Incorrect accepted'
    assert invite['email'] == 'test@email.com', 'Incorrect email'
    assert invite['user_id'] == 1, 'Incorrect user id'
  end

  
end