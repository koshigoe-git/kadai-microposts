Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "toppages#index"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  #signupのURLからusers(controller)に行き、newアクションを動かす
  get "signup" => "users#new"
  #usersコントローラーのresourceは一覧、詳細、新規、保存のコントローラーのみ
  #resources内でusers#newを指定しているので、/users/newでも新規登録viewにいけるが、
  #ダサいので、上でget "signup"を追加指定している。
  resources :users, only: [:index, :show, :new, :create] do
    #中間テーブルから先にある、フォロー中のユーザ、フォローされているユーザ一覧を表示するページ
    member do
      get :followings
      get :followers
    end
  end
  #micropostsコントローラーのresourcesは作成、削除のコントローラーのみ
  #Micropost の一覧(index)はユーザに紐付いているのでtoppages#indexやusers#showで表示される。（=showは必要なし）
  resources :microposts, only: [:create, :destroy]
  #relationshipsコントローラーのresourcesは作成、削除のコントローラーのみ
  #ログインユーザがユーザをフォロー／アンフォローできるようにするルーティング
  #中間テーブルなので、indexやshowは不要。viewでフォローボタンを設置
  resources :relationships, only: [:create, :destroy]
end