class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true, length: { maximum: 140 }

  default_scope -> { order(created_at: :asc) }
end
