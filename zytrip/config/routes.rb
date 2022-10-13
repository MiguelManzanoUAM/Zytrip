Rails.application.routes.draw do
  get 'trips_research/survey'
  get 'trips_research/results'
  resources :reviews

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"

  resources :trips

  devise_for :users

  devise_scope :users do
    get '/users/:id/profile', to: 'users#profile', as: 'users_profile'
  end

  devise_scope :users do
    get '/users/:id/test', to: 'users#test', as: 'users_test'
  end

  root to: 'landing#home'

  namespace :admin do
    controller :admin do
      resources :trips do
        collection { post :import }
      end

      resources :agencies do
        collection { post :import }
      end

      resources :preferences do
        collection { post :import }
      end

      resources :services do
        collection { post :import }
      end

      resources :topics do
        collection { post :import }
      end
      
      resources :companies do
        collection { post :import }
      end
      
      resources :users do
        collection { post :import }
      end

      resources :reviews do
        collection { post :import }
      end

      get "/dashboards/landing", to: "dashboards#landing"
      get "/dashboards/dashboard", to: "dashboards#dashboard"
      get "/dashboards/testing", to: "dashboards#testing"
    end
  end
end
