class UsersController < ApplicationController
  #index,showアクションの前は必ずログイン要求（Appコントローラーで定義）
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers]
  
  def index #一覧ページでのメソッド（定義）
  #page(params[:page]).per(25):ページネーションを適用
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show #詳細ページでのメソッド（定義）
    #DBのidからUserを検索し、@user変数に代入
    @user = User.find(params[:id])
    #@userのmicroposts(投稿内容)を降順（最新順）に表示、多くなったらページネーション
    @microposts = @user.microposts.order(id: :desc).page(params[:page])
    #this is the method to count(numbers of microposts, followings,followers)
    #it's written on application_controller.rb
    counts(@user)
  end
  
  def new #新規ページでのメソッド（定義）
    @user = User.new
  end

  def create #保存時のメソッド（定義）
    #privateで作成した(user_params)に従い、name,email.password等の新規インスタンス作成
    @user = User.new(user_params)
    
    #先程作成した@user(新規インスタンス)が無事saveできたら、
    if @user.save
      flash[:success] = "ユーザを登録しました"
      #処理を"users#show"のアクションへと強制的に移動させる
      #createアクション実行後に更にusers#showアクションが実行され、show.html.erbを呼び出す
      #redirect_toの@userは省略形,本来は"/users/show(@user =表示したいUserクラスのインスタンス)" or user_path(@user)となっている
      redirect_to @user
    else
      flash.now[:danger] = "ユーザの登録に失敗しました"
      #users/new.html.erbを表示するだけ
      #"users#new"のアクションは実行しない
      render :new
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
