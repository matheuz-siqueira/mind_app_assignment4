Rails.application.routes.draw do
  resources :tags, only: %i(new create destroy)
  
  devise_for :users
  get 'home/index'
  
  resources :contents
  root "home#index"
end
