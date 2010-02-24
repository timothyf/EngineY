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
# Table name: friendships
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  friend_id  :integer(4)
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Friendship < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :friend, :class_name => 'User', :foreign_key =>'friend_id'
  
  validates_presence_of :user_id, :friend_id
  
  attr_accessible :status, :user_id, :friend_id
  
  # Status codes.
  ACCEPTED  = 0
  REQUESTED = 1
  PENDING   = 2
  
  
  def accept
    Friendship.accept(user_id, friend_id)
  end
  
  
  def breakup
    Friendship.breakup(user_id, friend_id)
  end
  
  
  class << self
    
    # Return true if the users are (possibly pending) friends.
    def exists?(user, friend)
      not get_friendship(user, friend).nil?
    end
    
    alias exist? exists?
    
    # Make a pending friendship request
    def request(user, friend)
      if user == friend or Friendship.exists?(user, friend)
        nil
      else
        transaction do
          Friendship.create(:user_id => user.id, :friend_id => friend.id, :status => 'requested')
          Friendship.create(:user_id => friend.id, :friend_id => user.id, :status => 'pending')
        end
        true
      end
    end
    
    # Accept a friendship request.
    def accept(user, friend)
      transaction do
        accept_one_side(user, friend)
        accept_one_side(friend, user)
        friendship = get_friendship(user, friend)
        if friendship
          log_activity(friendship)
          return true
        else
          return false
        end
      end
      
    end
    
    
    def connect(user, friend)
      transaction do
        request(user, friend)
        accept(user, friend)
      end
      get_friendship(user, friend)
    end
    
    
    # Delete a friendship or cancel a pending request.
    def breakup(user, friend)
      transaction do
        destroy(get_friendship(user, friend))
        destroy(get_friendship(friend, user))
      end
    end
    
    
    # Return a friendship based on the user and friend.
    def get_friendship(user, friend)
      find_by_user_id_and_friend_id(user, friend)
    end
    
  end
  
  private
  
  class << self
    
    # Update the db with one side of an accepted friendship request.
    def accept_one_side(user, friend)
      friendship = get_friendship(user, friend)
      if friendship
        friendship.update_attributes!(:status => 'accepted')
      else
        nil
      end
    end
    
    
    def log_activity(friendship)
      activity = Activity.create!(:item => friendship, :user => friendship.user)
    end
  end
end
