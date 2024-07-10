Rails.application.routes.draw do

  devise_for :users

  authenticated :user do
    # ログインしているユーザーのルート
    root to: "requests#index", as: :authenticated_root
  end

  unauthenticated do
    # ログインしていないユーザーのルート
    root to: "home#index", as: :unauthenticated_root
  end

  resources :home, only: :index
  resources :requests, only: [:index, :new, :create, :show, :destroy] do
    resources :comments, only: [:create, :destroy]
    
    member do
      patch :update_status
      patch :complete_status
    end
  end
  resources :stocks, only: [:index, :new, :create, :show]
  get 'mypage', to: 'mypage#show', as: 'mypage'

end