class PostCategory < ApplicationRecord
  belongs_to :post
  belongs_to :category

  default_scope -> { order(category_id: :asc) }
end
