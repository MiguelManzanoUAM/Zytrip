Rails.application.routes.draw do
  resources :trips
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'trips#index'
  # Defines the root path route ("/")
  # root "articles#index"
end
