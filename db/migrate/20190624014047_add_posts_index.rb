class AddPostsIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :posts, [:user_id, :created_at]
  end
end
