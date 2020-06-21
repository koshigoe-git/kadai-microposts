class Micropost < ApplicationRecord
  #Micropost(ツイート)はどれかのuserに属する
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 255 }
end
