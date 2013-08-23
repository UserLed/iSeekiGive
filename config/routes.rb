ISeekiGive::Application.routes.draw do

  match 'terms-of-service' => 'public#terms_of_service', :as => :terms
  match 'privacy' => 'public#privacy', :as => :privacy

  resources :iseekers
  resources :igivers
  
  resources :password_resets
  
  resources :sessions

  match 'login' => 'sessions#new', :as => :login
  match 'logout' => 'sessions#destroy', :as => :logout

  match 'signup' => 'public#signup', :as => :signup
  
  match "oauth/callback" => "oauths#callback"
  match "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  get "oauths/oauth"
  get "oauths/callback"

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
