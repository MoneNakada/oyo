Rails.application.routes.draw do

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  get 'chat/:user_id'=>"chats#chat", as: :chat

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
    get '/new_event' => 'groups#notice_event'
    post '/new_event' => 'groups#create_event_mail'
    get '/confirm_mail' => 'groups#confirm_mail'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
