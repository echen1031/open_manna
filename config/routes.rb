Rails.application.routes.draw do
  resources :subscriptions

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
