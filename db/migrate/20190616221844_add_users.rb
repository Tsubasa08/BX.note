class AddUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :introduce, :text
    add_column :users, :image, :string
  end
end
