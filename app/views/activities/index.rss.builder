xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
	xml.channel do
		xml.title "RubyMI Activity Feed"
    #xml.link  activities_url
    xml.link  "http://www.rubymi.org"
    xml.pubDate CGI.rfc1123_date @activities.first.created_at if @activities.any?
    xml.description "RubyMI Activity Feed"
    
    @activities.each do |activity|
      xml.item do
        # Strips HTML off of the title string
        xml.title activity_feed_message(activity).gsub(/<\/?[^>]*>/, "")
        xml.link activity_url(activity)
        xml.description activity_feed_message(activity)
        xml.pubDate CGI.rfc1123_date activity.created_at
        xml.guid activity_url(activity)
        if activity.user
          xml.author "#{activity.user.name}"
        end
      end
    end
	end
end
