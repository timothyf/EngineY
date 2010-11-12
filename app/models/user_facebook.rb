module UserFacebook
  
  def self.included(base)
    base.extend(ClassMethods)
  end
      
  module ClassMethods
    # Find the user in the database, first by the facebook user id and if that fails through the email hash
    def find_by_fb_user(fb_user)
      User.find_by_facebook_id(fb_user.uid) || User.find_by_email_hash(fb_user.email_hashes)
    end
  
  
    # Create a new local user account based on the Facebook user data.
    def create_from_fb_connect(fb_user, email, login, first_name, last_name)
      new_facebooker = User.new(:last_name => last_name,
                                :first_name => first_name,
                                :login => login, 
                                :password => "", 
                                :email => email,
                                :facebook_id => fb_user.uid.to_i,
                                :activated_at => Time.now.utc) 
      new_facebooker.save(false)  # save without validations since no password is used
      new_facebooker.register_user_to_fb
      log_activity(new_facebooker)
      User.reset_cache
    end
  end
  
  
  # We are going to connect this user object with a facebook id. But only ever one account.
  def link_fb_connect(fb_user_id)
    if fb_user_id
      existing_fb_user = User.find_by_facebook_id(fb_user_id)
      if existing_fb_user
        existing_fb_user.unlink_fb_user
      end
      link_fb_user(fb_user_id)
    end
  end
  
  
  # The Facebook registers user method is going to send the users email hash and our account id to Facebook
  # We need this so Facebook can find friends on our local application even if they have not connect through connect
  # We then use the email hash in the database to later identify a user from Facebook with a local user
  def register_user_to_fb
    if Configuration.ENABLE_FACEBOOK_CONNECT
      # only do this if facebook connect is enabled
      users = [{:email => email, :account_id => id}]
      Facebooker::User.register(users)
      self.email_hash = Facebooker::User.hash_email(email)
      save(false)
    end
  end


  # Checks to see if this user has a registered facebook account
  def facebook_user?
    return !facebook_id.nil? && facebook_id > 0
  end


  # Returns an array of facebook posts for this user
  def get_facebook_posts
    facebook_session.user.statuses(5)
  end
  
  
  def link_fb_user(fb_user_id)
    self.facebook_id = fb_user_id
    save(false)
  end
 
 
  def unlink_fb_user
    self.facebook_id = nil
    save(false) 
  end
  
end