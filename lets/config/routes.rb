Rails.application.routes.draw do

  resources :accounts
  resources :users do 
    member do
      post   '/admin',   to: 'admins#create'
      delete '/admin',   to: 'admins#destroy'
    end
  end
  resources :producers do
    resources :prod_owners, only: [:create] 
    resources :events, only: [:index, :new, :create]
  end
  resources :prod_owners, only: [:update, :destroy]
  resources :events, only: [:update, :destroy, :show, :edit] do
    resources :combos, only: [:create]
  end
  resources :combos, only: [:update, :destroy] do
    resources :offers, only: [:create]
  end
  resources :offers, only: [:update, :destroy]
  resources :products

	root 'static_pages#landing'
  get '/landing', to: 'static_pages#landing'
  get '/about', to: 'static_pages#about'

  get '/signup',  to: 'accounts#new'
  post '/signup',  to: 'accounts#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

end
