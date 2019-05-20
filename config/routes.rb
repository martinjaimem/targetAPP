Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount_devise_token_auth_for 'User', at: 'api/v1/users'
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      devise_scope :user do
        post 'users/sign_in/facebook', to: 'sessions#facebook'
      end
      get :status, to: 'api#status'
      resources :users, only: %i[show update destroy]
      resources :topics, only: :index
      resources :targets, only: %i[create update index destroy]
      resources :questions, only: :create
      resources :conversations, only: :index do
        get :messages
      end
    end
  end
end
