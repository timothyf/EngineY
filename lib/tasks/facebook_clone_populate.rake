namespace :enginey do
  namespace :db do
    desc "Add sample data to the database"
    task :facebook_clone_populate => :environment do
      
      ##########################################################################
      # SETUP, modify this to change how you want to configure your sample data
      NETWORK_NAME = 'Facebook Clone'
      NUMBER_OF_TEST_USERS = 12
      GROUP_PHOTO_1 = File.new(RAILS_ROOT + "/public/images/rails.png")
      GROUP_PHOTO_2 = File.new(RAILS_ROOT + "/public/images/rails2.png")
      ##########################################################################
      
      # Output configuration
      puts 'Setting up sample data for your EngineY network.'
      puts 'Network Name: ' + NETWORK_NAME
      puts '# of Users: ' + NUMBER_OF_TEST_USERS.to_s
      
      # Start data creation
      puts 'Create network...'
      Network.destroy_all
      network = Network.create(:name => NETWORK_NAME,
                     :organization => 'Facebook Clone',
                     :website => 'http://www.rubymi.org',
                     :url => 'http://www.rubymi.org',
                     :admin_email => 'admin@rubymi.org',
                     :description => 'Welcome to the Facebook Clone Website.')
    
      
      puts 'Populating roles...'
      network.init_network() 
      
      
      ##########################################################################
      puts 'Creating config settings...'
      ConfigSetting.destroy_all
      Configuration.create_defaults
      

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
      
      photo = ProfilePhoto.create(:is_profile => true, 
                         :temp_path => File.new(RAILS_ROOT + "/public/images/tim.png"), 
                         :filename => 'tim.png', 
                         :content_type => 'image/png',
                         :user => user1)
      user1.profile_photo = photo
      user1.save
      user1.activate
      user1.roles << Role.find_by_rolename('creator')
      print '.'
      user = User.new :first_name=>'John',
                    :last_name=>'Smith',
                    :sex=>'M',
                    :state_id=>state_id,
                    :country_id=>1,
                    :zip=>'48134',
                    :login=>'jsmith', 
                    :email=>'john@gmail.com',
                    :city=>'Flat Rock',
                    :activated_at=>'2009-01-01',
                    :password=>'jsmith',
                    :password_confirmation=>'jsmith'
      user.save
      #user.set_temp_photo()
      #user.save
      user.activate
      user.make_group_admin(1)
      #user.roles << Role.find_by_rolename('user')
      print '.'
      user2 = User.new :first_name=>'Paul',
                    :last_name=>'Edwards',
                    :sex=>'M',
                    :state_id=>state_id,
                    :country_id=>1,
                    :zip=>'48134',
                    :login=>'pedwards', 
                    :email=>'paul@gmail.com',
                    :city=>'Flat Rock',
                    :activated_at=>'2009-01-01',
                    :password=>'pedwards',
                    :password_confirmation=>'pedwards'
      user2.save
      #user2.set_temp_photo
      #user2.save
      user2.activate
      #user2.make_group_admin(1)
      
      network.create_sample_users(NUMBER_OF_TEST_USERS)
      puts ''
      
      ##########################################################################
      puts 'Creating friendships...'
      Friendship.destroy_all
      
      # FRIENDS
      @user = User.find(1)
      @friend = User.find(2)
      Friendship.request(@user, @friend)
      
      @user = User.find(2)
      @friend = User.find(1)
      Friendship.accept(@user, @friend)
      
      @user = User.find(1)
      @friend = User.find(3)
      Friendship.request(@user, @friend)
      
      @user = User.find(3)
      @friend = User.find(1)
      Friendship.accept(@user, @friend)
      
      # REQUESTED FRIENDS
      @user = User.find(1)
      @friend = User.find(4)
      Friendship.request(@user, @friend)
      
      @user = User.find(1)
      @friend = User.find(5)
      Friendship.request(@user, @friend)
      
      # PENDING FRIENDS
      @user = User.find(6)
      @friend = User.find(1)
      Friendship.request(@user, @friend)
      
      @user = User.find(6)
      @friend = User.find(1)
      Friendship.request(@user, @friend)
      
      ##########################################################################
      puts 'Creating test groups...'
      Group.destroy_all
      group = Group.new(:name => 'Detroit Ruby User Group',
                        :description => 'The Detroit Ruby User Group.',
                        :creator_id => user1.id,
                        :featured => false)    
     photo = ProfilePhoto.create(:is_profile => true, 
                         :temp_path => GROUP_PHOTO_1, 
                         :filename => 'testgroup.png', 
                         :content_type => 'image/png',
                         :group => group)                         
     group.profile_photo = photo
     group.save
     
      group = Group.new(:name => 'Ann Arbor Ruby Brigade',
                        :description => 'The Ann Arbor Ruby User Group.',
                        :creator_id => user1.id,
                        :featured => false)    
     photo = ProfilePhoto.create(:is_profile => true, 
                         :temp_path => GROUP_PHOTO_2, 
                         :filename => 'testgroup2.png', 
                         :content_type => 'image/png',
                         :group => group)                         
     group.profile_photo = photo
     group.save
     
     puts 'Creating group memberships'
     Membership.destroy_all
     role = Role.find_by_rolename('user')
     (1..NUMBER_OF_TEST_USERS).each do |num|
       Membership.create({:group_id=>1, 
                          :user_id=>num,
                          :role_id=>role.id})
     end
     
     ##########################################################################
     puts 'Creating test Events...'
     Event.destroy_all
     event = Event.new(:name => "Detroit RUG Meeting",
                          :user_id => user1.id,
                          :description => 'DRUG Meeting for April.',
                          :event_type => 'User Group Meeting',
                          :start_time => Time.new,
                          :end_time => Time.new,
                          :location => "Compuware Building",
                          :street => 'One Campus Martius',
                          :city => 'Detroit',
                          :website => 'http://drug.rubymi.org',
                          :phone => '555-555-1212',
                          :organized_by => 'Timothy Fisher')                          
     photo = ProfilePhoto.create(:is_profile => true, 
                         :temp_path => File.new(RAILS_ROOT + "/public/images/testevent.jpg"), 
                         :filename => 'testevent.jpg', 
                         :content_type => 'image/jpg',
                         :event => event)                        
     event.profile_photo = photo
     event.save
     
     event = Event.new(:name => "AnnArbor.rb Meeting",
                          :user_id => user1.id,
                          :description => 'April Meeting for Ann Arbor Ruby Brigade.',
                          :event_type => 'User Group Meeting',
                          :start_time => Time.new,
                          :end_time => Time.new,
                          :location => "Compuware Building",
                          :street => 'One Campus Martius',
                          :city => 'Detroit',
                          :website => 'http://aa.rubymi.org',
                          :phone => '555-555-1212',
                          :organized_by => 'Timothy Fisher')                          
     photo = ProfilePhoto.create(:is_profile => true, 
                         :temp_path => File.new(RAILS_ROOT + "/public/images/testevent.jpg"), 
                         :filename => 'testevent.jpg', 
                         :content_type => 'image/jpg',
                         :event => event)                        
     event.profile_photo = photo
     event.save
     
     ##########################################################################
      puts 'Creating RSS Feed...'
      RssFeed.destroy_all
      RssFeed.create(:name => "Tim's Blog",
                     :url => 'http://feeds.feedburner.com/TimothyFishersBlog',
                     :user => user1)
                     
      ##########################################################################              
      puts 'Creating a message...'
      Message.destroy_all
      Message.create(:subject=>'Test Message',
                     :body=>'This is just a test message',
                     :sender_id=>user.id,
                     :recipient_id=>user1.id)
                    
                   
      ##########################################################################
      puts 'Creating blog posts...'
      BlogPost.destroy_all
      BlogPost.create(:user => user1,
                      :title => 'Welcome to RubyMI',
                      :body => "This site is being launched as a new community site for anyone who programs in or aspires to program in the Ruby programming language.  This site is not affiliated with a single user group, but provides a single point of contact for you to keep up with what is going on in the Ruby community throughout Michigan.  Here you will find notification of upcoming Ruby related events in Michigan and nearby, a community of like-minded Ruby enthusiasts to network with, and a place to share your knowledge with others.<br/><br/>I hope you enjoy the new RubyMI community site.<br/><br/>Sincerely,<br/>Timothy Fisher",
                      :published => true,
                      :featured => true
                      )      
      (1..NUMBER_OF_TEST_USERS).each do |number|
        BlogPost.create(:user => User.find_by_login("testuser#{number}"),
                        :title => "Post from Test User #{number}",
                        :body => "This site is being launched as a new community site for anyone who programs in or aspires to program in the Ruby programming language.  This site is not affiliated with a single user group, but provides a single point of contact for you to keep up with what is going on in the Ruby community throughout Michigan.  Here you will find notification of upcoming Ruby related events in Michigan and nearby, a community of like-minded Ruby enthusiasts to network with, and a place to share your knowledge with others.<br/><br/>I hope you enjoy the new RubyMI community site.<br/><br/>Sincerely,<br/>Timothy Fisher",
                        :published => true,
                        :featured => false
                        )  
      end
      
      ##########################################################################
      puts 'Creating Photo Albums...'
      PhotoAlbum.create(:title=>'Summer Photos',
                        :description=>'A collection of summer photos.',
                        :user=>user1)
                        
      PhotoAlbum.create(:title=>'Winter Photos',
                        :description=>'A collection of winter photos.',
                        :user=>user1)
                        
      
      ##########################################################################
      # Close File Streams
      puts 'Closing file streams...'
      GROUP_PHOTO_1.close
      GROUP_PHOTO_2.close
      
      
      ##########################################################################
      # Create HTML Contents   
      puts 'Creating managed content...'
      HtmlContent.create(:title => 'sample_content',
                         :body => 'This is an example of <b>managed content</b>.');
                         
                         
     ##########################################################################
     # Create Modules and widgets
     puts 'Creating modules and widgets...'
     mod = EyModule.create(:name => 'blog_posts')
     Widget.create(:ey_module_id => mod.id, :name => 'blog_posts_home', :description => 'Display recent blog posts', :profile => false)
     Widget.create(:ey_module_id => mod.id, :name => 'blog_posts_profile', :description => 'Display users blog posts', :profile => true)
     
     mod = EyModule.create(:name => 'members')
     Widget.create(:ey_module_id => mod.id, :name => 'members_home', :description => 'Display some members', :profile => false)
     
     mod = EyModule.create(:name => 'groups')
     Widget.create(:ey_module_id => mod.id, :name => 'groups_home', :description => 'Display some groups', :profile => false)
     Widget.create(:ey_module_id => mod.id, :name => 'groups_profile', :description => 'Display users groups', :profile => true)

     mod = EyModule.create(:name => 'events')
     Widget.create(:ey_module_id => mod.id, :name => 'events_home', :description => 'Display upcoming events', :profile => false)
     Widget.create(:ey_module_id => mod.id, :name => 'events_profile', :description => 'Display users events', :profile => true)
     
     mod = EyModule.create(:name => 'announcements')
     Widget.create(:ey_module_id => mod.id, :name => 'announcements_home', :description => 'Display recent announcements', :profile => false)
     
     mod = EyModule.create(:name => 'activity_feed')
     Widget.create(:ey_module_id => mod.id, :name => 'activity_feed_home', :description => 'Display recent activities', :profile => false)
     Widget.create(:ey_module_id => mod.id, :name => 'activity_feed_profile', :description => 'Display users activities', :profile => true)
     
     mod = EyModule.create(:name => 'links')
     Widget.create(:ey_module_id => mod.id, :name => 'links_home', :description => 'Display some links', :profile => false)
     Widget.create(:ey_module_id => mod.id, :name => 'links_profile', :description => 'Display users links', :profile => true)
     
     mod = EyModule.create(:name => 'photos')
     Widget.create(:ey_module_id => mod.id, :name => 'photos_home', :description => 'Slide show of photos', :profile => false)
     Widget.create(:ey_module_id => mod.id, :name => 'photos_profile', :description => 'Slide show of photos', :profile => true)
     
     mod = EyModule.create(:name => 'html_content')
     Widget.create(:ey_module_id => mod.id, :name => 'html_content_home', :description => 'Managed Content Widget', :profile => false)
     
     mod = EyModule.create(:name => 'status_posts')
     Widget.create(:ey_module_id => mod.id, :name => 'status_posts_profile', :description => 'Display users status posts', :profile => true)
     
     mod = EyModule.create(:name => 'about_me')
     Widget.create(:ey_module_id => mod.id, :name => 'about_me_profile', :description => 'Display users bio', :profile => true)
                         

      ##########################################################################
      # Create Pages
      puts 'Creating pages...'
      home_pg = Page.create(:name => 'home', :title => 'RubyMI Home')
      prof_pg = Page.create(:name => 'profile', :title => 'User Profile')
      
      
      ##########################################################################
      # Create Nav Items
      puts 'Creating nav items...'
      NavItem.create(:name => 'main', :title => 'Home', :url => '/', 
                     :login_required => false, :login_allowed => true, 
                     :admin_required => false, :enabled => true)
      NavItem.create(:name => 'profile', :title => 'My Page', :url => '/users', 
                     :login_required => true, :login_allowed => true, 
                     :admin_required => false, :enabled => true)
      NavItem.create(:name => 'members', :title => 'Members', :url => '/users', 
                     :login_required => false, :login_allowed => true, 
                     :admin_required => false, :enabled => true)
      NavItem.create(:name => 'blogs', :title => 'Blogs', :url => '/blog_posts',
                     :login_required => false, :login_allowed => true, 
                     :admin_required => false, :enabled => true)
      NavItem.create(:name => 'groups', :title => 'Groups', :url => '/groups',
                     :login_required => false, :login_allowed => true, 
                     :admin_required => false, :enabled => true)
      NavItem.create(:name => 'events', :title => 'Events', :url => '/events',
                     :login_required => false, :login_allowed => true, 
                     :admin_required => false, :enabled => true)
      NavItem.create(:name => 'photos', :title => 'Photos', :url => '/photo_manager',
                     :login_required => false, :login_allowed => true, 
                     :admin_required => false, :enabled => true)
      NavItem.create(:name => 'manage', :title => 'Manage', :url => '/admin',
                     :login_required => true, :login_allowed => true, 
                     :admin_required => true, :enabled => false)

      
      ##########################################################################
      # Create Layouts
      puts 'Creating layouts...'
      WidgetLayout.create(:widget_id => Widget.find_by_name("events_profile").id, :page_id => home_pg.id, :col_num => 1)
      WidgetLayout.create(:widget_id => Widget.find_by_name("photos_profile").id, :page_id => home_pg.id, :col_num => 1)
      
      WidgetLayout.create(:widget_id => Widget.find_by_name("status_posts_profile").id, :page_id => home_pg.id, :col_num => 2)
      WidgetLayout.create(:widget_id => Widget.find_by_name("activity_feed_home").id, :page_id => home_pg.id, :col_num => 2)
     

      WidgetLayout.create(:widget_id => Widget.find_by_name("groups_profile").id, :page_id => prof_pg.id, :col_num => 1)
      
      WidgetLayout.create(:widget_id => Widget.find_by_name("status_posts_profile").id, :page_id => prof_pg.id, :col_num => 2)
      WidgetLayout.create(:widget_id => Widget.find_by_name("about_me_profile").id, :page_id => prof_pg.id, :col_num => 2)
      WidgetLayout.create(:widget_id => Widget.find_by_name("activity_feed_profile").id, :page_id => prof_pg.id, :col_num => 2)

      WidgetLayout.create(:widget_id => Widget.find_by_name("events_profile").id, :page_id => prof_pg.id, :col_num => 3)
      WidgetLayout.create(:widget_id => Widget.find_by_name("links_profile").id, :page_id => prof_pg.id, :col_num => 3)
     
     
      ##########################################################################
      # Set Theme
      puts 'Setting theme...'
      Theme.create(:name=>'facebook_clone')
      
      
      puts 'Database population done!'
    end
  end
end
