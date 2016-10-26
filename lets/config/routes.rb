Rails.application.routes.draw do

  resources :accounts
  resources :users
  resources :producers do
    resources :prod_owners, only: [:create, :update, :destroy] 
  end

	root 'static_pages#landing'
  get '/landing', to: 'static_pages#landing'
  get '/about', to: 'static_pages#about'

  get '/signup',  to: 'accounts#new'
  post '/signup',  to: 'accounts#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

end
