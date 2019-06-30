class AddColumnsToPostsLink < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :article_url, :link
    rename_column :posts, :book_title, :link_title
    add_column :posts, :link_image, :string
    add_column :posts, :link_desc, :string
  end
end
