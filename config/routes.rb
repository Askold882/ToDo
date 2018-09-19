Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create]
  get '/', to: 'tasks#index'
  get '/confirm_email', to: 'users#update'
  get '/log_out', to: 'sessions#destroy'
  resources :sessions
  resources :tasks
  namespace :api do
    get '/confirm_email', to: 'users#update'
    get '/log_out', to: 'sessions#destroy'
    resources :sessions
    resources :tasks
    end
end
