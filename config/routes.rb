require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :subscriptions do
    member do
      get 'pause_subscription', as: 'pause'
      get 'activate_subscription', as: 'activate'
    end
  end

  resources :verifications, only: [:edit, :update]


  get 'about' => 'welcome#about'

  root to: 'welcome#index'
  mount Sidekiq::Web, at: '/sidekiq'
end
