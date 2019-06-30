class RenameColumnsToPostsLink < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :link, :link_url
  end
end
