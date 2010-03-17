require 'test_helper'


# This class provides tests for the RESTful API of the StatusPost object.
class StatusPostsTest < ActionController::IntegrationTest
  
  # GET ALL STATUS POSTS  
  # /status_posts.json
  test "get all status_posts" do
    get "/status_posts.json", :api_key=>'testapikey'
    assert_response :success
    status_posts = JSON.parse(response.body) 
    assert status_posts.size == 2
    check_status_post(status_posts[0]) 
  end
  
  
  # GET ONE STATUS POST
  # /status_posts/1.json
  test "get one status_post" do
    get "status_posts/1.json", :api_key=>'testapikey'
    assert_response :success
    status_post = JSON.parse(response.body)
    check_status_post(status_post) 
  end
  
  
  # TRY TO CREATE A STATUS POST
  # /status_posts.xml
  def test_should_not_create_status_post_via_API_XML
      get "/logout"
      post "/status_posts.xml", :status_post => {:body => 'API Status Post 1' }
      assert_response 401
  end
  

  
  # CREATE A STATUS POST
  # /status_posts.xml
  def test_should_create_status_post_via_API_XML
      get "/logout"
      post "/status_posts.xml", :api_key=>'testapikey',
                                :status_post => {:body => 'API Status Post 1' }
      assert_response :created
  end
  
  
  # CREATE A STATUS POST
  # /status_posts.json
  def test_should_create_status_post_via_API_JSON
    get "/logout"
    post "/status_posts.json", :api_key => 'testapikey',
                               :status_post => {:body => 'API Status Post 1' }
    assert_response :created
    status_post = JSON.parse(response.body)
    check_new_status_post(status_post) 
  end
  
  
  # TRY TO UPDATE A STATUS POST
  def test_should_update_status_post_via_API_XML
    get "/logout"
    put "/status_posts/1.xml", :status_post => {:body => 'API Status Post 1' }
    assert_response 401
  end
  
  
  # UPDATE A STATUS POST
  def test_should_update_status_post_via_API_XML
    get "/logout"
    put "/status_posts/1.xml", :api_key => 'testapikey',
                         :status_post => {:body => 'API Status Post 1' }
    assert_response :success
  end
  
  
  # UPDATE A STATUS POST
  def test_should_update_status_post_via_API_JSON
    get "/logout"
    put "/status_posts/1.json", :api_key => 'testapikey',
                         :status_post => {:body => 'API Status Post 1' }
    assert_response :success
  end
  
  
  private
  def check_status_post(status_post)
    assert status_post['id'] == 1, 'Incorrect id'
    assert status_post['user_id'] == 1, 'Incorrect user id'
    assert status_post['body'] == 'Status Post 1', 'Incorrect body'
  end
  
  def check_new_status_post(status_post)
    assert status_post['user_id'] == 1, 'Incorrect user id'
    assert status_post['body'] == 'API Status Post 1', 'Incorrect body'
  end

  
end