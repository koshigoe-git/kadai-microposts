Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "toppages#index"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  #signupのURLからusers(controller)に行き、newアクションを動かす
  get "signup" => "users#new"
  #usersコントローラーのresourceは一覧、詳細、新規、保存のコントローラーのみ
  resources :users, only: [:index, :show, :new, :create]
  #micropostsコントローラーのresourcesは作成、削除のコントローラーのみ
  resources :microposts, only: [:create, :destroy]
end