Rails.application.routes.draw do
  get 'products/index'
  get 'products/search'
  devise_for :users
  root to: "items#index"
  resources :items do
    resources :orders, only: [:index, :create]
  end
  
end
