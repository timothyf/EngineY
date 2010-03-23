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
                     :description => 'The homepage for the EngineY framework.')
    
      
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
      
      photo = ProfilePhoto.create(:is_profile => true, 
                         :temp_path => File.new(RAILS_ROOT + "/public/images/tim.png"), 
                         :filename => 'tim.png', 
                         :content_type => 'image/png',
                         :user => user1)
      user1.profile_photo = photo
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
</div> ");
      
      
      ##########################################################################
      # Create Widgets   
      puts 'Creating widgets...'
      Widget.create(:name => 'html_content_home', :description => 'Managed Content Widget', :profile => false)
      

      ##########################################################################
      # Create Pages
      puts 'Creating pages...'
      Page.create(:title => 'home', :name => 'RubyMI Home')
      
      ##########################################################################
      # Create Layouts
      puts 'Creating layouts...'
      WidgetLayout.create(:widget_id => 1, :page_id => 1, :col_num => 1, :row_num => 1, :html_content_id => 1)
      
      puts 'Database population done!'
    end
  end
end
