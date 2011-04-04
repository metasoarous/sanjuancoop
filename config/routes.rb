Sanjuancoop::Application.routes.draw do |map|
	
	resources :forum_category_subscriptions, :forum_topic_subscriptions, :memberships, :content_items, :volunteer_offerings, :board_users, :faqs, :volunteer_tasks, :wholesale_orders, :member_product_request_joins, :comments, :product_requests, :forum_posts, :forum_topics, :forum_categories, :newsletters

	map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
	map.login '/login', :controller => 'user_sessions', :action => 'new'
	map.register '/register', :controller => 'users', :action => 'create'
	map.signup '/signup', :controller => 'users', :action => 'new'
	map.activate '/activate/:activation_code', :controller => "users", :action => "activate", :activation_code => nil
	map.forgot_password "/forgot_password", :controller => "users", :action => "forgot_password"
	
	map.content "/content/:tag", :controller => "content_items", :action => "show"
	
	resources :users
	resources :user_sessions
	
	map.root :controller => "welcome"
	
	
	# The priority is based upon order of creation:
	# first created -> highest priority.

	# Sample of regular route:
	#	 match 'products/:id' => 'catalog#view'
	# Keep in mind you can assign values other than :controller and :action

	# Sample of named route:
	#	 match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
	# This route can be invoked with purchase_url(:id => product.id)

	# Sample resource route (maps HTTP verbs to controller actions automatically):
	#	 resources :products

	# Sample resource route with options:
	#	 resources :products do
	#		 user do
	#			 get 'short'
	#			 post 'toggle'
	#		 end
	#
	#		 collection do
	#			 get 'sold'
	#		 end
	#	 end

	# Sample resource route with sub-resources:
	#	 resources :products do
	#		 resources :comments, :sales
	#		 resource :seller
	#	 end

	# Sample resource route with more complex sub-resources
	#	 resources :products do
	#		 resources :comments
	#		 resources :sales do
	#			 get 'recent', :on => :collection
	#		 end
	#	 end

	# Sample resource route within a namespace:
	#	 namespace :admin do
	#		 # Directs /admin/products/* to Admin::ProductsController
	#		 # (app/controllers/admin/products_controller.rb)
	#		 resources :products
	#	 end

	# You can have the root of your site routed with "root"
	# just remember to delete public/index.html.
	# root :to => "welcome#index"

	# See how all your routes lay out with "rake routes"

	# This is a legacy wild controller route that's not recommended for RESTful applications.
	# Note: This route will make all actions in every controller accessible via GET requests.
	# match ':controller(/:action(/:id(.:format)))'
end
