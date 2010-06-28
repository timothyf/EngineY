namespace :railsnet do
  namespace :db do
    desc "Add sample data to the database"
    task :engineycom_populate => :environment do
      
      ##########################################################################
      # SETUP, modify this to change how you want to configure your sample data
      NETWORK_NAME = 'EngineY'
      ##########################################################################
      
      # Output configuration
      puts 'Setting up sample data for your EngineY network.'
      puts 'Network Name: ' + NETWORK_NAME
      
      # Start data creation
      puts 'Create network...'
      Network.destroy_all
      network = Network.create(:name => NETWORK_NAME,
                     :organization => 'EngineY',
                     :website => 'http://www.enginey.com',
                     :url => 'http://www.enginey.com',
                     :admin_email => 'admin@rubymi.org',
                     :description => 'The homepage for the EngineY framework.')
    
      
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
      user1.activate
      user1.roles << Role.find_by_rolename('creator')

      
      ##########################################################################
      # Create HTML Contents   
      puts 'Creating managed content...'
      HtmlContent.create(:title => 'enginey_about',
                         :body => 
"<div id='about' class='section cssbox'><div class='cssbox_head'> 
<h4>&nbsp;</h4> 
</div> 
<div class='about_content cssbox_body'> 
EngineY is an easy to use social network framework implemented in <b>Ruby 
on Rails</b> that is easy to customize and deploy as your own powerful and 
feature packed social media site. <b>Empower</b> users with their own blogs. 
<b>Enhance collaboration</b> with forums, groups and events. Let your users post 
<b>Twitter-like status messages</b>. Track all the activity on your site with 
a live activity stream. Build a custom client to access all of your social 
data using EngineY's <b>RESTful API</b>.<br/><br/> 
<button id='getit_btn' onclick=\"location.href='http://code.google.com/p/enginey'\">Get It</button> 
<br/><br/> 
<a href='http://www.rubymi.org'>See it live...</a> 
</div> 
</div> ")

      HtmlContent.create(:title => 'enginey_screenshots',
                         :body =>
"<div id='screen_images'> 
<div class='screen_img'> 
<a href='images/ss1.jpg'>
<img src='/images/enginey.com/ss1-tb.jpg'/>
</a> 
</div> 
<div class='screen_img'> 
<a href='images/ss2.jpg'>
<img src='/images/enginey.com/ss2-tb.jpg'/>
</a> 
</div> 
</div>
")
    
      HtmlContent.create(:title => 'enginey_morecontent',
                         :body =>  
"<div id='more_content'> 
<div class='title'>HELP US GROW...</div> 
<a href='http://digg.com/programming/EngineY'>Digg this page</a> , 
<a href='http://delicious.com/save?jump=yes&url=http%3A%2F%2Fwww.enginey.com'>bookmark it on Del.icio.us</a>, or 
<a href='http://clicktotweet.com/t6nL6'>Tweet It!</a> 
<br/><br/> 
<a href='http://twitter.com/engineyfw'>
<img src='/images/enginey.com/twitter6.png'/>
</a> 
</div> 
")

      HtmlContent.create(:title => 'enginey_features',
                         :body =>
"<div id='features' class='section cssbox'> 
<div class='cssbox_head'> 
<h4 style='text-align:center;padding-top:10px;'><span class='features_title'>Features</span></h4> 
</div> 
<div class='cssbox_body'> 
<ul id='features_list'> 
<li> 
<img src='/images/enginey.com/user.png' />
<div class='feature_txt'>User profiles</div> 
</li> 
<li> 
<img src='/images/enginey.com/events.png' />
<div class='feature_txt'>Events</div> 
</li> 
<li> 
<img src='/images/enginey.com/blogs.png' />
<div class='feature_txt'>Blogs</div> 
</li> 
<li> 
<img src='/images/enginey.com/private_msgs.png' />
<div class='feature_txt'>Private Messages</div> 
</li> 
<li> 
<img src='/images/enginey.com/photos.png' />
<div class='feature_txt'>Photos</div> 
</li> 
<li> 
<img src='/images/enginey.com/forums.png' />
<div class='feature_txt'>Forums</div> 
</li> 
<li> 
<img src='/images/enginey.com/activity.png' />
<div class='feature_txt'>Activity Stream</div> 
</li> 
<li> 
<img src='/images/enginey.com/facebook.png' />
<div class='feature_txt'>Facebook Connect</div> 
</li> 
<li><a href='features.html'>and much more...</a></li> 
</ul> 
</div> 
</div> 
")
      
      HtmlContent.create(:title => 'features_side',
                         :body => "")
                         
      HtmlContent.create(:title => 'features_main',
                         :body => "")          
                         
      HtmlContent.create(:title => 'documentation_side',
                         :body => "")
                         
      HtmlContent.create(:title => 'documentation_main',
                         :body => "")    
                         
      HtmlContent.create(:title => 'team_side',
                         :body => "")
                         
      HtmlContent.create(:title => 'team_main',
                         :body => "")    
      
      ##########################################################################
      # Create Widgets   
      puts 'Creating widgets...'
      Widget.create(:name => 'html_content_home', :description => 'Managed Content Widget', :profile => false)
      

      ##########################################################################
      # Create Pages
      puts 'Creating pages...'
      Page.create(:title => 'home', :name => 'EngineY Home')
      Page.create(:title => 'features', :name => 'Features')
      Page.create(:title => 'documentation', :name => 'Documentation')
      Page.create(:title => 'team', :name => 'Team')
      
      ##########################################################################
      # Create Layouts
      puts 'Creating layouts...'
      # home
      WidgetLayout.create(:widget_id => 1, :page_id => 1, :col_num => 1, :row_num => 1, :html_content_id => 1)
      WidgetLayout.create(:widget_id => 1, :page_id => 1, :col_num => 1, :row_num => 2, :html_content_id => 2)
      WidgetLayout.create(:widget_id => 1, :page_id => 1, :col_num => 1, :row_num => 3, :html_content_id => 3)
      WidgetLayout.create(:widget_id => 1, :page_id => 1, :col_num => 2, :row_num => 1, :html_content_id => 4)
      
      #features
      WidgetLayout.create(:widget_id => 1, :page_id => 2, :col_num => 1, :row_num => 1, :html_content_id => 5)
      WidgetLayout.create(:widget_id => 1, :page_id => 2, :col_num => 2, :row_num => 1, :html_content_id => 6)
            
      #documentation
      WidgetLayout.create(:widget_id => 1, :page_id => 3, :col_num => 1, :row_num => 1, :html_content_id => 7)
      WidgetLayout.create(:widget_id => 1, :page_id => 3, :col_num => 2, :row_num => 1, :html_content_id => 8)

      #team
      WidgetLayout.create(:widget_id => 1, :page_id => 4, :col_num => 1, :row_num => 1, :html_content_id => 9)
      WidgetLayout.create(:widget_id => 1, :page_id => 4, :col_num => 2, :row_num => 1, :html_content_id => 10)
       
                   
      puts 'Database population done!'
    end
  end
end
