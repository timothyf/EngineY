class EngineyUtil
  
  def self.linkify(text)
    @generic_URL_regexp = Regexp.new( '(^|[\n ])([\w]+?://[\w]+[^ \"\n\r\t<]*)', Regexp::MULTILINE | Regexp::IGNORECASE )
    @starts_with_www_regexp = Regexp.new( '(^|[\n ])((www)\.[^ \"\t\n\r<]*)', Regexp::MULTILINE | Regexp::IGNORECASE )
    @starts_with_ftp_regexp = Regexp.new( '(^|[\n ])((ftp)\.[^ \"\t\n\r<]*)', Regexp::MULTILINE | Regexp::IGNORECASE )
    @email_regexp = Regexp.new( '(^|[\n ])([a-z0-9&\-_\.]+?)@([\w\-]+\.([\w\-\.]+\.)*[\w]+)', Regexp::IGNORECASE )
    
    @twitter_name_regexp = Regexp.new('(@)([^:^ \"\t\n\r<]*)([ :])', Regexp::MULTILINE | Regexp::IGNORECASE)
    
    s = text.to_s
    s.gsub!( @generic_URL_regexp, '\1<a href="\2">\2</a>' )
    s.gsub!( @starts_with_www_regexp, '\1<a href="http://\2">\2</a>' )
    s.gsub!( @starts_with_ftp_regexp, '\1<a href="ftp://\2">\2</a>' )
    s.gsub!( @email_regexp, '\1<a href="mailto:\2@\3">\2@\3</a>' )
    s.gsub!( @twitter_name_regexp, '<a href="http://twitter.com/\2">\1\2</a>\3' )
    s
  end
end