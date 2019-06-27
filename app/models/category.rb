class Category < ApplicationRecord
  has_many :post_categories
  has_many :posts, through: :post_categories
  validates :name, presence: true, length: { maximum: 20 }
end
