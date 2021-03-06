class RelationshipsController < ApplicationController
  before_action :require_user_logged_in

  def create
    user = User.find(params[:follow_id])
    #5行目で定義したuserが7行目の(user)に引数として入る
    current_user.follow(user)
    flash[:success] = 'ユーザをフォローしました。'
    #same as "/users/:id"(users#show)
    redirect_to user
  end

  def destroy
    user = User.find(params[:follow_id])
    current_user.unfollow(user)
    flash[:success] = 'ユーザのフォローを解除しました。'
    redirect_to user
  end
end
