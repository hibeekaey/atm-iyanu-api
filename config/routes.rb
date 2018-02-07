Rails.application.routes.draw do

  post '/transactions/withdrawals', to: 'transactions#withdraw'
  post '/transactions/credits', to: 'transactions#credit'

  resources :users, :accounts
end