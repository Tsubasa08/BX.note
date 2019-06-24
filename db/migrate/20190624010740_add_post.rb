class AddPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :image, :string
    add_column :posts, :category, :string
    add_column :posts, :article_url, :string
    add_column :posts, :book_title, :string
    add_column :posts, :book_evaluation, :integer
  end
end
