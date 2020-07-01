class MicropostsController < ApplicationController
  #アクションの前は必ずログイン要求（Appコントローラーで定義）
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "メッセージを投稿しました。"
      redirect_to root_url
    else
      @microposts = current_user.feed_microposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = "メッセージの投稿に失敗しました"
      render "toppages/index"
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "メッセージを削除しました"
    #redirect_back: このアクションが実行されたページに戻るメソッド
    #fallback_location: root_path は、戻るべきページがない場合には root_path に戻る仕様
    redirect_back(fallback_location: root_path)
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end
  
  #correct_userメソッドは、削除しようとしているMicropost（投稿）が本当にログインユーザが所有しているものかを確認する
  #誰もが勝手に他者の投稿を削除できないようにするための対処
  #具体的には current_user.microposts.find_by(id: params[:id]) によって、
  #ログインユーザ (current_user) が持つ microposts 限定で検索しています。
  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost
      #micropost(投稿）が見つからなければ redirect_to root_url によってトップページに戻る
      redirect_to root_url
    end
  end

end