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
module ActivityFeedHelper
  
  def display_like_text(activity)
		if current_user.like_this?(activity) == true
			if activity.likes.size > 1
				text = "You and #{(activity.likes.size - 1).to_s} other #{activity.likes.size > 2 ? 'people':'person'} like this"
			else
				text = "You like this"
			end
		elsif activity.likes && activity.likes.size > 0
			if activity.likes.size > 1
				text = "#{(activity.likes.size).to_s} people like this"
			else
				text = "1 person likes this"
			end
		else
			text = "Be the first to like this"
		end
		return text
  end
  
  
  def user_link(user)
    "#{link_to(user.name, user_url(user))}"
  end
  
  
  def activity_date(item)
    "<span class=\"activity_date\">#{item.created_at.to_s(:event_list)}</span>"
  end
  
  
  # Returns a readable message associated with the activity passed in.
  def activity_feed_message(activity)
    user = activity.user
    case activity.item_type
      when "Friendship"
        friendship = activity.item
        %(#{user_link(user)} became friends with #{link_to friendship.friend.name, '/users/' + friendship.friend.id.to_s}  <span class="activity_date">#{friendship.updated_at.to_s(:event_list)}</span>)     
      when "Event"
        event = activity.item
        %(#{user_link(user)} added a new event - #{link_to event.name, '/events/'+event.id.to_s}  #{activity_date(event)})
      when "User"
        if user
          %(#{user_link(user)} joined.  #{activity_date(user)})
        else
          %(A former user joined. #{activity_date(activity)})          
        end
      when "Photo"
        if activity.action == 'destroy'
          %(<span class="activity_text"><span class="activity_user_link">#{user_link(user)}</span> deleted a photo.</span>#{activity_date(activity)})
        else
          if activity.item
            photo = Photo.find(activity.item.id, :select=>"id, user_id, filename, parent_id, created_at")
            %(<span class="activity_text"><span class="activity_user_link">#{user_link(user)}</span> uploaded a photo - <a href="/photos/#{photo.id}">#{image_tag(photo.public_filename(:small))}</a>.</span>#{activity_date(photo)})
          else
            # photo no longer exists, but still need to display upload event for history
            %(<span class="activity_text"><span class="activity_user_link">#{user_link(user)}</span> uploaded a photo.</span>#{activity_date(activity)})
          end
        end    
      when "Group"
        group = activity.item
        if group
          %(A new group was created, #{link_to(group.name, group_url(group))} #{activity_date(group)})
        else
          %(A new group was created, group no longer exists)
        end
      when "BlogPost"
        blog_post = activity.item
        if blog_post
          %(#{user_link(user)} posted a new blog entry, <a href="/blog_posts/#{blog_post.id}">#{blog_post.title}</a>.  #{activity_date(blog_post)})
        else
          %(#{user_link(user)} posted a new blog entry.) 
        end
      when "Attendance"
        if activity.item
          attendance = activity.item
          %(#{user_link(user)} is attending the event, #{link_to attendance.event.name, 'events/' + attendance.event.id.to_s}.  #{activity_date(attendance)})
        else
          # attendance no longer exists, user has canceled
         %(#{image_tag(user.profile_photo.public_filename(:small))}#{user_link(user)} signed up for an event, but has since revoked that decision.)
        end
      when "Membership"
        membership = activity.item
       %(<span class="activity_text"><span class="activity_user_link">#{user_link(user)}</span> joined the group, <a href="/groups/#{membership.group.id}">#{membership.group.name}</a>.  </span>#{activity_date(membership)})
      when "ForumPost"
        forum_post = activity.item
        %(#{user_link(user)} posted a new message to the forum, <a href="/forum_posts/#{forum_post.id}">#{forum_post.title}</a>.  #{activity_date(forum_post)})
      when "JobPost"
        job_post = activity.item
        if job_post
          %(A new job was posted - #{link_to(job_post.job_title, job_posts_url)}.  #{activity_date(job_post)})
        else
          # the job post has been deleted
          %(A new job was posted.  #{activity_date(activity)})
        end
      when "BookReview"
        book_review = activity.item
        %(#{user.name} posted a new review for #{book_review.name}.  #{activity_date(book_review)})       
      when "StatusPost"
        status_post = activity.item
        %(<span class="activity_text"><span class="activity_user_link">#{user_link(user)}</span> #{EngineyUtil.linkify(status_post.body)}</span>#{activity_date(status_post)})
      when "Link"
        link = activity.item
        if link
          %(#{user_link(user)} posted a new link #{link_to link.url, link.url} #{activity_date(link)})
        else
          # the link was deleted
          %(#{user_link(user)} posted a new link)
        end
      when "Project"
        project = activity.item
        if project
          %(#{user_link(user)} added a new project  #{link_to project.name, project.url} #{activity_date(project)})
        else 
          # the project was deleted
          %(#{user_link(user)} added a new project #{activity_date(activity)})
        end
      when "Announcement"
        announcement = activity.item
        if announcement
          %(#{user_link(user)} posted a new announcement,  <b>#{announcement.title}</b> #{activity_date(announcement)})
        else
          %(#{user_link(user)} posted a new announcement #{activity_date(activity)})
        end
      when "Classified"
        classified = activity.item
        %(#{user_link(user)} posted a new classified,  #{link_to classified.title, classified_url(classified)})
      else
        %(Invalid activity type - #{activity.item_type})
      end
  end

  
end