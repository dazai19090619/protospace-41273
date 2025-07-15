Rails.application.routes.draw do
  root "prototypes#index"

  devise_for :users

  resources :prototypes do
    resources :comments, only: [:create]
  end

  resources :users, only: [:show]
end