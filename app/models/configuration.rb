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
  
  @@config = {}
  
  
  # The self.get method is not used yet..
  def self.get
    {
      :use_proxy => false,
      :proxy_host => '10.0.6.251',
      :proxy_port => '3128',
      :enable_self_registration => true,
      :max_tweets => 5,
      :enable_facebook_connect => false
    }
  end
  
  
  # Sets the configuration (not used yet)
  def self.set(params)
    @@config[:use_proxy] = params[:use_proxy]
    @@config[:proxy_host] = params[:proxy_host]
    @@config[:proxy_port] = params[:proxy_port]
  end
  
  
  # Read configuration from a YAML file
  def self.read
    # read from enginey.yaml
  end
  
  
  # Write configuration to a YAML file
  def self.write
    # write to enginey.yaml
  end
  
  
  def self.ENABLE_FACEBOOK_CONNECT
    false
  end
  
  
  def self.USE_PROXY
    false
  end
  
  
  def self.PROXY_HOST
    '10.0.6.251'
  end
  
  
  def self.PROXY_PORT
    '3128'
  end
  
  
  def self.REQUIRE_ACTIVATE_FOR_USER_CREATE_VIA_API
    false
  end
  
  
  # Setting this field to true lets users register and activate with no approval required
  def self.ENABLE_SELF_REGISTRATION
    true
  end
  
  
  # The maximum number of tweets to fetch per user
  def self.MAX_TWEETS
    5
  end
  
  
end