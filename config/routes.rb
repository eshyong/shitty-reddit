Rails.application.routes.draw do
  get 'posts/index'
  root 'posts#index'

  get '/login', to: 'users#login', as: 'user'
  post '/login', to: 'users#authenticate', as: 'login'
  get '/logout', to: 'users#logout'

  post '/posts/:id/upvote', to: 'posts#upvote', as: 'post_upvote'
  post '/posts/:id/downvote', to: 'posts#downvote', as: 'post_downvote'

  resources :posts do
    resources :comments
  end

  post '/posts/:post_id/comments/:id/upvote',
    to: 'comments#upvote', as: 'comment_upvote'

  post '/posts/:post_id/comments/:id/downvote',
    to: 'comments#downvote', as: 'comment_downvote'

  resources :users
end
