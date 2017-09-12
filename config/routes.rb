Rails.application.routes.draw do
  root to: 'heroes#index'
  devise_for :users, :controllers  => {sessions: 'sessions'}
  get 'about', to: 'about#index'
  get 'about/contact'

  resources :heroes, only: [:index, :show]
  resources :accounts, only: [:index, :show]
end
