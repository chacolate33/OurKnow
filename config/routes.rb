Rails.application.routes.draw do
  get 'homes/home'
  # get 'sessions/new'
  # get 'sessions/create'
  # get 'sessions/destroy'
  get 'signup', to: 'users#new', as: 'signup'
  post 'signin', to: 'users#create', as: 'users'
  root to: 'homes#top'
  resources :users, only: [:show, :new, :create]
  
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create', as: 'enter'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlp
  
end
