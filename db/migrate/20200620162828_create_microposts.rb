class CreateMicroposts < ActiveRecord::Migration[5.2]
  def change
    create_table :microposts do |t|
      t.string :content
      #t.references :userは謎,foreign_keyは外部キー制約（間違ったデータの保存をしづらくする）
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
