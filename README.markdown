# Welcome to EngineY
While originally designed to be a social networking framework allowing users to easily build a social network site, EngineY has become something much greater.  It now has full Content Management capabilities and features similar to a full portal, such as the popular Java Portals like Liferay.  

EngineY is implemented in Ruby on Rails and is easy to customize and deploy as your own powerful and feature packed social media site. Empower users with their own blogs. Enhance collaboration with forums, groups and events. Let your users post Twitter-like status messages. Track all the activity on your site with a live activity stream. Build a custom client to access all of your social data using EngineY's RESTful API. 


## Installation

EngineY requires the rmagick gem. To correctly install that gem along with the correct version of Imagemagick for your platform see this FAQ:
http://rmagick.rubyforge.org/install-faq.html
Edit the config/database.yml file to configure a local database for use with EngineY.

You might need the following gem(s)

    $ gem install disguise (2.0.0 version)
    $ gem install rack (1.2.1)
    $ gem install rails (2.3.5)
    $ gem install hpricot

The following are installed using rake gem:install
    $ ruby-openid
    $  aws-s3  
    $  jammit  


Run the following three commands in order:
    $ rake db:create:all
    $ rake db:migrate
These will create the database with the correct schema.

The run the app
    $ ruby script/server and browse http://localhost:3000 for the remainder of the setup.

You can populate the app with data for a sample site, Use the "Populate with Sample Data" function on the engineY install page. This will allow you to run the application and have a look around. 

After logging in as the Admin, you can go to the 'Manage' tab and click on the 'Settings' tab.  From that page, you can set a theme for your site.  For example, try setting the RubyMI theme to see an example of what a Ruby community site might look like.

## Getting Help/Support

Additional documentation is available on the wiki pages.  Any questions that you have about using EngineY or developing with EngineY should be posted to the EngineY Google Group http://groups.google.com/group/enginey.


