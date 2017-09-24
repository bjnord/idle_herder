Rails.application.routes.draw do
  root to: 'heroes#index'
  devise_for :users, controllers: {sessions: 'sessions'}
  %w( 401 404 422 500 ).each do |code|
    get code, to: 'errors#show', code: code
  end

  get 'about', to: 'about#index'
  get 'about/contact'

  resources :heroes, only: [:index, :show]
  resources :accounts, only: [:index, :show] do
    member do
      get 'goals'
      get 'materials'
    end
  end
  resources :account_heroes, only: [:edit, :create, :update, :destroy]

  # these routes are JSON-only:
  get 'account_heroes', to: 'account_heroes#index', constraints: lambda {|request| request.format.json? }
  get 'account_heroes/:id', to: 'account_heroes#show', constraints: lambda {|request| request.format.json? }
end
