Rails.application.routes.draw do
  get '/', to: 'landing#index'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login'
  get '/dashboard', to: 'users#show'
  post '/logout', to: 'users#logout'

  match 'register', via: :get, to: 'users#new'
  resources :users, only: [:create] do
    resources :discover, only: [:index]
    resources :movies, only: [:index, :show] do
      resources :viewing_party, only: [:new, :create]
    end 
  end
end
