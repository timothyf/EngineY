#   Copyright 2009 Timothy Fisher
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

class Configuration
  
  
  def self.USE_PROXY
    false
  end
  
  
  def self.PROXY_HOST
    '10.0.6.251'
  end
  
  
  def self.PROXY_PORT
    '3128'
  end
  
  
  # Setting this field to true lets users register and activate with no approval required
  def self.ENABLE_SELF_REGISTRATION
    true
  end
  
  
  # The maximum number of tweets to fetch per user
  def self.MAX_TWEETS
    5
  end
  
  def self.THEME
    'rubymi'
    #'mycompany'
  end
  
  
  def self.USERS_LABEL
    'Members'
    #'Employees'
  end
  
  
  def self.FOOTER_IMAGE
    'poweredby.jpg'
    #'poweredby2.jpg'
  end
  
  
  # These are the items displayed in the top navigation bar
  @@nav_menu_items = nil
  def self.nav_menu_items
    @@nav_menu_items ||= [
      {'name'=>'members','title'=>self.USERS_LABEL, 'index_url'=>'users'},
      {'name'=>'blogs','title'=>'Blogs', 'index_url'=>'blog_posts'},
      {'name'=>'groups','title'=>'Groups', 'index_url'=>'groups'},
      {'name'=>'events','title'=>'Events', 'index_url'=>'events'},
      {'name'=>'photos','title'=>'Photos', 'index_url'=>'photo_manager'},
      #{'name'=>'classifieds','title'=>'Classifieds', 'index_url'=>'classifieds'},
      {'name'=>'forum','title'=>'Forum', 'index_url'=>'forum_topics'}
    ]
  end
  
  
  # These are the widgets displayed on the home page
  # For each column, the widgets are displayed in the order in which they are listed
  @@home_widgets = nil
  def self.home_widgets
    @@home_widgets ||= [{'name'=>'members_home','col_num'=>'1'},
                        {'name'=>'groups_home','col_num'=>'1'},
                        {'name'=>'events_home','col_num'=>'1'},
                        #{'name'=>'photos_home','col_num'=>'1'},
                        {'name'=>'announcements_home','col_num'=>'2'},
                        {'name'=>'activity_feed_home','col_num'=>'2'},
                        {'name'=>'blog_posts_home','col_num'=>'2'},
                        {'name'=>'links_home','col_num'=>'2'},
                        {'name'=>'projects_home','col_num'=>'2'},
                        #{'name'=>'html_content_home','col_num'=>'2','content_id'=>'2'},
                        {'name'=>'job_posts_home','col_num'=>'3'},
                        #{'name'=>'classifieds_home','col_num'=>'3'},
                        {'name'=>'forum_posts_home','col_num'=>'3'},
                        {'name'=>'photos_home','col_num'=>'3'},
                        #{'name'=>'sponsors_home','col_num'=>'3'},
                        {'name'=>'html_content_home','col_num'=>'3','content_id'=>'1'}
                        ].to_json
  end
  
  
  # These are the widgets displayed on a user's profile page
  # For each column, the widgets are displayed in the order in which they are listed
  @@profile_widgets = nil
  def self.profile_widgets
    @@profile_widgets ||= [{'name'=>'status_posts_profile','col_num'=>'2'},
                           {'name'=>'about_me_profile','col_num'=>'2'},
                           {'name'=>'blog_posts_profile','col_num'=>'2'},
                           {'name'=>'activity_feed_profile','col_num'=>'2'},
                           {'name'=>'links_profile','col_num'=>'3'},
                           {'name'=>'projects_profile','col_num'=>'3'}
                         #  {'name'=>'classifieds_profile','col_num'=>'3'}
                          ].to_json 
  end
  
  
end