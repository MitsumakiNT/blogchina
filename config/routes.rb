Rails.application.routes.draw do
  resources :articles
  root to: 'blogs#index'
  resources :blogs, only: :index
end
