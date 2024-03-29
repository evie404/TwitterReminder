TwitterReminder::Application.routes.draw do
  resources :rate_watchers

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
                   controllers: {omniauth_callbacks: "omniauth_callbacks"}

  root :to => 'high_voltage/pages#show', :id => 'welcome'

  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'
end
