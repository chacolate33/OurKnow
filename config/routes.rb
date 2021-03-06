Rails.application.routes.draw do

  get 'signup', to: 'users#new', as: 'signup'
  post 'signup', to: 'users#create', as: 'users'
  root to: 'homes#top'
  get 'homes/myknow' => 'homes#myknow', as: 'myknow'
  
  resources :users, only: [:show, :new, :create, :index, :edit, :update] do
    get 'followers' => 'relationships#followers', as: 'followers'
    get 'followings' => 'relationships#followings', as: 'followings'
    resource :relationships, only: [:create, :destroy]
  end
  
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
  
  resources :groups do
    resources :applies, only: [:index, :create, :destroy]
    resources :knowledges, except: [:new] do
      resource :bookmarks, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end

  resources :group_users, only: [:create, :destroy]

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create', as: 'enter'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlp

end
