Rails.application.routes.draw do
  resources :transactions, except: [:edit, :update, :show]
  root 'bank#show'
end
