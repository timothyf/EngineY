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
  
  @@settings = nil
  
  
  # The self.get method is not used yet..
#  def self.get
#    {
#      :use_proxy => false,
#      :proxy_host => '10.0.6.251',
#      :proxy_port => '3128',
#      :enable_self_registration => true,
#      :max_tweets => 5,
#      :enable_facebook_connect => false
#    }
#  end

  def self.create_defaults
    ConfigSetting.create(:name=>'use_proxy', :value=>'false')
    ConfigSetting.create(:name=>'proxy_host', :value=>'')
    ConfigSetting.create(:name=>'proxy_port', :value=>'')
    ConfigSetting.create(:name=>'enable_facebook_connect', :value=>'false')
    ConfigSetting.create(:name=>'require_activate_for_user_create_via_api', :value=>'false')
    ConfigSetting.create(:name=>'enable_self_registration', :value=>'true')
    ConfigSetting.create(:name=>'max_tweets_per_user', :value=>'5')
  end
  
  
  def self.read_settings
    @@settings = ConfigSetting.find(:all)
  end
  
  
  def self.ENABLE_FACEBOOK_CONNECT
    read_settings if @@settings == nil
    if (@@settings.select {|setting|setting.name == 'enable_facebook_connect'})[0].value == 'true'
      return true
    else
      return false
    end
  end
  
  
  def self.USE_PROXY
    read_settings if @@settings == nil
    if (@@settings.select {|setting|setting.name == 'use_proxy'})[0].value == 'true'
      return true
    else
      return false
    end
  end
  
  
  def self.PROXY_HOST
    read_settings if @@settings == nil
    (@@settings.select {|setting|setting.name == 'proxy_host'})[0].value
  end
  
  
  def self.PROXY_PORT
    read_settings if @@settings == nil
   (@@settings.select {|setting|setting.name == 'proxy_port'})[0].value
  end
  
  
  def self.REQUIRE_ACTIVATE_FOR_USER_CREATE_VIA_API
    read_settings if @@settings == nil
    if (@@settings.select {|setting|setting.name == 'require_activate_for_user_create_via_api'})[0].value == 'true'
      return true
    else
      return false
    end
  end
  
  
  # Setting this field to true lets users register and activate with no approval required
  def self.ENABLE_SELF_REGISTRATION
    read_settings if @@settings == nil
    if (@@settings.select {|setting|setting.name == 'enable_self_registration'})[0].value == 'true'
      return true
    else
      return false
    end
  end
  
  
  # The maximum number of tweets to fetch per user
  def self.MAX_TWEETS
    read_settings if @@settings == nil
    (@@settings.select {|setting|setting.name == 'max_tweets_per_user'})[0].value.to_i
  end
  
  
end