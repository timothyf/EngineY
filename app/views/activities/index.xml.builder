xml.instruct!
xml.activities do
  @activities.each do |activity|
    xml.activity do
      xml.title activity_feed_message(activity).gsub(/<\/?[^>]*>/, "")
      xml.body activity_feed_message(activity)
      xml.user activity.user.name
      xml.published_at activity.created_at
    end
  end
end