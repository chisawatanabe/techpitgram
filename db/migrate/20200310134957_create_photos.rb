class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
# ==========ここから追加する==========
t.string :image, null: false
t.references :post, foreign_key: true, null: false
# ==========ここまで追加する==========
      t.timestamps
    end
  end
end
