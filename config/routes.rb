require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :users
  resources :subscriptions do
    member do
      get 'pause', as: 'pause'
      get 'activate', as: 'activate'
    end
  end

  get 'start', as: 'start_verification', controller: 'verifications'
  resources :verifications, only: [:edit, :update]

  root to: 'welcome#index'
  mount Sidekiq::Web, at: '/sidekiq'
  match '*path', via: :all, to: redirect('/404')
end
