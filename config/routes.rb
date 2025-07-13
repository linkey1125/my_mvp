Rails.application.routes.draw do
  get "reviews/create"
  get "reviews/destroy"
  root "posts#index" # 投稿一覧をトップページに設定

  resources :posts do
    collection do
      get :search # 検索機能の追加
      get :autocomplete
      get :ranking
    end
    resources :reviews, only: [:create, :destroy]
  end

  resources :users, only: [ :new, :create, :show, :edit, :update ]
  get "signup", to: "users#new", as: "signup"

  resources :sessions, only: [ :new, :create, :destroy ]
  get "login", to: "sessions#new", as: "login"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: "logout"

  resources :passwords, only: [ :new, :create, :edit, :update ]
  get "password/reset", to: "passwords#new", as: "password_reset"
  post "password/reset", to: "passwords#create"
  get "password/reset/edit", to: "passwords#edit", as: "edit_password_reset"
  patch "password/reset", to: "passwords#update"

  resources :favorites, only: [ :create, :destroy, :index ]


  get "mypage", to: "users#show"
  get "/terms", to: "static_pages#terms"
  get "/privacy", to: "static_pages#privacy"
end
