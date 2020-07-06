class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    micropost = Micropost.find(params[:micropost_id])
    #favorite(micropost)はUserModelで作成したメソッド
    current_user.favorite(micropost)
    flash[:success] = 'お気に入り登録をしました。'
    #same as "/users/:id"(users#show)
    redirect_to root_url
  end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unfavorite(micropost)
    flash[:success] = 'お気に入り登録を解除しました。'
    redirect_to root_url
  end
end
