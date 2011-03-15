class API
  
  # Returns an array of users who have API keys
  def self.users
    User.find(:all, :conditions=>'api_key != null')
  end
  
  
end