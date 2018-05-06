Rails.application.routes.draw do
  resources :food_orders, only: [:index, :new, :create, :delete, :update]
  resources :orders
  resources :foods
  resources :kitchen, only: [:index, :update]
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
