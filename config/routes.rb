Rails.application.routes.draw do
  root to: 'heroes#index'
  devise_for :users
  resources :heroes, only: [:index, :show]
end
