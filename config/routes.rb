Rails.application.routes.draw do
  resources :orders, only: [:index, :new, :create, :delete, :update]
  resources :kitchen, only: [:index, :update]
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
