class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  # フォローしている相手を関連付ける
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  # フォロワーを関連付ける
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  # フォローしているユーザーの集合(following)の関連付け
  has_many :following, through: :active_relationships, source: :followed
  # フォロワーの集合(followers)の関連付け
  has_many :followers, through: :passive_relationships, source: :follower
  # 画像の関連付け
  has_one_attached :image
  
  validates :name, presence: true, length: {maximum: 30}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false },
            unless: :uid?
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true,
             unless: :uid?
  validates :introduce, length: {maximum: 150}, allow_nil: true
  validate  :validate_image

  attr_accessor :remember_token, :reset_token
  before_save :downcase_email, unless: :uid?
  has_secure_password

  class << self 

    # 渡された文字列のハッシュ値を返す(fixture用)
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # ランダムなトークンを返す
    def new_token
      SecureRandom.urlsafe_base64
    end

  end # self省略ここまで

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # トークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token) 
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

   # パスワード再設定の属性を設定する
   def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
   end

   # パスワード再設定のメールを送信する
   def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
   end

   # パスワード再設定の期限が切れている場合はtrueを返す
   def password_reset_expired?
    reset_sent_at < 2.hours.ago
   end

   # ユーザーをフォローする
   def follow(other_user)
    following << other_user
   end

   # ユーザーをフォロー解除する
   def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
   end

   # 現在のユーザーがフォローしてたらtrueを返す
   def following?(other_user)
    following.include?(other_user)
   end

  #  画像のサイズ、拡張子を判定
  def validate_image
    return unless image.attached?
    if image.blob.byte_size > 5.megabytes
      image.purge
      errors.add(:image, ('サイズは5MB以内にしてくだい'))
    elsif !image?
      image.purge
      errors.add(:image, ('jpg, jpeg, gif, pngを選択してください'))
    end      
    # end
  end

  # 有効な画像の拡張子を判定
  def image?
    %w[image/jpg image/jpeg image/gif image/png].include?(image.blob.content_type)
  end


  private

  # メールアドレスをすべて小文字にする
  def downcase_email
    self.email.downcase!
  end

  #データベースにユーザが存在するならユーザ取得して情報更新する 存在しないなら新しいユーザを作成する
  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]
    introduce = auth[:info][:description]
    image_url = auth[:extra][:raw_info][:profile_image_url_https]

    # データベースを更新
    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = name
      user.introduce = introduce
      user.image_url = image_url
      user.password = SecureRandom.urlsafe_base64
    end
  end

  
  
end