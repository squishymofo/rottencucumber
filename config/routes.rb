Rottencucumber::Application.routes.draw do

  # get "projects/create"
  # 
  #   get "projects/index"
  # 
  #   get "projects/new"
  # 
  #   get "projects/show"

  

  get "users/index"

  get "users/new"

  get "users/create"

  get "users/show"
  
  match 'projects/create' => "projects#create"
  match 'projects/' => "projects#index"
  match 'projects/manage/:id' => "projects#manage"
  get 'projects/:id' => "projects#show"
  match 'projects/new/:org_id' => "projects#new"
  match 'tasks/new/:proj_id' => "tasks#new"
  
  match 'invitations/new/:org_id' => "invitations#new"
  
  
  resources :tasks
  resources :groups

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  
  
  resources :organizations
  resources :user_sessions
  resources :users
  match 'sign_me_up' => 'users#create', :as => :sign_me_up
  match 'create_group' => 'groups#create', :as => :create_group
  match 'edit_user' => 'users#edit', :as => :edit_user_path
  match 'inbound_sms' => 'sms#inbound_sms', :as => :inbound_sms
  match 'signin_user' => 'user_sessions#create', :as => :signin_user
  match 'register/:activation_code', :to => 'activations#new', :as => :register
  match 'activate/:id' => 'activations#create', :as => :activate
  match 'logout' => 'user_sessions#destroy', :as => :logout
  root :to => 'landing#index'
  match ':controller(/:action(/:id(.:format)))'
  
end
