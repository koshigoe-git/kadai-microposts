class User < ApplicationRecord
  #Userインスタンス（レコード）を保存する前に文字を全て小文字に変換
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    #記号の羅列がメールアドレスの正しい形式となる
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    #メルアド重複を許さないバリデーション
                    #case_sensitive: false → 大文字と小文字を区別しない
                    uniqueness: { case_sensitive: false }
  #暗号化するメソッド
  #password_digestカラムを用意し、モデルファイルにhas_secure_passwordを記述すれば、
  #ログイン認証のための準備を良しなに用意してくれる
  has_secure_password
  
  #各Userはmicroposts(ツイート)データを複数持てる
  has_many :microposts
  #各Userはrelationships(自分がフォローしているUser)データを複数持てる
  has_many :relationships
  #「自分がフォローしているUser達」
  #既存のModelクラスに対するリレーションではない（Following Modelは無い）ため、取得する情報の補足を付け足す
  #through: :relationships という記述により、has_many: relationships の結果を中間テーブルとして指定している。
  has_many :followings, through: :relationships, source: :follow
  #各Userはreverses_of_relationship(自分をフォローしているUser)データを複数持てる
  #class_name: "Relationship"は、Relationshipのクラスで参照するという意味
  has_many :reverses_of_relationship, class_name: "Relationship", foreign_key: "follow_id"
  #「自分をフォローしているUser達」
  has_many :followers, through: :reverses_of_relationship, source: :user

  #フォロー／アンフォローの実行メソッド。
  #フォロー／アンフォローとは、中間テーブル(relationships)のレコードを保存／削除すること。
  
  #フォローするためのメソッド
  def follow(other_user)
    #self(実行したUserインスタンス)がother_user(フォローしようとしている人)と同一でなければ実行
    unless self == other_user
      #もしfollow_id: other_user.idが見つかれば(find)、Relationshipモデル（クラス）のインスタンスを返す
      #もし見つからなければself.relationships.create(follow_id: other_user.id) としてフォロー関係を保存(create = build + save)することができま
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  #フォローがあればアンフォローするためのメソッド
  def unfollow(other_user)
    #relationship（フォロー）は自分のフォローしているユーザー達から検索
    relationship = self.relationships.find_by(follow_id: other_user.id)
    #もしrelationship（フォロー）していたら、削除する
    relationship.destroy if relationship
  end
  #self.followings（自分がフォローしているユーザー）によりフォローしているUser達を取得
  #include?(other_user) によって other_user が含まれていないかを確認している。
  #含まれている場合には、true を返し、含まれていない場合には、false を返す。
  def following?(other_user)
    self.followings.include?(other_user)
  end
end