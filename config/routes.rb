Rails.application.routes.draw do
  get '/api/v1/status', to: 'application#status'
  mount_devise_token_auth_for 'User', at: 'api/v1/users'
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[show update destroy], defaults: { format: :json }
    end
  end
end
