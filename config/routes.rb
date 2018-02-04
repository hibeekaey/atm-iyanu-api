Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post '/transactions/withdrawals', to: 'transactions#withdraw'
  put '/transactions/credits', to: 'transactions#credit'

  resources :users, :accounts
end