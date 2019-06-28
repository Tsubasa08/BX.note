class AddgenreToposts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :genre, :string
  end
end
