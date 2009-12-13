namespace :railsnet do
  namespace :db do
    desc "Add default values to the database"
    task :mycompany_populate => :environment do
      
      ##########################################################################
      # SETUP, modify this to change how you want to configure your sample data
      NETWORK_NAME = 'MyCompany'
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
      Network.create(:name => NETWORK_NAME,
                     :organization => 'ACME Corporation',
                     :website => 'http://www.mycompany.com',
                     :description => "MyCompany is the new employee portal for the ACME corporation.  You'll find tools for sharing knowledge, finding experts, and collaborating across the company here.")
    
      puts 'Populating roles...'
      Role.destroy_all
      ['creator', 
       'administrator', 
       'group_admin',
       'user', 
       'contributor'].each {|r| Role.create(:rolename => r) }

      puts 'Populating countries...'
      Country.destroy_all
      Country.list.each {|c| Country.create(:abbreviation => c[0], :name => c[1]) }

      puts 'Populating states...'
      State.init_states
      State.destroy_all
      State.list.each {|s| State.create(:name => s[0], :abbreviation => s[1], :country_id => s[2]) }   
      
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
                    :email=>'admin@email.com',
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
                    :email=>'jsmith@email.com',
                    :city=>'Flat Rock',
                    :activated_at=>'2009-01-01',
                    :password=>'jsmith',
                    :password_confirmation=>'jsmith'
      user.save
      user.set_temp_photo()
      user.save
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
                    :email=>'pedwards@email.com',
                    :city=>'Flat Rock',
                    :activated_at=>'2009-01-01',
                    :password=>'pedwards',
                    :password_confirmation=>'pedwards'
      user2.save
      user2.set_temp_photo
      user2.save
      user2.activate
      #user2.make_group_admin(1)
      
      (1..NUMBER_OF_TEST_USERS).each do |number|
        print '.'
        user3 = User.new :first_name=>"Test#{number}",
                      :last_name=>"User#{number}",
                      :sex=>'M',
                      :state_id=>state_id,
                      :country_id=>1,
                      :zip=>'48134',
                      :login=>"testuser#{number}", 
                      :email=>"testuser#{number}@email.com",
                      :city=>'Flat Rock',
                      :activated_at=>'2009-01-01',
                      :password=>'testuser',
                      :password_confirmation=>'testuser'
        user3.save
        user3.set_temp_photo
        user3.save
        user3.activate
      end
      puts ''
      
      ##########################################################################      
      puts 'Creating test groups...'
      Group.destroy_all
      group = Group.new(:name => 'Software Development',
                        :description => 'A group for software developers.',
                        :creator_id => user1.id,
                        :featured => false)    
     photo = ProfilePhoto.create(:is_profile => true, 
                         :temp_path => GROUP_PHOTO_1, 
                         :filename => 'testgroup.png', 
                         :content_type => 'image/png',
                         :group => group)                         
     group.profile_photo = photo
     group.save
     
      group = Group.new(:name => 'Project Management',
                        :description => 'A group for project managers.',
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
      puts 'Creating Forum Topics...'
      ForumTopic.destroy_all
      ForumTopic.create(:title => 'Ruby',
                        :description => 'Discussion about the Ruby language',
                        :user_id => user1.id)
      ForumTopic.create(:title => 'Rails',
                        :description => 'Discussion about the Ruby on Rails framework',
                        :user_id => user1.id)
      ForumTopic.create(:title => 'Non-Rails Frameworks',
                        :description => 'Discussion about other Ruby frameworks',
                        :user_id => user1.id)
      ForumTopic.create(:title => 'Site Suggestions',
                        :description => 'Have an idea for the RubyMI site?  Contribute ideas and suggestions here.',
                        :user_id => user1.id)
      ForumTopic.create(:title => 'Water Cooler',
                        :description => 'This topic if a free-for-all.  Respect others and share what you wish here.',
                        :user_id => user1.id)
                    
      ##########################################################################    
      puts 'Creating Forum Posts...'
      ForumPost.destroy_all
      ForumPost.create(:user => user1,
                       :title => 'What are company holidays?',
                       :body => 'I have a simple question about Ruby.  What type of language is Ruby???',
                       :parent_id => nil,
                       :forum_topic => ForumTopic.find_by_title('Ruby'),
                       :featured => false)
      ForumPost.create(:user => user2,
                       :title => 'RE: What are company holidays?',
                       :body => 'Ruby is a dynamically types, scripted programming language.',
                       :parent_id => ForumPost.find(:first).id,
                       :forum_topic => ForumTopic.find_by_title('Ruby'),
                       :featured => false)
      ForumPost.create(:user => user1,
                       :title => 'Anyone know Ruby???',
                       :body => 'I have a simple question about Rails.  What type of framework is Rails??',
                       :parent_id => nil,
                       :forum_topic => ForumTopic.find_by_title('Rails'),
                       :featured => false)
      ForumPost.create(:user => user2,
                       :title => 'RE: Anyone know Ruby???',
                       :body => 'Rails is an MVC web application framework.',
                       :parent_id => ForumPost.find_by_title('Anyone know Ruby???').id,
                       :forum_topic => ForumTopic.find_by_title('Rails'),
                       :featured => false)                
      
      puts 'Creating blog posts...'
      BlogPost.destroy_all
      BlogPost.create(:user => user1,
                      :title => 'Welcome to MyCompany',
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

            puts 'Database population done!'
          end
        end
      end

