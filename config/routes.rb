require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :users
  resources :verifications, only: [:edit, :update]
  resources :subscriptions, only: [:index, :new, :edit, :update, :create, :destroy] do
    member do
      get 'pause', as: 'pause'
      get 'activate', as: 'activate'
    end
  end
  post '/message_status', to: 'inbound_sms#message_status_webhook'
  post '/inbound_message', to: 'inbound_sms#inbound_message_webhook'
  post '/create-checkout-session', to: 'donations#checkout_session'

  get 'start', as: 'start_verification', controller: 'verifications'

  get 'donate', to: 'donations#new', as: 'donate'
  resources :donations, only: [:create] do
  end

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web, at: '/sidekiq'
  end

  root to: 'welcome#index'
  match '*path', via: :all, to: redirect('/404')
  post '/stripe/callbacks', to: 'stripe_callbacks#callbacks'
end
