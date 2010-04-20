xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.rows do
  xml.page params[:page]
    xml.total_pages(@widgets.size.to_i / params[:rows].to_i)
  xml.records{@widgets.size}
  @widgets.each do |w|
    xml.row :id=>w.id do
      xml.cell w.id
      xml.cell w.name
      xml.cell w.title
      xml.cell w.active
      xml.cell w.protected
      xml.cell w.description
      xml.cell w.profile
    end
  end
end
