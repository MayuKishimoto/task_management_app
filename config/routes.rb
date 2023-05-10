Rails.application.routes.draw do
  get 'sessions/new'
  root 'tasks#index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :tasks do
    collection do
      post :confirm
    end
  end
end
