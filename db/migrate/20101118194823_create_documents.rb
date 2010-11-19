class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.string      :document_file_name
      t.string      :document_content_type
      t.integer     :document_file_size
      t.datetime    :document_updated_at
      
      t.integer     :user_id  # the user who uploaded the document
      
      # can be associated with a group or event
      t.integer     :group_id
      t.integer     :event_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end
