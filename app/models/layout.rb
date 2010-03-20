class Layout < ActiveRecord::Base
  
  belongs_to :page
  belongs_to :widget
  
  attr_accessor :widget_name
  
end
