Rails.application.routes.draw do
  root 'posts#index' # 投稿一覧をトップページに設定

  resources :posts, only: [:index, :new, :create]

  resources :users, only: [:new, :create, :show, :edit, :update]
  get 'signup', to: 'users#new', as: 'signup'

  resources :sessions, only: [:new, :create, :destroy]
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  resources :passwords, only: [:new, :create, :edit, :update]

  resources :favorites, only: [:create, :destroy]
  resources :items, only: [:index, :show]
  post 'items/:id/toggle_favorite', to: 'items#toggle_favorite', as: 'toggle_favorite'

  get 'mypage', to: 'users#show'
end
