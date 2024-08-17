# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  default_url_options host: 'localhost:3000'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :admin do
    resources :users
    resources :trucks
    resources :drivers
    resources :orders do
      resources :logs, only: %i[index new create]
    end
  end

  post 'admin/orders/:id', to: 'admin/orders#stop', as: :stop_admin_order

  devise_for :users
  get '/orders/:id', to: 'orders#show', as: :order
  post '/logs', to: 'logs#create', as: :logs

  # Defines the root path route ("/")
  root 'main#index'
end
