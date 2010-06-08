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
  
  
  def show_archive_links
    # iterate over last 5 months
    date = Time.new
    curr_mon = date.month

    html = ''
    html += "<ul>"
    (1..36).each do |num|
      date = date - 1.month
      posts = get_posts_for_month_year(date)
      if posts && posts.length > 0
        html += "<li> " + link_to(months[date.month-1] + " #{date.year.to_s}", "/blog_posts?month=#{date.month}&year=#{date.year}") + "</li>"
      end
    end
    html += "</ul>"
    html
  end
  
  
  private
  
  def get_posts_for_month_year(date)
    start_date = "#{date.year.to_s}-#{date.strftime('%m')}-01"
    end_date = "#{date.year.to_s}-#{(date + 1.month).strftime('%m')}-01"
    @blog_posts = BlogPost.find(:all, 
                                :conditions => "created_at > '#{start_date}' AND created_at < '#{end_date}'", 
                                :order => 'created_at DESC')
    @blog_posts
  end
  
  
end
