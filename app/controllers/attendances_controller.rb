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



=begin
  This class handles event attendances.
  An attendance consists of a user, and an event.
=end
class AttendancesController < ApplicationController
  
  # List all attendess of the specified event
  def index
    @event = Event.find(params[:event_id])
    @attendees = @event.attendees
    @title = "Attendees for #{@event.name}"
  end
  
  
  # Add a user to an event
  def create
    event_id = params[:event_id]
    user = User.find(params[:user_id])
    @attendance = Attendance.create({:event_id=>params[:event_id], 
                                     :attendee_id=>user.id})
    if @attendance.save
      redirect_to event_path(event_id)
    else
      redirect_to event_path(event_id)
    end
  end
  
  
  # Changes an attendance, typically used to change the status of a user's attendance
  # i.e. to change a maybe to a yes.
  def update

  end
  
  
  # Remove a user from a event
  def destroy
    user = User.find(params[:user_id])
    event = Event.find(params[:event_id])
    attendance = Attendance.find_by_attendee_id_and_event_id(user.id, event.id)
    attendance.destroy
    respond_to do |format|
      format.html { redirect_to event_path(event.id) }
      format.xml  { head :ok }
    end
  end
  
end
