namespace :enginey do
  namespace :db do
    desc "Add sample data to the database"
    task :personal_blog_populate => :environment do
      
      ##########################################################################
      # SETUP, modify this to change how you want to configure your sample data
      BLOG_NAME = 'PersonalBlog'
      ##########################################################################
      
      # Output configuration
      puts 'Setting up sample data for your blog.'
      puts 'Blog Name: ' + BLOG_NAME
      
      # Start data creation
      puts 'Create network...'
      Network.destroy_all
      network = Network.create(:name => BLOG_NAME,
                     :organization => 'Ruby Enthusiasts of Michigan',
                     :website => 'http://www.rubymi.org',
                     :description => 'Welcome to the Ruby Enthusiasts of Michigan website.  This site serves as a hub for all of the Ruby related activities and events that happen in and around Michigan.')
    
      
      puts 'Populating roles...'
      network.init_network() 
      
      ##########################################################################
      puts 'Creating users...'
      Activity.destroy_all
      User.destroy_all
      Photo.destroy_all
      state_id = State.find_by_name('MICHIGAN').id
      print '.'
      user1 = User.new :first_name=>'Timothy',
                    :last_name=>'Fisher',
                    :sex=>'M',
                    :state_id=>state_id,
                    :country_id=>1,
                    :zip=>'48134',
                    :login=>'admin', 
                    :email=>'timothyf@gmail.com',
                    :city=>'Flat Rock',
                    :twitter_id=>'tfisher',
                    :facebook_url=>'http://www.facebook.com/trfisher',
                    :activated_at=>'2009-01-01',
                    :password=>'admin',
                    :password_confirmation=>'admin'
      user1.save
      user1.activate
      user1.roles << Role.find_by_rolename('creator')
      
      ##########################################################################
      puts 'Creating blog post topics...'
      BlogPostTopic.destroy_all 
      BlogPostTopic.create(
                      :name => 'Technology',
                      :user_id => user1.id)
      BlogPostTopic.create(
                      :name => 'Ruby',
                      :user_id => user1.id)
      BlogPostTopic.create(
                      :name => 'Java',
                      :user_id => user1.id)
      BlogPostTopic.create(
                      :name => 'Sports',
                      :user_id => user1.id)
      
      ##########################################################################
      puts 'Creating blog posts...'
      BlogPost.destroy_all     
      (1..5).each do |number|
        BlogPost.create(:user => user1,
                        :title => "Blog Post #{number}",
                        :body => "This site is being launched as a new community site for anyone who programs in or aspires to program in the Ruby programming language.  This site is not affiliated with a single user group, but provides a single point of contact for you to keep up with what is going on in the Ruby community throughout Michigan.  Here you will find notification of upcoming Ruby related events in Michigan and nearby, a community of like-minded Ruby enthusiasts to network with, and a place to share your knowledge with others.<br/><br/>I hope you enjoy the new RubyMI community site.<br/><br/>Sincerely,<br/>Timothy Fisher",
                        :published => true,
                        :featured => false
                        )  
      end
      
      
      ##########################################################################
      puts 'Adding topics to posts...'
      post = BlogPost.find(1)
      post.blog_post_topics << BlogPostTopic.find(1)
      post.blog_post_topics << BlogPostTopic.find(3)
      post.save
      post = BlogPost.find(2)
      post.blog_post_topics << BlogPostTopic.find(2)
      post.save
      post = BlogPost.find(3)
      post.blog_post_topics << BlogPostTopic.find(3)
      post.save

      ##########################################################################
      # Create HTML Contents   
      HtmlContent.destroy_all    
      puts 'Creating managed content...'
      HtmlContent.create(:title => 'sample_content',
                         :body => 'This is an example of <b>managed content</b>.');
      
      ##########################################################################
      # Create Widgets   
      Widget.destroy_all
      puts 'Creating widgets...'
      Widget.create(:name => 'members_home', :description => 'Display some members', :profile => false)
      Widget.create(:name => 'groups_home', :description => 'Display some groups', :profile => false)
      Widget.create(:name => 'events_home', :description => 'Display upcoming events', :profile => false)
      Widget.create(:name => 'announcements_home', :description => 'Display recent announcements', :profile => false)
      Widget.create(:name => 'activity_feed_home', :description => 'Display recent activities', :profile => false)
      Widget.create(:name => 'blog_posts_home', :description => 'Display recent blog posts', :profile => false)
      Widget.create(:name => 'links_home', :description => 'Display some links', :profile => false)
      Widget.create(:name => 'projects_home', :description => 'Display some projects', :profile => false)
      Widget.create(:name => 'job_posts_home', :description => 'Display recent job posts', :profile => false)
      Widget.create(:name => 'html_content_home', :description => 'Managed Content Widget', :profile => false)

      ##########################################################################
      # Create Pages
      Page.destroy_all
      puts 'Creating pages...'
      Page.create(:title => 'home', :name => 'RubyMI Home')
      Page.create(:title => 'profile', :name => 'User Profile')
      
      ##########################################################################
      # Create Layouts
      puts 'Creating layouts...'
      WidgetLayout.destroy_all
      WidgetLayout.create(:widget_id => 1, :page_id => 1, :col_num => 1)
      WidgetLayout.create(:widget_id => 2, :page_id => 1, :col_num => 1)
      WidgetLayout.create(:widget_id => 3, :page_id => 1, :col_num => 1)
      WidgetLayout.create(:widget_id => 4, :page_id => 1, :col_num => 2)
      WidgetLayout.create(:widget_id => 5, :page_id => 1, :col_num => 2)
      WidgetLayout.create(:widget_id => 6, :page_id => 1, :col_num => 2)
      WidgetLayout.create(:widget_id => 7, :page_id => 1, :col_num => 2)
      WidgetLayout.create(:widget_id => 8, :page_id => 1, :col_num => 2)
      WidgetLayout.create(:widget_id => 9, :page_id => 1, :col_num => 3)
      WidgetLayout.create(:widget_id => 10, :page_id => 1, :col_num => 3, :html_content_id => 1)
      
      puts 'Database population done!'
    end
  end
end
