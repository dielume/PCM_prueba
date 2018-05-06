Rails.application.routes.draw do
  resources :orders
  resources :kitchen, only: [:index, :update]
  resources :foods
  resources :food_orders
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
