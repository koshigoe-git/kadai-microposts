class CreateMicroposts < ActiveRecord::Migration[5.2]
  def change
    create_table :microposts do |t|
      t.string :content
      #t.references（参照） :userはDB上では、user_idカラムとして存在し、
      #そこに各Userのidが保存されます。（各Userに番号が振られる）
      #Micropostを発言したユーザを特定することが可能。
      #foreign_keyは外部キー制約（間違ったデータの保存をしづらくする）
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
