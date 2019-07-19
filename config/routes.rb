Rails.application.routes.draw do
  root 'static_pages#top'

  get    '/about',   to: 'static_pages#about'
  get    '/terms',   to: 'static_pages#terms'
  get    '/policy',  to: 'static_pages#policy'

  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get 'auth/:provider/callback', to: 'sessions#create'

  post '/select', to: 'application#select'
  get '/search_book', to: 'application#search_book'

  post   '/likes/:post_id', to: 'likes#create', as: 'like'
  delete '/likes/:post_id', to: 'likes#destroy', as: 'unlike'

  get 'search', to: 'application#search'

  resources :categories, only: [:show]

  resources :users do
    member do
      get :following, :followers,
          :likes
    end
  end
  resources :users,  only: [:new, :create, :edit, :update, :destroy]

  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :posts,          only: [:show, :create, :edit, :update, :destroy]
  resources :relationships,       only: [:create, :destroy]
  resources :comments,       only: [:create, :destroy]
end
