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
module BlogPostsHelper
  
  def months 
    ['January','February','March','April','May','June','July']
  end
  
  
  #### DO PROPER DATE MATH     INCLUDE THE WHOLE DATE NOT JUST THE MONTH
  #### THIS WILL TAKE CARE OF YEAR CHANGE
  
  
  def show_archive_links
    # iterate over last 5 months
    date = Time.new
    curr_mon = date.month

    html = ''
    html += "<ul>"
    (1..4).each do |num|
      dt = date - num.month
      html += "<li> " + link_to(months[dt.month-1] + ' 2010', '') + "</li>"
    end
    html += "</ul>"
    html
  end
  
  
end
