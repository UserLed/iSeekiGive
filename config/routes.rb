ISeekiGive::Application.routes.draw do

  match 'profile/photos' => 'profile#photos', :as => :profile_photos
  match 'profile/your-keywords-tags' => 'profile#your_keywords_tags', :as => :your_keywords_tags
  match 'profile/experience-and-education' => 'profile#experience_and_education', :as => :experience_and_education
  match 'profile' => 'profile#index', :as => :profile
    
  match 'dashboard' => 'dashboard#index', :as => :dashboard

  resources :phone_numbers
  match 'user_tags' => 'tags#get_user_tags'

  match 'search-users' => 'public#get_all_users_with_tags'
  

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
    end
  end

  resources :stories do
    collection do
      get :good_stories
      get :bad_stories
      get :ugly_stories
    end
  end

  resources :perspectives do
    member do
      get :save
    end
  end

  match 'locations'      => "public#locations"

  match 'popup' => 'users#popup', :as => :popup

  match "oauth/:provider/callback" => "oauths#callback"
  match "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  get "oauths/oauth"
  get "oauths/callback"

  match 'logout'  => 'sessions#destroy',  :as => :logout
  match 'login'   => 'sessions#new',      :as => :login
  match 'signup'  => 'public#signup',         :as => :signup

  post 'email_checker'      => 'users#email_checker',      :as => 'email_checker'
  
  match 'terms-of-service'  => 'public#terms_of_service',  :as => :terms_of_service
  match 'privacy-policy'    => 'public#privacy_policy',    :as => :privacy_policy
  match 'about-us'          => 'public#about_us',          :as => :about_us
  match 'how-it-works'      => 'public#how_it_works',      :as => :how_it_works

  root :to => 'public#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
