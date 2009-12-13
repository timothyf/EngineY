require 'rss/2.0'
require 'open-uri'

class RssReader
  
  def parseFeed (url, length)
    feed_url = url
    output = "";
    open(feed_url) do |http|
      response = http.read
      result = RSS::Parser.parse(response, false)
      output = "<span class=\"feedTitle\">#{result.channel.title}</span><br /><ul>" 
      result.items.each_with_index do |item, i|
        output += "<li><a href=\"#{item.link}\">#{item.title}</a></li>" if ++i < length  
      end 
      output += "</ul>" 
    end
    return output
  end
  
  
  # refactored
  def self.posts_for(feed_url, length=4, perform_validation=false)
    posts = []
    begin
      #open(feed_url, :proxy => "http://10.0.6.251:3128") do |rss|
      open(feed_url) do |rss|
        posts = RSS::Parser.parse(rss, perform_validation).items
      end
    rescue Errno::ETIMEDOUT
      posts = []
      return posts
    end
    posts[0..length - 1] if posts.size > length
  end
  
  
  def self.all_posts(feed_url)
    posts = []
    begin
      #open(feed_url, :proxy => "http://10.0.6.251:3128") do |rss|
      open(feed_url) do |rss|
        posts = RSS::Parser.parse(rss, perform_validation).items
      end
    rescue Errno::ETIMEDOUT
      posts = []
      return posts
    end
    posts
  end
  
end



