class ToppagesController < ApplicationController
  def index
    if logged_in?
      #投稿の作成は user.microposts.build のように操作します。
      #build は Micropost.new(user: user) と同じ処理
      @micropost = current_user.microposts.build
      @microposts = current_user.microposts.order(id: :desc).page(params[:page])
    end
  end
end