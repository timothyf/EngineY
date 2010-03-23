class WidgetLayout < ActiveRecord::Base
  
  belongs_to :page
  belongs_to :widget
  belongs_to :html_content
  
  attr_accessor :widget_name
  
end
