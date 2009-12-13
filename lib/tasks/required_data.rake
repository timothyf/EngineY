namespace :railsnet do
  namespace :db do
    desc "Add default values to the database"
    task :required_data => :environment do
      
      ##########################################################################
      # SETUP, modify this to change how you want to configure your sample data
      NETWORK_NAME = 'RubyMI'
      ##########################################################################
      
      # Start data creation
      puts 'Create network...'
      Network.destroy_all
      Network.create(:name => NETWORK_NAME,
                     :organization => 'Ruby Enthusiasts of Michigan',
                     :website => 'http://www.rubymi.org',
                     :description => 'Welcome to the Michigan Ruby Community website.  This site serves as a hub for all of the Ruby related activities and events that happen in and around Michigan.')
    
      puts 'Populating roles...'
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
                          
      puts 'Database population done!'
    end
  end
end
