require 'test_helper'


# This class provides tests for the RESTful API of the BlogPost object.
class BlogPostsTest < ActionController::IntegrationTest
  
  # GET ALL BLOG POSTS  
  # /blog_posts.json
  test "get all blog_posts" do
    get "/blog_posts.json", :api_key=>'testapikey'
    assert_response :success
    blog_posts = JSON.parse(response.body) 
    assert blog_posts.size == 2
    check_blog_post(blog_posts[0]) 
  end
  
  
  # GET ONE BLOG POST
  # /blog_posts/1.json
  test "get one blog_post" do
    get "blog_posts/1.json", :api_key=>'testapikey'
    assert_response :success
    blog_post = JSON.parse(response.body)
    check_blog_post(blog_post) 
  end
  
  
  # TRY TO CREATE A BLOG POST
  # /blog_posts.xml
  def test_should_not_create_blog_post_via_API_XML
      get "/logout"
      post "/blog_posts.xml", :blog_post => {:title => 'API Test Post',
                                             :body => 'API Test Body',
                                             :published => true,
                                             :featured => false,
                                             :summary => 'Blog Post Summary',
                                             :url => 'http://www.apiblogpost.com',
                                             :guid => '22222' }
      assert_response 401
  end

  
  # CREATE A BLOG POST
  # /blog_posts.xml
  def test_should_create_blog_post_via_API_XML
      get "/logout"
      post "/blog_posts.xml", :api_key=>'testapikey',
                          :blog_post => {:title => 'API Test Post',
                                             :body => 'API Test Body',
                                             :published => true,
                                             :featured => false,
                                             :summary => 'Blog Post Summary',
                                             :url => 'http://www.apiblogpost.com',
                                             :guid => '22222' }
      assert_response :created
  end
  
  
  # CREATE A BLOG POST
  # /blog_posts.json
  def test_should_create_blog_post_via_API_JSON
    get "/logout"
    post "/blog_posts.json", :api_key => 'testapikey',
                         :blog_post => {:title => 'API Test Post',
                                             :body => 'API Test Body',
                                             :published => true,
                                             :featured => false,
                                             :summary => 'Blog Post Summary',
                                             :url => 'http://www.apiblogpost.com',
                                             :guid => '22222' }
    assert_response :created
    blog_post = JSON.parse(response.body)
    check_new_blog_post(blog_post) 
  end
  
  
  # TRY TO UPDATE A BLOG POST
  def test_should_update_blog_post_via_API_XML
    get "/logout"
    put "/blog_posts/1.xml", :blog_post => {:title => 'API Test Post',
                                             :body => 'API Test Body',
                                             :published => true,
                                             :featured => false,
                                             :summary => 'Blog Post Summary',
                                             :url => 'http://www.apiblogpost.com',
                                             :guid => '22222' }
    assert_response 401
  end
  
  
  # UPDATE A BLOG POST
  def test_should_update_blog_post_via_API_XML
    get "/logout"
    put "/blog_posts/1.xml", :api_key => 'testapikey',
                         :blog_post => {:title => 'API Test Post',
                                             :body => 'API Test Body',
                                             :published => true,
                                             :featured => false,
                                             :summary => 'Blog Post Summary',
                                             :url => 'http://www.apiblogpost.com',
                                             :guid => '22222' }
    assert_response :success
  end
  
  
  # UPDATE A BLOG POST
  def test_should_update_blog_post_via_API_JSON
    get "/logout"
    put "/blog_posts/1.json", :api_key => 'testapikey',
                         :blog_post => {:title => 'API Test Post',
                                             :body => 'API Test Body',
                                             :published => true,
                                             :featured => false,
                                             :summary => 'Blog Post Summary',
                                             :url => 'http://www.apiblogpost.com',
                                             :guid => '22222' }
    assert_response :success
  end
  
  
  private
  def check_blog_post(blog_post)
    assert blog_post['id'] == 1, 'Incorrect id'
    assert blog_post['user_id'] == 1, 'Incorrect user id'
    assert blog_post['title'] == 'Test Post', 'Incorrect blog_post title'
    assert blog_post['body'] == 'Test Body', 'Incorrect body'
    assert blog_post['parent_id'] == nil, 'Incorrect parent id'
    assert blog_post['published'] == true, 'Incorrect published'
    assert blog_post['featured'] == false, 'Incorrect featured' 
    assert blog_post['summary'] == 'Blog Post Summary', 'Incorrect summary' 
    assert blog_post['url'] == 'http://www.blogpost.com', 'Incorrect url' 
    assert blog_post['guid'] == '12345', 'Incorrect guid' 
  end
  
  def check_new_blog_post(blog_post)
    assert blog_post['user_id'] == 1, 'Incorrect user id'
    assert blog_post['title'] == 'API Test Post', 'Incorrect blog_post title'
    assert blog_post['body'] == 'API Test Body', 'Incorrect body'
    assert blog_post['parent_id'] == nil, 'Incorrect parent id'
    assert blog_post['published'] == true, 'Incorrect published'
    assert blog_post['featured'] == false, 'Incorrect featured' 
    assert blog_post['summary'] == 'Blog Post Summary', 'Incorrect summary' 
    assert blog_post['url'] == 'http://www.apiblogpost.com', 'Incorrect url' 
    assert blog_post['guid'] == '22222', 'Incorrect guid' 
  end
  
end