ISeekiGive::Application.routes.draw do

  resources :phone_numbers
  match 'user_tags' => 'tags#get_user_tags'

  match 'terms-of-service' => 'public#terms_of_service', :as => :terms_of_service
  match 'privacy-policy' => 'public#privacy_policy', :as => :privacy_policy
  match 'search-users' => 'public#get_all_users_with_tags'
  match 'how-it-works' => 'public#how_it_works', :as => :how_it_works
  match 'about-us' => 'public#about_us', :as => :about_us

  resources :accounts do
    collection do
      match :settings
    end

  end

  resources :seekers do
    resources :sessions, :only => :index, :controller => "seekers/sessions" do
      collection do
        match :personal_details
        match :manage_requests
        match :session_request_reject
        match :inbox
        get :inbox
        get  :download
        match 'messages/new' => 'seekers/sessions#new_message'
        match 'messages/:uid'  => 'seekers/sessions#show_message', :as => "show_message"
        match 'inbox/:type'  => 'seekers/sessions#inbox', :as => "inbox_type"
        resources :billing_settings, :except => [:index, :destroy]
      end
    end
  end

  resources :givers do
    #resources :sessions, :only => :index, :controller => "givers/sessions" do
    #  collection do
    #
    #    match :personal_details
    #    match :manage_requests
    #    match :inbox
    #    get :inbox
    #    match 'messages/new' => 'givers/sessions#new_message'
    #    match 'messages/:uid'  => 'givers/sessions#show_message', :as => "show_message"
    #    match 'inbox/:type'  => 'givers/sessions#inbox', :as => "inbox_type"
    #    post :time_slot_save
    #    match :session_request_accept
    #    match :session_request_reject
    #    post :reject_schedule
    #    get  :get_schedule_data
    #    get  :download
    #    post :accept_schedule
    #    resources :billing_settings, :except => [:index, :destroy]
    #  end
    #end
  end

  resources :educations
  resources :skills
  resources :tags
  resources :experiences
  resources :password_resets
  resources :languages, :only => [:create, :destroy]
  
  resources :sessions

  match '/popup' => 'users#popup', :as => :popup
  match 'login' => 'sessions#new', :as => :login
  match 'logout' => 'sessions#destroy', :as => :logout

  match 'signup' => 'public#signup', :as => :signup

  match "oauth/:provider/callback" => "oauths#callback"
  match "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  post 'email_checker' => 'users#email_checker', :as => 'email_checker'

  get "oauths/oauth"
  get "oauths/callback"

  resources :connections, :only => [:new] do
    collection do
      get :callback
    end
  end

  resources :users do
    member do
      get  :activate
      get :resend_confirmation
      get :dashboard
      get :account
      get :public_profile
      get :display_calendar
      post :create_schedule
      match  :save_perspective
    end
    resources :perspectives, :only => :index, :controller => "users/perspectives" do
      collection do
        post  :add_story
        match :game_1
        match :game_2
        match :game_3
        match ':experience_id/experience' =>  'users/perspectives#experience', :as => "game_experience"
        match ':education_id/education' =>  'users/perspectives#education', :as => "game_education"
      end
    end
  end
  resources :stories do
    collection do
      get :good_stories
      get :bad_stories
      get :ugly_stories
    end
  end

  root :to => 'public#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
