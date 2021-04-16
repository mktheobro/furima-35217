Rails.application.routes.draw do
  devise_for :users
  # get 'furimas/index'
  root to: "furimas#index"
  resources :furimas, only: [:index, :new, :create]

end
