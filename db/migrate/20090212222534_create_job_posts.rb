class CreateJobPosts < ActiveRecord::Migration
  def self.up
    create_table :job_posts do |t|
      t.string    :job_title
      t.string    :job_id
      t.string    :company
      t.string    :website
      t.string    :contact_name
      t.string    :email
      t.text      :description
      t.boolean   :featured
      t.date      :end_date
      t.timestamps
    end
  end

  def self.down
    drop_table :job_posts
  end
end
