class Idea < ActiveRecord::Base
  
  include Streamable 
  acts_as_streamable
  
  belongs_to :user
  belongs_to :group
  
end
