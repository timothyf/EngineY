# ActsAsLikable
module Adventtec
    module Acts #:nodoc:
        module Likable #:nodoc:
            
            def self.included(base)
                base.extend ClassMethods
            end
            
            module ClassMethods
                def acts_as_likable
                    has_many :likes, :as => :likable, :dependent => :destroy
                    include Adventtec::Acts::Likable::InstanceMethods
                    extend Adventtec::Acts::Likable::SingletonMethods
                end
            end
            
            # This module contains class methods
            module SingletonMethods
                def find_likes_cast_by_user(user)
                    likable = ActiveRecord::Base.send(:class_name_of_active_record_descendant, self).to_s
                    Vote.find(:all,
                        :conditions => ["user_id = ? likable_type = ?", user.id, likable],
                        :order => "created_at DESC"
                    )
                end
            end
            
            # This module contains instance methods
            module InstanceMethods
                
                # Same as likable.likes.size
                def likes_count
                    self.likes.size
                end
                
                def users_who_liked
                    users = []
                    self.likes.each { |v| 
                        users << v.user
                    }
                    users
                end
                
                def liked_by_user?(user)
                   rtn = false
                   if user
                       self.likes.each { |v| 
                           rtn = true if user.id == v.user_id
                       }
                   end
                   rtn
                end
            end
        end
    end
end