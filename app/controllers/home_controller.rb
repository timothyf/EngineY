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

class HomeController < ApplicationController
  
  #caches_action :index, :layout=>false
  
  
  # First time install of a network
  def install
    @network = Network.new
    @network.name = "Install"
    render 'install', :layout => 'install' 
  end
  
  
  # Called when the install page is submitted to create and initialize the network.
  def do_install
    # make sure install is authorized
    # (maybe check for a master password???)
    # (or check to see if a network already exists???)
    # clear out all existing data

    # Create Network
    Network.destroy_all
    network = Network.new(:name => params[:network_name],
                          :organization => params[:network_org],
                          :website => params[:network_website],
                          :description => params[:network_desc])
          
    User.destroy_all                     
    user1 = User.new :first_name=>params[:first_name],
                     :last_name=>params[:last_name],
                     :login=>params[:login], 
                     :email=>params[:email],
                     :password=>params[:password],
                     :password_confirmation=>params[:password_confirmation]
    if network.valid? && user1.valid?
        network.save
        network.init_network()     
        user1.save     
        user1.activate
        user1.roles << Role.find_by_rolename('creator')
        
        if params[:sample_data_input]
          network.create_sample_users(10)
          network.create_sample_groups
          network.create_sample_layouts
        end
        
  
        # redirect to network home page (/home/index)
        redirect_to :action => 'index'   
    else
        # redirect back to install page
        redirect_to :action => 'install' 
    end  
  end
  
  
  # Render the network's homepage
  def index
    if Network.find(:first) == nil
      flash[:notice] = 'Looks like you have not created a network yet.'
      redirect_to :action => 'install'
    else
      @section = 'MAIN'
      @page_name = 'home' 
      @photos = Photo.find(:all, :limit=>6, 
                           :select=>'id, parent_id, filename', 
                           :order => Photo.connection.adapter_name == 'PostgreSQL' ? 'RANDOM()' : 'RAND()',
                           :conditions => {:thumbnail => nil, :is_profile => nil})
    end
  end
  
  
  def privacy
    @section = 'PRIVACY'
    @privacy = HtmlContent.find_by_content_id('privacy')
  end
  
  
  def shop
    @section = 'SHOP'
  end
  
  
  def sponsor
    @section = 'SPONSOR'
  end
  
end
