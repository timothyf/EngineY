# Include hook code here
require 'acts_as_likable'
ActiveRecord::Base.send(:include, Adventtec::Acts::Likable)