require 'test_helper'


# This class provides tests for the RESTful API of the ForumPost object.
class ForumPostsTest < ActionController::IntegrationTest
  
  
  # GET ALL FORUM POSTS  
  # /forum_posts.json
  test "get all forum posts" do
    get "/forum_posts.json?api_key=testapikey"
    assert_response :success, 'Incorrect response type'
    posts = JSON.parse(response.body) 
    assert posts.size == 15, 'Incorrect number of posts' 
    assert posts[0]['id']== 1, 'Incorrect post id'
    assert posts[0]['user_id']== 1, 'Incorrect user id'
    assert posts[0]['title'] == 'Topic 1 Post 1', 'Incorrect post title'
    assert posts[0]['body'] == 'Topic 1 Post 1 Body', 'Incorrect post body'
    assert posts[0]['forum_topic_id'] == 1, 'Incorrect topic id' 
    assert posts[0]['featured'] == false, 'Incorrect featured'
  end
  
  
  # GET ALL FORUM POSTS FOR A TOPIC 
  # /forum_posts.json&api_key=testapikey&forum_topic_id=1
  test "get all forum posts for a topic" do
    get "/forum_posts.json?api_key=testapikey&forum_topic_id=1"
    assert_response :success, 'Incorrect response type'
    posts = JSON.parse(response.body) 
    assert posts.size == 5, 'Incorrect number of posts' 
    assert posts[0]['id']== 1, 'Incorrect post id'
    assert posts[0]['user_id']== 1, 'Incorrect user id'
    assert posts[0]['title'] == 'Topic 1 Post 1', 'Incorrect post title'
    assert posts[0]['body'] == 'Topic 1 Post 1 Body', 'Incorrect post body'
    assert posts[0]['forum_topic_id'] == 1, 'Incorrect topic id' 
    assert posts[0]['featured'] == false, 'Incorrect featured'
  end
  
  
  # GET ALL FORUM POSTS FOR A USER
  # /forum_posts.json&api_key=testapikey&user_id=1
  test "get all forum posts for a user" do
    get "/forum_posts.json?api_key=testapikey&user_id=1"
    assert_response :success, 'Incorrect response type'
    posts = JSON.parse(response.body) 
    assert posts.size == 10, 'Incorrect number of posts' 
    assert posts[0]['id']== 1, 'Incorrect post id'
    assert posts[0]['user_id']== 1, 'Incorrect user id'
    assert posts[0]['title'] == 'Topic 1 Post 1', 'Incorrect post title'
    assert posts[0]['body'] == 'Topic 1 Post 1 Body', 'Incorrect post body'
    assert posts[0]['forum_topic_id'] == 1, 'Incorrect topic id' 
    assert posts[0]['featured'] == false, 'Incorrect featured'
  end
  
  
  # GET ONE FORUM POST
  # /forum_posts/1.json
  test "get one forum post" do
    get "/forum_posts/1.json?api_key=testapikey"
    assert_response :success, 'Incorrect response type'
    post = JSON.parse(response.body) 
    assert post['id']== 1, 'Incorrect post id'
    assert post['user_id']== 1, 'Incorrect user id'
    assert post['title'] == 'Topic 1 Post 1', 'Incorrect post title'
    assert post['body'] == 'Topic 1 Post 1 Body', 'Incorrect post body'
    assert post['forum_topic_id'] == 1, 'Incorrect topic id' 
    assert post['featured'] == false, 'Incorrect featured'
  end
  
  
  # CREATE A FORUM POST
  # /forum_posts.xml
  def test_should_create_post_via_API_XML
      get "/logout"
      post "/forum_posts.xml", :api_key=>'testapikey',
                                :forum_post => {:title=>'API Test Post',
                                                 :body=>'Test Post desc',
                                                 :user_id=>1}
      assert_response :created
  end
  
  
  # CREATE A FORUM POST
  # /forum_posts.json
  def test_should_create_post_via_API_JSON
    get "/logout"
    post "/forum_posts.json", :api_key=>'testapikey',
                               :forum_post => {:title=>'API Test Post',
                                                :body=>'Test Post desc',
                                                :user_id=>1}
    assert_response :created
    topic = JSON.parse(response.body)
    assert topic['title'] == 'API Test Post', 'Incorrect topic title'
    assert topic['user_id'] == 1, 'Incorrect user id'
    assert topic['body'] == 'Test Post desc', 'Incorrect topic description' 
  end
  
end