Rails.application.routes.draw do
  root 'home#top'
  get '/about' => 'home#about'

  # ユーザー
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
  # 検索
  get 'users/search' => 'users#search', as: 'users_search'

  resources :users, except: %i[create new] do
    # Todo
    resources :todos, only: %i[create destroy]

    resource :relationships, only: %i[create destroy]
    get :follows
    get :followers
  end

  get 'users/:id/confirm' => 'users#confirm', as: 'users_confirm'
  put 'users/:id/withdraw' => 'users#withdraw', as: 'users_withdraw'
  get 'work_outs/following' => 'work_outs#following', as: 'work_outs_following'
  get 'work_outs/search' => 'work_outs#search'
  get 'contacts/new' => 'contacts#new' # 入力画面
  post 'contacts/confirm' => 'contacts#confirm' # 確認画面
  post 'contacts/thanks' => 'contacts#thanks' # 送信完了画面

  resources :work_outs do
    resource :favorites, only: %i[create destroy]
    resource :comments, only: %i[create destroy]
  end

  resources :messages, only: [:create]
  resources :rooms, only: %i[create show]

  # 通知
  # delete 'notifications/destroy_all' => 'notifications#destroy_all'
  # resources :notifications, only: :index

  # 管理者
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations',
    passwords: 'admins/passwords'
  }

  devise_scope :admin do
    post '/admins/guest_sign_in', to: 'admins/sessions#new_guest'
    get '/admins/graph', to: 'admins/users#graph'
    get '/admins/rank', to: 'admins/users#rank'
  end

  namespace :admins do
    resources :users, only: %i[index edit update]
  end
end
