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
  
  # Returns a readable message associated with the activity passed in.
  def activity_feed_message(activity)
    user = activity.user
    case activity_type(activity)
      when "Friendship"
        friendship = activity.item #Friendship.find(activity.item.id)
        %(#{link_to(user.name, user_url(user))} became friends with <a href="/users/#{friendship.friend.id}">#{friendship.friend.name}</a>  <span class="activity_date">#{friendship.updated_at.to_s(:event_list)}</span>)     
      when "Event"
        event = activity.item #Event.find(activity.item.id)
        %(#{link_to(user.name, user_url(user))} added a new event - <a href="/events/#{event.id}">#{event.name}</a>  <span class="activity_date">#{event.created_at.to_s(:event_list)}</span>)
      when "User"
        if user
          %(#{link_to(user.name, user_url(user))} joined.  <span class="activity_date">#{user.created_at.to_s(:event_list)}</span>)
        else
          %(A former user joined.)          
        end
    when "Photo"
      if activity.action == 'destroy'
        %(#{link_to(user.name, user_url(user))} deleted a photo.  <span class="activity_date">#{activity.created_at.to_s(:event_list)}</span>)
      else
        if activity.item
          photo = Photo.find(activity.item.id, :select=>"id, user_id, filename, parent_id, created_at")
          %(#{image_tag(photo.user.profile_photo.public_filename(:small))}<a href="/users/#{photo.user.id}">#{photo.user.name}</a> uploaded a photo - <a href="/photos/#{photo.id}">#{image_tag(photo.public_filename(:small))}</a>.  <span class="activity_date">#{photo.created_at.to_s(:event_list)}</span>)
        else
          # photo no longer exists, but still need to display upload event for history
          %(#{link_to(user.name, user_url(user))} uploaded a photo.  <span class="activity_date">#{activity.created_at.to_s(:event_list)}</span>)
        end
      end
      
      when "Group"
        group = activity.item #Group.find(activity.item.id)
        "A new group was created, " + link_to(group.name, group_url(group)) + " <span class='activity_date'>#{group.created_at.to_s(:event_list)}</span>"
      when "BlogPost"
        blog_post = activity.item #BlogPost.find(activity.item.id, :select=>"id, title, created_at")
        if blog_post
          %(#{link_to(user.name, user_url(user))} posted a new blog entry, <a href="/blog_posts/#{blog_post.id}">#{blog_post.title}</a>.  <span class="activity_date">#{blog_post.created_at.to_s(:event_list)}</span>)
        else
          %(#{link_to(user.name, user_url(user))} posted a new blog entry.) 
        end
      when "Attendance"
        if activity.item
          attendance = activity.item #Attendance.find(activity.item.id)
          %(#{image_tag(attendance.attendee.profile_photo.public_filename(:small))}#{link_to(user.name, user_url(user))} is attending the event, <a href="events/#{attendance.event.id}">#{attendance.event.name}</a>.  <span class="activity_date">#{attendance.created_at.to_s(:event_list)}</span>)
        else
          # attendance no longer exists, user has canceled
         %(#{image_tag(user.profile_photo.public_filename(:small))}#{link_to(user.name, user_url(user))} signed up for an event, but has since revoked that decision.)
        end
      when "Membership"
        membership = activity.item #Membership.find(activity.item.id)
       %(#{link_to(user.name, user_url(user))} joined the group, <a href="/groups/#{membership.group.id}">#{membership.group.name}</a>.  <span class="activity_date">#{membership.created_at.to_s(:event_list)}</span>)
      when "ForumPost"
        forum_post = activity.item #ForumPost.find(activity.item.id)
        %(#{link_to(user.name, user_url(user))} posted a new message to the forum, <a href="/forum_posts/#{forum_post.id}">#{forum_post.title}</a>.  <span class="activity_date">#{forum_post.created_at.to_s(:event_list)}</span>)
      when "JobPost"
        job_post = activity.item #JobPost.find(activity.item.id)
        if job_post
          %(A new job was posted - #{link_to(job_post.job_title, job_posts_url)}.  <span class="activity_date">#{job_post.created_at.to_s(:event_list)}</span>)
        else
          # the job post has been deleted
          %(A new job was posted.  <span class="activity_date">#{activity.created_at.to_s(:event_list)}</span>)
        end
      when "BookReview"
        book_review = activity.item #BookReview.find(activity.item.id)
        %(#{user.name} posted a new review for #{book_review.name}.  <span class="activity_date">#{book_review.created_at.to_s(:event_list)}</span>)       
    when "StatusPost"
      status_post = activity.item #StatusPost.find(activity.item.id)
      %(#{link_to(user.name, user_url(user))} #{EngineyUtil.linkify(status_post.body)} <span class="activity_date">#{status_post.created_at.to_s(:event_list)}</span>)
    when "Link"
      link = activity.item
      if link
        %(#{link_to(user.name, user_url(user))} posted a new link <a href="#{link.url}">#{link.url}</a>)
      else
        # the link was deleted
        %(#{link_to(user.name, user_url(user))} posted a new link)
      end
    when "Project"
      project = activity.item
      if project
        %(#{link_to(user.name, user_url(user))} added a new project <a href="#{project.url}">#{project.name}</a>)
      else 
        # the project was deleted
        %(#{link_to(user.name, user_url(user))} added a new project)
      end
    when "Announcement"
      announcement = activity.item
      if announcement
        %(#{link_to(user.name, user_url(user))} posted a new announcement,  <b>#{announcement.title}</b>)
      else
        %(#{link_to(user.name, user_url(user))} posted a new announcement)
      end
    when "Classified"
      classified = activity.item
      %(#{link_to(user.name, user_url(user))} posted a new classified,  <a href="#{classified_url(classified)}">#{classified.title}</a>)
    else
      "Invalid activity type"
    end
  end
  
  
  private
  
  # Return the type of activity.
  def activity_type(activity)
    #activity.item.class.to_s  
    activity.item_type    
  end
  
end