class Follow < ActiveRecord::Base
  
  
  belongs_to :follower, :class_name => 'User', :foreign_key =>'follower_id'
  belongs_to :followee, :class_name => 'User', :foreign_key =>'followee_id'
  
  
end
