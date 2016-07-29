require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  resources :users do
    resources :subscriptions, controller: 'users/subscriptions'
  end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
  mount Sidekiq::Web, at: '/sidekiq'
end
