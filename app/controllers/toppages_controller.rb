class ToppagesController < ApplicationController
  def index
    if logged_in?
      #投稿の作成は user.microposts.build のように操作します。
      #build は Micropost.new(user: user名) と同じ処理
      #現在のuserが新しくmicropost(ツイート）作成する時の設定（新しいインスタンス生成）
      @micropost = current_user.microposts.build
      
      #現在のuserのmicroposts（全ツイート）を降順で取得
      @microposts = current_user.microposts.order(id: :desc).page(params[:page])
    end
  end
end