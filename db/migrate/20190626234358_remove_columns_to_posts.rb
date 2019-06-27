class RemoveColumnsToPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :category, :string
  end
end
