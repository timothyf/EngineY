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

class UserObserver < ActiveRecord::Observer
  
  
  # Triggered after a user signs up but before they 
  # have been activated.
  def after_create(user)
    if !user.email.include?('email.com')
      UserMailer.deliver_signup_notification(user)  
      if !User.admins_and_creators.empty?
        UserMailer.deliver_new_user_signup(user)
      end
    end
  end


  # Look for save when user has been activated
  def after_save(user)  
    if !user.email.include?('email.com')
      UserMailer.deliver_activation(user) if user.recently_activated?
      if !User.admins_and_creators.empty?
        UserMailer.deliver_new_user_activated(user) if user.recently_activated?
      end
    end
  end


end
