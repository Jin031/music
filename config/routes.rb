Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

 scope module: :public do
  root to: "homes#top"
  resources :favorites, only: [:index]
  resources :posts, only: [:new, :index, :create, :show, :destroy]
  resource :customers, only: [:show, :edit, :update] do
   collection do
    get 'withdraw'
    patch 'unsubscribe'
   end
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
