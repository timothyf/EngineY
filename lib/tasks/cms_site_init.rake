namespace :enginey do
    desc "Add sample data to the database"
    task :cms_site_init => :environment do
      
      ##########################################################################
      # SETUP, modify this to change how you want to configure your sample data
      NETWORK_NAME = 'EngineY'
      ##########################################################################
      
      # Output configuration
      puts 'Setting up sample data for your EngineY CMS Site.'
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
      user1.activate
      user1.roles << Role.find_by_rolename('creator')

      
      ##########################################################################
      # Create Pages
      puts 'Creating pages...'
      Page.create(:title => 'home', :name => 'Home')
      Page.create(:title => 'about', :name => 'About')
      Page.create(:title => 'products', :name => 'Products')
      Page.create(:title => 'team', :name => 'Team')
      
      ##########################################################################
      # Create Widgets   
      puts 'Creating widgets...'
      Widget.create(:name => 'html_content_home', :description => 'Managed Content Widget', :profile => false)
      
      ##########################################################################
      # Create HTML Contents   
      puts 'Creating managed content...'
      HtmlContent.create(:title => 'site_nav',
                         :body => "
                          <ul>
                          <li><a href='/'>Home</a></li>
                          <li><a href='/pages/show/about'>About</a></li>
                          <li><a href='/pages/show/products'>Products</a></li>
                          <li><a href='/pages/show/team'>Team</a></li>
                          </ul>")

      HtmlContent.create(:title => 'home_main',
                         :body =>"
                         This is your home page
                         ")
                         
      HtmlContent.create(:title => 'about_main',
                         :body => "
                         This is your about page
                         ")          
                         
      HtmlContent.create(:title => 'products_main',
                         :body => "
                         This is your products page
                         ")    
                         
      HtmlContent.create(:title => 'team_main',
                         :body => "
                         This is your team page
                         ")    
            
      ##########################################################################
      # Create Layouts
      puts 'Creating layouts...'
      # home
      WidgetLayout.create(:widget_id => 1, :page_id => 1, :col_num => 1, :row_num => 1, :html_content_id => 1)
      WidgetLayout.create(:widget_id => 1, :page_id => 1, :col_num => 2, :row_num => 1, :html_content_id => 2)
      
      #about
      WidgetLayout.create(:widget_id => 1, :page_id => 2, :col_num => 1, :row_num => 1, :html_content_id => 1)
      WidgetLayout.create(:widget_id => 1, :page_id => 2, :col_num => 2, :row_num => 1, :html_content_id => 3)
            
      #products
      WidgetLayout.create(:widget_id => 1, :page_id => 3, :col_num => 1, :row_num => 1, :html_content_id => 1)
      WidgetLayout.create(:widget_id => 1, :page_id => 3, :col_num => 2, :row_num => 1, :html_content_id => 4)

      #team
      WidgetLayout.create(:widget_id => 1, :page_id => 4, :col_num => 1, :row_num => 1, :html_content_id => 1)
      WidgetLayout.create(:widget_id => 1, :page_id => 4, :col_num => 2, :row_num => 1, :html_content_id => 5)
       
      ##########################################################################
      # Set the Theme
      puts 'Setting Theme...'     
      Theme.create(:name => 'cms_site_sample')         
                   
      puts 'Database population done!'
    end
end
