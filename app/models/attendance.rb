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

class Attendance < ActiveRecord::Base
  
  after_create :log_activity
  
  belongs_to :attendee, :class_name => 'User', :foreign_key =>'attendee_id'
  belongs_to :event
  
  
  def log_activity
    Attendance.log_activity(self)
  end
  
  
  class << self
    def log_activity(attendance)
      Activity.create!(:item => attendance, :user => attendance.attendee)
    end
  end
  
end
