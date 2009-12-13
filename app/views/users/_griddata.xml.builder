xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.rows do
  xml.page params[:page]
    xml.total_pages (@users.size.to_i / params[:rows].to_i)
  xml.records{@users.size}
  @users.each do |user|
    xml.row :id=>user.id do
      xml.cell user.id
      xml.cell user.first_name
      xml.cell user.last_name
    end
  end
end
