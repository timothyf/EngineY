# sample usage
#   event.start_time.to_s(:event_brief)

#   February 27
Time::DATE_FORMATS[:event_list] = "%B %d"

#  Feb 27, 2009
Time::DATE_FORMATS[:short_text] = "%b %d, %Y" 

#   Friday
Time::DATE_FORMATS[:event_day] = "%A"

#   February 27, 2009 at 12:04 PM
Time::DATE_FORMATS[:event_brief] = "%B %d, %Y at %I:%M %p"

#   2009-03-04 13:51:51
Time::DATE_FORMATS[:basic] = "%Y-%m-%d %I:%M %p"
