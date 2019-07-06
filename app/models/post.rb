class Post < ApplicationRecord
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  belongs_to :user
  has_many_attached :images
  has_many :likes, dependent: :destroy
  
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :genre, presence: true
  VALID_URL_REGEX = %r{(http|https)://[\w_.!*\/')(-]+}
  validates :link_url, presence: true,
             format: { with: VALID_URL_REGEX },
             unless: :other? #ジャンルが""other"以外
  validate  :validate_image

  def other?
    genre == "other"
  end

  #  画像のサイズ、拡張子を判定
  def validate_image
    return unless images.attached?
    images.each do |image|
      if image.blob.byte_size > 5.megabytes
        image.purge
        # エラーだけ与えて保存を失敗させる
        errors.add(:images, (''))
      # elsif !image?
      #   image.purge
      #   errors.add(:images, (''))
      end   
    end
    # end
  end
  
  # 有効な画像の拡張子を判定
  def image?
    %w[iamge/jpg iamge/jpeg iamge/gif iamge/png].include?(image.blob.content_type)
  end


end
