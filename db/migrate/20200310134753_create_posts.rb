class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
       # ==========ここから追加する==========
       t.string :caption
       t.references :user, foreign_key: true, null: false
       # ==========ここまで追加する==========

      t.timestamps
    end
  end
end
