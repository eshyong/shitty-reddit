Rails.application.routes.draw do
  get 'posts/index'
  root 'posts#index'

  get '/login', to: 'users#login', as: 'user'
  post '/login', to: 'users#authenticate', as: 'login'
  get '/logout', to: 'users#logout'

  resources :posts do
    resources :comments
  end

  resources :users
end
