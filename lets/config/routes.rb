Rails.application.routes.draw do

  get 'users/show'

  get 'users/update'

  get 'users/edit'

  resources :accounts
  resources :users

	root 'static_pages#landing'

  get '/landing', to: 'static_pages#landing'

  get '/about', to: 'static_pages#about'

  get '/signup',  to: 'accounts#new'

  post '/signup',  to: 'accounts#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
