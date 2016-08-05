Rails.application.routes.draw do
  root to: 'static_pages#home'
  get    'signup', to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users
  resources :users do
    member do
      get 'followings'
      get 'followers'
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts do
    resource :retweets, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
end
