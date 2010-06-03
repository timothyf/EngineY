xml.instruct!
xml.posts do
  @posts.each do |post|
    xml.post do
      xml.title post.title
      xml.body post.body
      xml.created_at post.created_at
      xml.views post.views
      xml.topics do
        post.blog_post_topics.each do |topic|
          xml.topic do
            xml.name topic.name
          end
        end
      end
      xml.tags do
        post.tags.each do |tag|
          xml.tag do
            xml.name tag.name
          end
        end
      end
    end
  end
end