Rails.application.routes.draw do
  get 'users/index'
  root 'static_pages#top'

  get    '/about',   to: 'static_pages#about'
  get    '/terms',   to: 'static_pages#terms'
  get    '/policy',  to: 'static_pages#policy'
end
