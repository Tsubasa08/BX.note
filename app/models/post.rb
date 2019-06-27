class Post < ApplicationRecord
  has_many :post_categories
  has_many :categories, through: :post_categories
  belongs_to :user
  has_many_attached :images
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
