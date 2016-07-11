Rails.application.routes.draw do

  devise_for :users
  scope "/admin" do
    resources :users
  end

  resources :roles

  authenticated :user do
    root 'posters#index', as: :authenticated_root
  end

  # None user will be direct to log-in page
  root 'users#new'

  get 'tutorial' => 'tutorial#index', :as => "tutorial"

  # @editor w2sw2sw2s
  # @date 2016/1/27
  # @info Add sessions, users, and posters routes

  # get "signup" => "users#signup", :as => "signup"


  # @editor arfullight
  # @date   2016/2/15
  # @info   Add posters routes using resources

  resources :posters

  post "posters/search" => "posters#search", :as => "search"

  post "posters/download/:id" => "posters#download"

  namespace :admin do
  	get "/live/view" => "lives#index"
    get "/live/agenda" => "lives#agenda"
    get "/live/lh/view" => "lives#lh"
    get "/live/cm/view" => "lives#cm"
    get "/live/follow_up" => "lives#follow_up"

    # new
    get "/live/new" => "lives#new"
    post "/live" => "lives#create"

    # edit
    patch "/live/follow_up/:id" => "lives#follow_up_update", :as => "follow_up_live"
    get "/live/follow_up/:id/edit" => "lives#follow_up_edit", :as => "follow_up_edit_live"
    get "/live/lh/:id/edit" => "lives#lh_edit", :as => "lh_edit_live"
    patch "/live/cm/:id" => "lives#cm_update", :as => "cm_live"
    get "/live/cm/:id/edit" => "lives#cm_edit", :as => "cm_edit_live"
    patch "/live/lh/:id" => "lives#lh_update", :as => "lh_live"
    get "/live/:id/edit" => "lives#edit", :as => "edit_live"
    patch "/live/:id" => "lives#update"
    delete "/live/:id" => "lives#destroy"
  end

  namespace :api do
  	get "/live" => "live#index"
  	get "/test" => "live#test"
		# get "/update" => "live#update"
		get "/talk" => "live#update_talk"
		get "/school" => "live#update_school"
		get "/department" => "live#update_department"

		# get if onair
		get "/live/live_url" => "live#onair"

		# ioh.tw/live
		get "/live/live" => "live#live"
		get "/live/basic" => "live#basic_data"

		# ioh 時刻表
		patch "/live/" => "live#update_stream"
  end

  get "/lives/success" => "lives#success"
  get "lives/over" => "lives#over"

  resources :lives
  get "/live" => "lives#new"

end
