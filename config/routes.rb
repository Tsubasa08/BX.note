Rails.application.routes.draw do
  # get 'password_resets/new'
  # get 'password_resets/edit'
  # get 'sessions/new'
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

  resources :categories, only: [:show]


  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users,  only: [:new, :create, :edit, :update, :destroy]

  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :posts,          only: [:create, :destroy]
end
