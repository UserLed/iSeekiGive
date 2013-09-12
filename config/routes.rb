ISeekiGive::Application.routes.draw do

  resources :phone_numbers

  match 'terms-of-service' => 'public#terms_of_service', :as => :terms
  match 'privacy' => 'public#privacy', :as => :privacy

  resources :seekers do
    member do
      get :dashboard
    end
  end

  resources :givers do
    member do
      get :dashboard
    end
    resources :perspectives, :only => :index, :controller => "givers/perspectives" do
      collection do
        match :game_1
        match :game_2
        post :save_game_tag
        match ':experience_id/experience' =>  'givers/perspectives#open_single_experience', :as => "single_experience"
      end
    end
  end

  resources :educations
  resources :skills
  resources :experiences
  
  resources :password_resets
  
  resources :sessions

  match '/popup' => 'users#popup', :as => :popup
  match 'login' => 'sessions#new', :as => :login
  match 'logout' => 'sessions#destroy', :as => :logout

  match 'signup' => 'public#signup', :as => :signup
  
  match "oauth/:provider/callback" => "oauths#callback"
  match "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

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
    end
  end

  root :to => 'public#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
