module SessionsHelper

  #ユーザーをidから検索する
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    !!current_user
  end
end

  #def current_userは、現在ログインしているユーザを取得するメソッド
  #@current_user ||= User.find_by(id: session[:user_id]) は、
  #@current_user に既に現在のログインユーザが代入されていたら何もしない
  #ログインユーザが代入されていなかったら User.find(...) からログインユーザを取得し、
  #@current_user に代入する処理を1行で書いたものです。つまり下記コードと同じ処理を短く書いただけです。
  
  #参考コード
  #if @current_user
  #return @current_user
#else
  #@current_user = User.find_by(id: session[:user_id])
  #return @current_user
#end
