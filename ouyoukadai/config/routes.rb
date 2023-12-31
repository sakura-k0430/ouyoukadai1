Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "homes#top"
  get 'home/about' => 'homes#about', as: 'about'
  get '/search', to: 'searches#search'

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:index,:show,:edit,:update]do
    get "search_form" => "users#search_form"
    member do
      get :follows, :followers
    end
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followings', as: 'followers'
  end
  
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end