ISeekiGive::Application.routes.draw do


  match 'dashboard' => 'dashboard#index', :as => :dashboard
  match 'profile' => 'dashboard#profile', :as => :profile
  match 'perspectives' => 'dashboard#perspectives', :as => :perspectives
  match 'experience-and-education' => 'dashboard#experience_and_education', :as => :experience_and_education


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

  resources :seekers
  
  resources :givers

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
