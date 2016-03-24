Rails.application.routes.draw do

  devise_for :users
  scope "/admin" do
    resources :users
  end
  
  resources :roles

  

  # @editor w2sw2sw2s
  # @date 2016/1/27
  # @info Add sessions, users, and posters routes

  # get "signup" => "users#signup", :as => "signup"

  # resources :users, only: [:create]

  # get "login" => "users#login", :as => "login"

  # post "create_login_session" => "users#create_login_session"

  # delete "logout" => "users#logout", :as => "logout"

  # @editor arfullight
  # @date   2016/2/15
  # @info   Add posters routes using resources

  root 'posters#index'

  resources :posters

  post "posters/search" => "posters#search", :as => "search"

  post "posters/download/:id" => "posters#download"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
