Rails.application.routes.draw do
  root to: 'heroes#index'
  devise_for :users, :controllers  => {sessions: 'sessions'}
  %w( 401 404 422 500 ).each do |code|
    get code, to: 'errors#show', code: code
  end

  get 'about', to: 'about#index'
  get 'about/contact'

  resources :heroes, only: [:index, :show]
  resources :accounts, only: [:index, :show]
end
