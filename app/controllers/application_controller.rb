class ApplicationController < ActionController::Base
  
  include SessionsHelper
#ユーザのindex, show はログインしていないユーザに見せたくないので、
#"users#index", "users#show"のアクションには必ず事前にログイン認証を
#確認するような処理を追加

#sessionsやMicropostsController でもログイン確認をしたいので、
#全てのControllerで使用できるようにApplicationControllerで
#require_user_logged_in(userのログイン要求)を定義する  
 
  private
  
  def require_user_logged_in
    #unless:もし〜しなければ(ifの反対の意味、false時に実行)
    unless logged_in?
      #login_urlでログインページへ移動
      redirect_to login_url
    end
  end
  
  #this method is used to count to numbers of microposts, followings,followers
  #displayed to view page
  #ApplicationControllerに実装することで全てのコントローラでcounts(user)が使用可。
  def counts(user)
    @count_microposts = user.microposts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
  end
end