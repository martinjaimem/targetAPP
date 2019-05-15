Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount_devise_token_auth_for 'User', at: 'api/v1/users'
  namespace :api do
    namespace :v1 do
      get :status, to: 'api#status'
      resources :users, only: %i[show update destroy]
      resources :topics, only: %i[index]
      resources :questions, only: %i[create]
    end
  end
end
