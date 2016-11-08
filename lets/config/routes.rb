Rails.application.routes.draw do

  resources :accounts
  resources :users do 
    member do
      post   '/admin',   to: 'admins#create'
      delete '/admin',   to: 'admins#destroy'
    end
    resources :purchases, only: [:index]
  end
  resources :producers do
    resources :prod_owners, only: [:create] 
    resources :events, only: [:index, :new, :create]
  end
  resources :prod_owners, only: [:update, :destroy]
  resources :events, only: [:update, :destroy, :show, :index, :edit] do
    resources :combos, only: [:new, :create]
  end
  resources :combos, only: [:show, :update, :destroy] do
    resources :offers, only: [:create]
    resources :purchases, only: [:create]
  end
  resources :offers, only: [:update, :destroy]
  resources :purchases, only: [:destroy, :show]
  resources :products

	root 'static_pages#landing'
  get '/about', to: 'static_pages#about'

  get '/signup',  to: 'accounts#new'
  post '/signup',  to: 'accounts#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

end
