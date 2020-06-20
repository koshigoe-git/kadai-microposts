Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "toppages#index"
  #signupのURLからusers(controller)に行き、newアクションを動かす
  get "signup" => "users#new"
  #resourceは一覧、詳細、新規、保存のコントローラーのみ
  resources :users, only: [:index, :show, :new, :create]
end