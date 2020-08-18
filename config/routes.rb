Rails.application.routes.draw do
  root 'homes#top'

  devise_for :users, controllers: {
  	sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  devise_scope :user do
    post '/users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'users/:user_id/favorites' => 'favorites#show', as: 'user_favorites'

  resources :users, except: [:index, :create, :new] do
  	resource :relationships, only: [:create, :destroy]
  	get :follows
  	get :followers
  end

  get "users/:id/confirm" => "users#confirm", as: "users_confirm"
  put "users/:id/withdraw" => "users#withdraw", as: "users_withdraw"
  get "work_outs/following" => "work_outs#following", as: "work_outs_following"
  get "work_outs/search" => "work_outs#search"
  get "contacts/new" => "contacts#new" # 入力画面
  post "contacts/confirm" => "contacts#confirm" # 確認画面
  post "contacts/thanks" => "contacts#thanks" # 送信完了画面

  resources :work_outs do
  	resource :favorites, only: [:create, :destroy]
  	resource :comments, only: [:create, :destroy]
  end
end
