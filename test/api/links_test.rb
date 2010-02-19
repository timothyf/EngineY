require 'test_helper'


# This class provides tests for the RESTful API of the Link object.
class LinksTest < ActionController::IntegrationTest
  
  # GET ALL LINKS  
  # /links.json
  test "get all links" do
    get "/links.json"
    assert_response :success
    links = JSON.parse(response.body) 
    assert links.size == 2
    check_link(links[0]) 
  end
  
  
  # GET ONE LINK
  # /links/1.json
  test "get one link" do
    get "links/1.json"
    assert_response :success
    link = JSON.parse(response.body)
    check_link(link) 
  end
  
  
  # TRY TO CREATE A LINK
  # /links.xml
  def test_should_not_create_link_via_API_XML
      get "/logout"
      post "/links.xml", :link => {:user_id => 1,
                         :title => 'API Link 1',
                         :url => 'http://www.api.com'}
      assert_response 401
  end
  

  
  # CREATE A LINK
  # /links.xml
  def test_should_create_link_via_API_XML
      get "/logout"
      post "/links.xml", :api_key=>'testapikey',
                          :link => {:user_id => 1,
                                    :title => 'API Link 1',
                                    :url => 'http://www.api.com'}
      assert_response :created
  end
  
  
  # CREATE A LINK
  # /links.json
  def test_should_create_link_via_API_JSON
    get "/logout"
    post "/links.json", :api_key => 'testapikey',
                         :link => {:user_id => 1,
                                   :title => 'API Link 1',
                                   :url => 'http://www.api.com'}
    assert_response :created
    link = JSON.parse(response.body)
    check_new_link(link) 
  end
  
  
  # TRY TO UPDATE A LINK
  def test_should_update_link_via_API_XML
    get "/logout"
    put "/links/1.xml", :link => {:user_id => 1,
                                   :title => 'API Link 1',
                                   :url => 'http://www.api.com'}
    assert_response 401
  end
  
  
  # UPDATE A LINK
  def test_should_update_link_via_API_XML
    get "/logout"
    put "/links/1.xml", :api_key => 'testapikey',
                         :link => {:user_id => 1,
                                   :title => 'API Link 1',
                                   :url => 'http://www.api.com'}
    assert_response :success
  end
  
  
  # UPDATE A LINK
  def test_should_update_link_via_API_JSON
    get "/logout"
    put "/links/1.json", :api_key => 'testapikey',
                         :link => {:user_id => 1,
                                   :title => 'API Link 1',
                                   :url => 'http://www.api.com'}
    assert_response :success
  end
  
  
  private
  def check_link(link)
    assert link['user_id'] == 1, 'Incorrect user id'
    assert link['title'] == 'Test Link 1', 'Incorrect title'
    assert link['url'] == 'http://www.myurl.com', 'Incorrect url'
  end
  
  def check_new_link(link)
    assert link['user_id'] == 1, 'Incorrect user id'
    assert link['title'] == 'API Link 1', 'Incorrect title'
    assert link['url'] == 'http://www.api.com', 'Incorrect url'
  end
  
  # 
  
end