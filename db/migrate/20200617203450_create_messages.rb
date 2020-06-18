class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    #messages というテーブルを作成する命令
    create_table :messages do |t|
      #messages テーブルのカラム
      #投稿内容
      t.string :content
      
      #投稿時間
      t.timestamps
    end
  end
end
