module SessionsHelper
  #現在のユーザーメソッド
  #ユーザーをidから検索する
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    !!current_user
  end
end