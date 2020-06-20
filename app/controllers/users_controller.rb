class UsersController < ApplicationController
  #index,showアクションの前は必ずログイン要求（Appコントローラーで定義）
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index #一覧ページでのメソッド（定義）
  #page(params[:page]).per(25):ページネーションを適用
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show #詳細ページでのメソッド（定義）
    @user = User.find(params[:id])
  end

  def new #新規ページでのメソッド（定義）
    @user = User.new
  end

  def create #保存時のメソッド（定義）
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "ユーザを登録しました"
      #処理を"users#show"のアクションへと強制的に移動させる
      #createアクション実行後に更にshowアクションが実行され、show.html.erbを呼び出す
      redirect_to @user
    else
      flash.now[:danger] = "ユーザの登録に失敗しました"
      #users/new.html.erbを表示するだけ
      #"users#new"のアクションは実行しない
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
