xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.rows do
  xml.page params[:page]
    xml.total_pages (@forum_posts.size.to_i / params[:rows].to_i)
  xml.records{@forum_posts.size}
  @forum_posts.each do |post|
    xml.row :id=>post.id do
      xml.cell post.id
      xml.cell post.title
      xml.cell post.views
      xml.cell post.replies.length     
      if post.replies && post.replies.length > 0
        xml.cell post.replies[post.replies.length-1].created_at
      else
        xml.cell post.created_at
      end
      
      
    end
  end
end
