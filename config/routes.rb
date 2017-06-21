Rails.application.routes.draw do
  root "users#new"

  resources :sessions

  resources :users

  resources :secrets

  resources :likes

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
