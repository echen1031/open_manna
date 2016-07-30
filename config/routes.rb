require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :subscriptions

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
  mount Sidekiq::Web, at: '/sidekiq'
end
