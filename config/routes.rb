Boomstick::Application.routes.draw do
  match "login" => "sessions#new", :as => :login
  match "logout" => "sessions#destroy", :as => :logout
  match "brand_offers" => "pages#home", :as => :brand_offers
  match "retail_offers" => "pages#retail_offers", :as => :retail_offers
  match "saved_offers" => "pages#saved_offers", :as => :saved_offers
  match "signup" => "consumers#new", :as => :signup
  match "update_consumer" => "consumers#update", :as => :update_consumer
  match "deliver/:coupon_id" => "pages#event", :event => "deliver", :as => :deliver_coupon
  match "save/:coupon_id" => "pages#event", :event => "select", :as => :save_coupon
  match "remove/:coupon_id" => "pages#event", :event => "remove", :as => :remove_coupon
  match "search_offers" => "pages#search_offers", :as => :search_offers
  resources :consumers
  resources :local_consumers, :controller => "consumers"

  resource :session
  root :to => "pages#home"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
