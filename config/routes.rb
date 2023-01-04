Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

 namespace :admin do
 root to: "customers#index"
 resources :customers, only: [:index, :show, :update]
 resources :comments, only: [:index, :destroy]
 end

 scope module: :public do
  root to: "homes#top"
  resources :posts, only: [:new, :index, :create, :show, :destroy] do
  resources :favorites, only: [:index, :create, :destroy]
  resources :comments, only: [:create, :destroy]
 end
  resource :customers, only: [:show, :edit, :update] do
   collection do
    get 'withdraw'
    patch 'unsubscribe'
   end
  end
  resources :customers do
    resource :follows, only: [:create, :destroy]
    get 'followings' => 'follows#followings', as: 'followings'
    get 'followers' => 'follows#followers', as: 'followers'
  end
 end

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#new_guest'
  end

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
