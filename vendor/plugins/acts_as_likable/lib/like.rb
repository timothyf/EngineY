class Like < ActiveRecord::Base
    
    # Likes belong to a user
    belongs_to :user
    
    def self.find_likes_cast_by_user(user)
        find(:all,
            :conditions => ["user_id = ? ", user.id],
            :order => "created_at DESC"
        )
    end
end
