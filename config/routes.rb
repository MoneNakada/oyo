Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  get 'chat/:user_id'=>"chats#chat", as: :chat
  get '/search', to: 'searches#search'
   post 'search_by_tagname' => 'books#search_by_tag'

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create]
  end
  resources :book_comments, only: [:destroy]

  resources :users, only: [:index,:show,:edit,:update] do
    member do
      get 'followers'
      get 'followings'
    end
    resource :relationships, only: [:create, :destroy]
    resources :chats, only: [:create]
    get "search", to: "users#search"
  end
  
  resources :groups do    #ここ！
    get "join" => "groups#join"
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
