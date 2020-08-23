class WorkOut < ApplicationRecord
  attachment :before_image
  attachment :after_image

  has_many :favorites
  #投稿をファボしたユーザーを直接アソシエーションで取得するため
  has_many :favorite_users, through: :favorites, source: :user
  belongs_to :user
  has_many :comments, dependent: :destroy

  enum muscle_group: { abs_core: 0, arms_shoulders: 1, gmax_legs: 2 }
  enum effect: { too_easy: 1, very_easy: 2, somewhat_easy: 3, just_right: 4, rather_tight: 5, tight: 6, very_tight: 7, too_tight: 8, my_limit: 9 }
  enum place: { gym: 0, home: 1, outdoors: 2 }

  validates :time, presence: true

  # 通知
  has_many :notifications, dependent: :destroy

  #ユーザーがツイートをお気に入りしたかどうかの判定メソッド
  def favorited_by?(user)
  	favorites.where(user_id: user.id).exists?
  end

  acts_as_taggable
  # acts_as_taggable_on :tags　と同じ意味のエイリアス
  # tags のなかにIDやら名前などが入る。イメージ的には親情報。

  def search(word)
    WorkOut.where("name LIKE ?", "%#{word}%")
  end

  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      work_out_id: id,
      visited_id: user_id,
      action: "favorite"
    )
    notification.save if notification.valid?
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(work_out_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      work_out_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
