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
module StatusPostsHelper
  
  # Displays the users last status post
  def show_last_post(user)
    if user.status_posts && user.status_posts.length > 0
      user.status_posts[0].body +  " <i>submitted on "  + user.status_posts[0].created_at.to_s(:event_list) + "</i>"
    else
      "No status posted yet..."
    end
  end
  
end