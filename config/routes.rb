Rails.application.routes.draw do
  root to: 'heroes#index'
  devise_for :users
  get 'about', to: 'about#index'
  get 'about/contact'

  resources :heroes, only: [:index, :show]
end
