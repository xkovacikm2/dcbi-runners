Rails.application.routes.draw do
  devise_for :users

  root 'runs#index'

  resources :runs, only: [:index, :update, :create, :destroy]
end
