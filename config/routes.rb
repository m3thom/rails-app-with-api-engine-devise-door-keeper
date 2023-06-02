Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users

  mount Api::Engine, at: "api"

  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
end
