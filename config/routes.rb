Rails.application.routes.draw do
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  # 管理者側のルーティング設定
  namespace :admin do
    root to: 'homes#top'
    resources :customers, only:[:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :create, :destroy, :update] do
      resources :post_comments, only: [:create, :destroy]
    end
  end
  
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  
  # 会員側のルーティング設定
  scope module: :public do
    root to: 'homes#top'
    get 'about',to: 'homes#about'
    resources :posts, only: [:index, :new, :show, :edit, :create, :destroy, :update] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :customers, only:[:show, :edit, :update] do
      member do
        get :confirm
        patch :withdraw 
        get :followers, :followeds
      end
      resource :relationships, only: [:create, :destroy]
    end
    resources :notifications, only: [:index, :destroy]
    get "search" => "searches#search"
    
  end  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
