Rails.application.routes.draw do
  get 'posts/index'
  root 'posts#index'

  get '/login', to: 'users#login', as: 'user'
  post '/login', to: 'users#authenticate', as: 'login'
  get '/logout', to: 'users#logout'

  post '/upvote', to: 'posts#upvote'
  post '/downvote', to: 'posts#downvote'

  resources :posts do
    resources :comments
  end

  resources :users
end
