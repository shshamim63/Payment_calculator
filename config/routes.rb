Rails.application.routes.draw do
  root 'payment#index'
  get 'calculate_payment', to: "payment#calculate"
end
