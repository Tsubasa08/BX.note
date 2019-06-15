Rails.application.routes.draw do
  root 'static_pages#top'

  get    '/about',   to: 'static_pages#about'
  get    '/terms',   to: 'static_pages#terms'
  get    '/policy',  to: 'static_pages#policy'

  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'

  resources :users do
    member do
      get :following, :followers
    end
  end
end
