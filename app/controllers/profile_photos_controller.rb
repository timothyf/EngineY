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

class ProfilePhotosController < ApplicationController
  
  def new
    @photo = ProfilePhoto.new
  end
  
  
  def create
    # remove old profile photos
    ProfilePhoto.delete_all("user_id = " + current_user.id.to_s + " AND is_profile = true")

    # save new photo
    @photo = ProfilePhoto.new(params[:profile_photo])
    @photo.user_id = current_user.id;
    @photo.is_profile = true;
    if @photo.save
      flash[:notice] = 'Profile Photo was successfully created.'
      redirect_to edit_user_path(current_user) 
    else
      render edit_user_path(current_user) 
    end
  end
  
end
