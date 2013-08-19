ISeekiGive::Application.routes.draw do
  
  get "password_resets/create"

  get "password_resets/edit"

  get "password_resets/update"

  get "oauths/oauth"

  get "oauths/callback"

  resources :sessions
  resources :users
  resources :iseekers
  resources :igivers
  match 'login' => 'sessions#new', :as => :login
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'signup' => 'public#signup', :as => :signup
  match 'signin' => 'public#signin', :as => :signin

  match "oauth/callback" => "oauths#callback"
  match "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider


  root :to => 'public#index'

end
