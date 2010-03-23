ActionController::Routing::Routes.draw do |map|
  map.resources :follows
  map.resources :contents
  map.resources :facebook_posts
  map.resources :ideas
  map.resources :invites
  map.resources :classifieds
  map.resources :projects
  map.resources :links
  map.resources :bug_reports
  map.resources :forum_topics
  map.resources :announcements
  map.resources :job_posts
  map.resources :book_reviews
  map.resources :replies
  map.resources :rss_feeds
  map.resources :networks
  map.resource :api_key

  map.resources :widget_layouts, :collection => {:load => :get}
  map.resources :widgets, :collection => {:grid_data=>:get, :load=>:get}
  map.resources :users, :collection => {:grid_data=>:get, :link_facebook_account => :get, :fb_register_all_users => :get}
  map.resources :forum_posts, :collection => {:grid_data=>:get}
  map.resources :blog_posts, :collection => {:publish=>:get}
  map.resources :events, :collection => {:full_index=>:get}
  map.resources :stats, :collection => {:index=>:get}
  map.resources :memberships, :collection => {:find=>:get}
  
  map.resources :photo_albums
  map.resources :status_posts
  map.resources :html_contents
  map.resources :html_contents
  map.resources :feeds
  map.resources :widgets
  map.resources :forum_posts
  map.resources :wall_posts
  map.resources :events
  map.resources :activities

  map.connect 'memberships/find', :controller=>'memberships', :action=>'find' 
  map.connect 'users/change_photo', :controller=>'users', :action=>'change_photo'
  map.connect 'groups/user_data', :controller=>'groups', :action=>'user_data'
  map.connect 'users/promote_to_group_admin', :controller=>'users', :action=>'promote_to_group_admin'
  map.connect 'wall_posts/delete', :controller=>'wall_posts', :action=>'destroy'
  
  
  map.resources :videos
  map.resources :blogs
  map.resources :blog_posts
  map.resources :groups
  map.resources :photos
  map.resources :profile_photos
  map.resources :messages
  map.resources :users
  map.resources :memberships
  map.resource :session
  
  
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  
  map.resources :users do |user|
    user.resources :activities
    user.resources :friends
    user.resources :follows
    user.resources :announcements
    user.resources :book_reviews
    user.resources :groups
    user.resources :photos
    user.resources :messages
    user.resources :bug_reports
    user.resources :blog_posts
    user.resources :forum_posts
    user.resources :wall_posts
    user.resources :photos
    user.resources :photo_albums
    user.resources :links
    user.resources :projects
    user.resources :classifieds
  end 
  
  map.resources :groups do |group|
    group.resources :wall_posts
    group.resources :users
    group.resources :announcements
  end 
  
  map.resources :events do |event|
    event.resources :users
    event.resources :wall_posts
  end
  
  map.resources :forum_topics do |forum_topic|
    forum_topic.resources :forum_posts
  end
  
  # admin
  map.namespace :admin do |a|
    a.resource :theme
    a.resources :domain_themes
  end
  
  map.connect 'pages/show/:title', :controller => 'pages', :action => 'show'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "home"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
