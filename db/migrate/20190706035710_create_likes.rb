class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps
      t.index :post_id
      t.index :user_id
      t.index [:post_id, :user_id], unique: true
    end
  end
end
