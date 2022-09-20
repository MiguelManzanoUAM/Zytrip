Rails.application.routes.draw do
  get 'trips_research/survey'
  get 'trips_research/results'
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
      resources :trips do
        collection { post :import }
      end

      resources :agencies do
        collection { post :import }
      end
      
      resources :users

      get "/dashboards/landing", to: "dashboards#landing"
      get "/dashboards/dashboard", to: "dashboards#dashboard"
    end
  end
end
