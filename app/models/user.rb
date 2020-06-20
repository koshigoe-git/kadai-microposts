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
  has_secure_password
end