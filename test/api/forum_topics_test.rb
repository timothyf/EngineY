require 'test_helper'


# This class provides tests for the RESTful API of the ForumTopic object.
class ForumTopicsTest < ActionController::IntegrationTest
  
  # GET ALL FORUM TOPICS  
  # /forum_topics.json
  test "get all forum topics" do
    get "/forum_topics.json", :api_key=>'testapikey'
    assert_response :success
    topics = JSON.parse(response.body) 
    assert topics.size == 3
    assert topics[0]['id']== 1, 'Incorrect topic id'
    assert topics[0]['title'] == 'Topic 1', 'Incorrect topic title'
    assert topics[0]['user_id'] == 1, 'Incorrect user id'
    assert topics[0]['description'] == 'Test Topic number 1', 'Incorrect topic description' 
  end
  
  
  # GET ONE FORUM TOPIC
  # /forum_topics/1.json
  test "get one forum topic" do
    get "/forum_topics/1.json", :api_key=>'testapikey'
    assert_response :success
    topic = JSON.parse(response.body)
    assert topic['id']== 1, 'Incorrect topic id'
    assert topic['title'] == 'Topic 1', 'Incorrect topic title'
    assert topic['user_id'] == 1, 'Incorrect user id'
    assert topic['description'] == 'Test Topic number 1', 'Incorrect topic description' 
  end
  
  
  # TRY TO CREATE A FORUM TOPIC
  # /forum_topics.xml
  def test_should_not_create_topic_via_API_XML
      get "/logout"
      post "/forum_topics.xml", :forum_topic => {:title=>'API Test Topic',
                                                 :description=>'Test topic desc',
                                                 :user_id=>1}
      # should fail because no api key is passed                                           
      assert_response 401
  end
  
  
  # CREATE A FORUM TOPIC
  # /forum_topics.xml
  def test_should_create_topic_via_API_XML
      get "/logout"
      post "/forum_topics.xml", :api_key=>'testapikey',
                                :forum_topic => {:title=>'API Test Topic',
                                                 :description=>'Test topic desc',
                                                 :user_id=>1}
      assert_response :created
  end
  
  
  # CREATE A FORUM TOPIC
  # /forum_topics.json
  def test_should_create_topic_via_API_JSON
    get "/logout"
    post "/forum_topics.json", :api_key=>'testapikey',
                               :forum_topic => {:title=>'API Test Topic',
                                                :description=>'Test topic desc',
                                                :user_id=>1}
    assert_response :created
    topic = JSON.parse(response.body)
    assert topic['title'] == 'API Test Topic', 'Incorrect topic title'
    assert topic['user_id'] == 1, 'Incorrect user id'
    assert topic['description'] == 'Test topic desc', 'Incorrect topic description' 
  end
  
  
  # TRY TO UPDATE A TOPIC
  def test_should_update_topic_via_API_XML
    get "/logout"
    put "/forum_topics/1.xml", :forum_topic => {:title=>'Updated API Test Topic',
                                                :description=>'Updated Test topic desc',
                                                :user_id=>1}
    assert_response 401
  end
  
  
  # UPDATE A TOPIC
  def test_should_update_topic_via_API_XML
    get "/logout"
    put "/forum_topics/1.xml", :api_key => 'testapikey',
                               :forum_topic => {:title=>'Updated API Test Topic',
                                                :description=>'Updated Test topic desc',
                                                :user_id=>1}
    assert_response :success
  end
  
  
  # UPDATE A TOPIC
  def test_should_update_topic_via_API_JSON
    get "/logout"
    put "/forum_topics/1.json", :api_key => 'testapikey',
                                :forum_topic => {:title=>'Updated API Test Topic',
                                                :description=>'Updated Test topic desc',
                                                :user_id=>1}
    assert_response :success
  end
  
end