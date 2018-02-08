Rails.application.routes.draw do

  post '/transactions/withdrawals', to: 'transactions#withdraw'
  post '/transactions/credits', to: 'transactions#credit'
  get '/users/fingerprints', to: 'users#list_fingerprints'

  resources :users, :accounts
end