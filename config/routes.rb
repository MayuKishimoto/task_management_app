Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  get 'sessions/new'
  root 'tasks#index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :tasks do
    collection do
      post :confirm
    end
  end
  resources :labels
  resources :labelilingss
end
