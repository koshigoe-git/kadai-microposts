class Micropost < ApplicationRecord
  #Micropost(ツイート)はどれかのuserに属する
  #User と Micropost の一対多を表現している
  belongs_to :user
  #投稿内容(content)は必ず文字が存在する（presence: true）
  #最大文字数は255文字まで
  validates :content, presence: true, length: { maximum: 255 }
end
