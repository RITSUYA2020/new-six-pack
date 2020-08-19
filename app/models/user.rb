class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :work_outs
  has_many :favorites

  #ユーザーがファボした投稿を直接アソシエーションで取得するため
  has_many :favorite_work_outs, through: :favorites, source: :work_out
  has_many :comments

  enum sex: { unknown: 0, male: 1, female: 2, others: 9 }

  validates :name, presence: true
  validates :email, presence: true

  # ====================自分がフォローしているユーザーとの関連 ===================================
  #フォローする側のUserから見て、フォローされる側のUserを(中間テーブルを介して)集める。なので親はfollowing_id(フォローする側)
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  #フォローしたユーザーを直接アソシエーションで取得するため
  has_many :followings, through: :active_relationships, source: :follower
  # ========================================================================================

  # ====================自分がフォローされるユーザーとの関連 ===================================
  #フォローされる側のUserから見て、フォローしてくる側のUserを(中間テーブルを介して)集める。なので親はfollower_id(フォローされる側)
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  #フォローされたユーザーを直接アソシエーションで取得するため
  has_many :followers, through: :passive_relationships, source: :following
  # ========================================================================================

  def followed_by?(user)
  # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
    passive_relationships.find_by(following_id: user.id).present?
  end

  def active_for_authentication?
    super && is_deleted == false
  end

  def self.guest
    find_or_create_by!(name: 'ゲスト', email: 'guest@example.jp') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end

  # DM
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
end
