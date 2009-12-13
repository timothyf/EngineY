class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.timestamps
      
      # Basic Identification
      t.string   :login
      t.string   :email
      t.string   :email_hash
      t.string   :first_name
      t.string   :last_name
      t.string   :sex
      t.string   :city
      t.integer  :state_id
      t.string   :zip
      t.integer  :country_id
      t.string   :phone
      t.string   :phone2
      t.string   :time_zone,                               :default => "UTC"
      
      # Extended Profile Info
      t.text     :about_me
      t.string   :organization
      t.text     :skills
      t.text     :occupation
      t.boolean  :featured,                                 :default => false
      t.boolean  :show_blog_posts_on_home,                  :default => true
      t.boolean  :use_gravatar,                             :default => false
      
      # On the Web
      t.string   :website
      t.string   :blog
      t.string   :blog_feed
      t.string   :flickr
      t.string   :flickr_username
      t.string   :linked_in_url
      t.string   :twitter_id
      t.boolean  :display_tweets,                           :default => false
      t.string   :aim_name
      t.string   :gtalk_name
      t.string   :yahoo_messenger_name
      t.string   :msn_name
      t.string   :youtube_username
      t.string   :skype_name
      t.string   :facebook_url
      t.integer  :facebook_id   # used with Facebook Connect
      t.string   :resume_url
      t.string   :company_url
      
      # Activity
      t.integer  :posts_count,                             :default => 0
      t.datetime :last_seen_at
      t.integer  :login_count,                              :default => 0
           
      # Authentication
      t.string    :crypted_password,          :limit => 40
      t.string    :salt,                      :limit => 40
      t.string    :remember_token
      t.datetime  :remember_token_expires_at
      t.string    :activation_code, :limit => 40
      t.datetime  :activated_at
      t.string    :password_reset_code,       :limit => 40
      t.boolean   :enabled,                                 :default => true
      t.boolean   :is_active,                               :default => false     
      t.string    :identity_url
           
    end
  end

  def self.down
    drop_table "users"
  end
end
