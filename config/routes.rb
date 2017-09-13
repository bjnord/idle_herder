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

  # these routes are JSON-only:
  get 'account_heroes', to: 'account_heroes#index', as: 'account_heroes', constraints: lambda {|request| request.format.json? }
  get 'account_heroes/:id', to: 'account_heroes#show', as: 'account_hero', constraints: lambda {|request| request.format.json? }
  post 'account_heroes', to: 'account_heroes#create', constraints: lambda {|request| request.format.json? }
end
