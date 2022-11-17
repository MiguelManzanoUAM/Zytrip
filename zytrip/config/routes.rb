Rails.application.routes.draw do
  resources :additional_informations
  resources :surveys
  get 'trips_research/preferences_poll', to: "trips_research#preferences_poll", as: "preferences_poll"
  get 'trips_research/results'
  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"

  resources :trips
  resources :preferences, only: [:new, :create]
  resources :topics, only: [:new, :create]
  resources :companies, only: [:new, :create]
  resources :services, only: [:new, :create]
  resources :reviews, only: [:new, :create]
  resources :surveys, only: [:new, :create]
  resources :additional_informations, only: [:new, :create]

  resources :friendships, only: [:destroy]
  get "/friendships/add_friend", to: "friendships#add_friend"
  get "/friendships/delete_friend", to: "friendships#delete_friend"

  get "/policies/privacy", to: "policies#privacy", as: 'privacy'
  get "/policies/terms_of_use", to: "policies#terms_of_use", as: 'terms_of_use'

  devise_for :users

  devise_scope :users do
    get '/users/:id/profile', to: 'users#profile', as: 'users_profile'
    get '/users/:id/update_aditional_info', to: 'users#update_aditional_info', as: 'users_profile_aditional_info'
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

      resources :surveys do
        collection { post :import }
      end

      resources :friendships, only: [:new, :create, :index, :destroy] do
        collection { post :import }
      end

      resources :additional_informations do
        collection { post :import}
      end

      get "/dashboards/dashboard", to: "dashboards#dashboard"
      get "/dashboards/testing", to: "dashboards#testing"
    end
  end
end
