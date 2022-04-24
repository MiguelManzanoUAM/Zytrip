Rails.application.routes.draw do
  resources :reviews

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"

  resources :trips, only: [:index, :show]
  resources :agencies, only: [:index, :show]

  devise_for :users
  
  root to: 'landing#home'

  namespace :admin do
    controller :admin do
      resources :trips
      resources :agencies
      resources :users
      get "/dashboards/landing", to: "dashboards#landing"
      get "/dashboards/dashboard", to: "dashboards#dashboard"
    end
  end
end
