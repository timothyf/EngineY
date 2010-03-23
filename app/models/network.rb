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

# == Schema Information
# Schema version: 20090206190209
#
# Table name: networks
#
#  id           :integer(4)      not null, primary key
#  name         :string(255)
#  organization :string(255)
#  website      :string(255)
#  description  :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Network < ActiveRecord::Base
  
  validates_presence_of :name, :organization, :website, :description
  

  @@network = nil
  
  def self.network
    @@network ||= Network.find(:first)
  end
  
  
  def init_network
      # Populate Roles
      Role.destroy_all
      ['creator', 
       'administrator', 
       'group_admin',
       'user', 
       'contributor'].each {|r| Role.create(:rolename => r) }
   end
   
   
   def create_sample_users(count)
      (1..count).each do |number|
        user = User.new :first_name=>"Test#{number}",
                      :last_name=>"User#{number}",
                      :sex=>'M',
                      :state_id=>State.find_by_name('MICHIGAN').id,
                      :country_id=>1,
                      :zip=>'48134',
                      :login=>"testuser#{number}", 
                      :email=>"testuser#{number}@gmail.com",
                      :city=>'Flat Rock',
                      :activated_at=>'2009-01-01',
                      :password=>'testuser',
                      :password_confirmation=>'testuser'
        user.save
        user.activate
      end
  end
  
  
  def create_sample_groups
      image_1_path = File.new(RAILS_ROOT + "/public/images/rails.png")
      image_2_path = File.new(RAILS_ROOT + "/public/images/rails2.png")
      Group.destroy_all
      group = Group.new(:name => 'Detroit Ruby User Group',
                        :description => 'The Detroit Ruby User Group.',
                        :creator_id => User.find(:first).id,
                        :featured => false)    
     photo = ProfilePhoto.create(:is_profile => true, 
                         :temp_path => image_1_path, 
                         :filename => 'testgroup.png', 
                         :content_type => 'image/png',
                         :group => group)                         
     group.profile_photo = photo
     group.save
     
      group = Group.new(:name => 'Ann Arbor Ruby Brigade',
                        :description => 'The Ann Arbor Ruby User Group.',
                        :creator_id => User.find(:first).id,
                        :featured => false)    
     photo = ProfilePhoto.create(:is_profile => true, 
                         :temp_path => image_2_path, 
                         :filename => 'testgroup2.png', 
                         :content_type => 'image/png',
                         :group => group)                         
     group.profile_photo = photo
     group.save
     image_1_path.close
     image_2_path.close
  end
 
 
  def create_sample_layouts
      ##########################################################################
      # Create HTML Contents   
      puts 'Creating managed content...'
      HtmlContent.create(:title => 'sample_content',
                         :body => 'This is an example of <b>managed content</b>.');
      
      ##########################################################################
      # Create Widgets   
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
      Widget.create(:name => 'forum_posts_home', :description => 'Display recent forum posts', :profile => false)
      Widget.create(:name => 'photos_home', :description => 'Slide show of photos', :profile => false)
      Widget.create(:name => 'html_content_home', :description => 'Managed Content Widget', :profile => false)
      
      Widget.create(:name => 'status_posts_profile', :description => 'Display users status posts', :profile => true)
      Widget.create(:name => 'about_me_profile', :description => 'Display users bio', :profile => true)
      Widget.create(:name => 'blog_posts_profile', :description => 'Display users blog posts', :profile => true)
      Widget.create(:name => 'activity_feed_profile', :description => 'Display users activities', :profile => true)
      Widget.create(:name => 'links_profile', :description => 'Display users links', :profile => true)
      Widget.create(:name => 'projects_profile', :description => 'Display users projects', :profile => true)

      ##########################################################################
      # Create Pages
      puts 'Creating pages...'
      Page.create(:title => 'home', :name => 'RubyMI Home')
      Page.create(:title => 'profile', :name => 'User Profile')
      
      ##########################################################################
      # Create Layouts
      puts 'Creating layouts...'
      WidgetLayout.create(:widget_id => 1, :page_id => 1, :col_num => 1)
      WidgetLayout.create(:widget_id => 2, :page_id => 1, :col_num => 1)
      WidgetLayout.create(:widget_id => 3, :page_id => 1, :col_num => 1)
      WidgetLayout.create(:widget_id => 4, :page_id => 1, :col_num => 2)
      WidgetLayout.create(:widget_id => 5, :page_id => 1, :col_num => 2)
      WidgetLayout.create(:widget_id => 6, :page_id => 1, :col_num => 2)
      WidgetLayout.create(:widget_id => 7, :page_id => 1, :col_num => 2)
      WidgetLayout.create(:widget_id => 8, :page_id => 1, :col_num => 2)
      WidgetLayout.create(:widget_id => 9, :page_id => 1, :col_num => 3)
      WidgetLayout.create(:widget_id => 10, :page_id => 1, :col_num => 3)
      WidgetLayout.create(:widget_id => 11, :page_id => 1, :col_num => 3)
      WidgetLayout.create(:widget_id => 12, :page_id => 1, :col_num => 3, :html_content_id => 1)
      
      WidgetLayout.create(:widget_id => 13, :page_id => 2, :col_num => 2)
      WidgetLayout.create(:widget_id => 14, :page_id => 2, :col_num => 2)
      WidgetLayout.create(:widget_id => 15, :page_id => 2, :col_num => 2)
      WidgetLayout.create(:widget_id => 16, :page_id => 2, :col_num => 2)
      WidgetLayout.create(:widget_id => 17, :page_id => 2, :col_num => 3)
      WidgetLayout.create(:widget_id => 18, :page_id => 2, :col_num => 3)
  end
  
end
