Rails.application.routes.draw do
  root 'loans#new'
  resources :loans, only: [:new, :create, :show]
end
