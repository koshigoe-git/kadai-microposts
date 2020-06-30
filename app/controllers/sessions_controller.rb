#login時に関するコントローラー
class SessionsController < ApplicationController
  def new
  end

  def create
    #login時入力したemail[:session]とsignup時入力したemail[:email]を小文字化(.downcase)
    #同一であるか確かめる
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = "ログインに成功しました。"
      #ログインに成功すれば redirect_to @userで@userのusers#showへとリダイレクト
      #redirect_toの@userは省略形,本来は"/users/show(@user =表示したいUserクラスのインスタンス)" or user_path(@user)となっている
      redirect_to @user
    else
      flash[:danger] = "ログインに失敗しました。"
      #失敗すれば render :new により sessions/new.html.erb を再表示する
      render :new
    end
  end

  def destroy
    #ログインで保存した ession[:user_id] = @user.id を削除すれば良い
    #削除には nil を代入する
    session[:user_id] = nil
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end
  
  private
  
  #createアクションで、仮定していた login(email, passsword)をprivateで定義
  def login(email, password)
    #@user = User.find_by(email: 入力フォームのemail) で、入力フォームのemailと同じメールアドレスを持つユーザを検索し@userへ代入
    @user = User.find_by(email: email)
    #if @user によって、@userが存在するかを確認
    #User.find_by(email: email) によって見つからなかった場合は、@userにnilが代入されて、if文によってfalse扱いされる
    #次に @user のパスワードが合っているか、@user.authenticate(password) で確認
    if @user && @user.authenticate(password)
      #ログイン成功
      #最後にsession[:user_id] = @user.id によって、ブラウザにはCookieとして、サーバにはSessionとして、
      #ログイン状態が維持される
      session[:user_id] = @user.id
      return true
    else
      #ログイン失敗
      return false
    end
  end
end