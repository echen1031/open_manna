require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :users
  resources :verifications, only: [:edit, :update]
  resources :subscriptions do
    member do
      get 'pause', as: 'pause'
      get 'activate', as: 'activate'
    end
  end

  get 'start', as: 'start_verification', controller: 'verifications'

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web, at: '/sidekiq'
  end

  root to: 'welcome#index'
  match '*path', via: :all, to: redirect('/404')
end
