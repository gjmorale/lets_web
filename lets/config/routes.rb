Rails.application.routes.draw do

  resources :accounts
  resources :users
  resources :producers do
    resources :prod_owners, only: [:create] 
    resources :events, only: [:index, :new, :create]
  end
  resources :events, only: [:update, :destroy, :show, :edit]
  resources :prod_owners, only: [:update, :destroy]

	root 'static_pages#landing'
  get '/landing', to: 'static_pages#landing'
  get '/about', to: 'static_pages#about'

  get '/signup',  to: 'accounts#new'
  post '/signup',  to: 'accounts#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

end
