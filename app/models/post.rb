class Post < ApplicationRecord
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  belongs_to :user
  has_many_attached :images
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  has_many :comment_users, through: :comments, source: :user

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :genre, presence: true
  VALID_URL_REGEX = %r{(http|https)://[\w_.!*\/')(-]+}
  validates :link_url, presence: true,
             format: { with: VALID_URL_REGEX },
             unless: :other? #ジャンルが""other"以外
  validates :book_evaluation, presence: true, if: :book?
  validate  :validate_image

  def other?
    genre == "other"
  end

  def book?
    genre == "book"
  end

  #  画像のサイズ、拡張子を判定
  def validate_image
    return unless images.attached?
    count = 1
    images.each do |image|
      if image.blob.byte_size > 5.megabytes
        image.purge
        # エラーだけ与えて保存を失敗させる
        errors.add(:images, (''))
      end
      if count > 3
        errors.add(:images, ('は3枚まで選択してください。'))
      end
      count += 1
    end
    # end
  end
  
  # 有効な画像の拡張子を判定
  def image?
    %w[iamge/jpg iamge/jpeg iamge/gif iamge/png].include?(image.blob.content_type)
  end

  # いいね
  def like(user)
    likes.create(user_id: user.id)
  end

  # いいね解除
  def unlike(user)
    likes.find_by(user_id: user.id).destroy
  end

  # 現在のユーザーがいいねしてたらtrueを返す
  def like?(user)
    like_users.include?(user)
  end

  # 現在のユーザーがいいねしてたらtrueを返す
  def comment_model?(user)
    comment_users.include?(user)
  end


end
