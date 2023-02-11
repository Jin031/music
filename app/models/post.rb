class Post < ApplicationRecord
  belongs_to :genre
  belongs_to :customer
  has_many_attached :images
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :text, presence: true
  validate :max_file_count
  validate :min_file_count

  def max_file_count
    if images.size > 4
      errors.add(:images,"画像が多いです")
    end
  end

  def min_file_count
    if images.size == 0
      errors.add(:images,"画像が選択されていません。")
    end
  end

  def favorited_by?(customer)
   favorites.exists?(customer_id: customer.id)
  end

  def create_notification_favorite!(current_customer)
      # すでいいねの通知があるか?
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_customer.id, customer_id, id, 'favorite'])
      # ない場合いいねの通知作成
      if temp.blank?
        notification = current_customer.active_notifications.new(
          post_id: id,
          visited_id: customer_id,
          action: 'favorite'
        )
      #自分の投稿だったら通知済み
      if notification.visitor_id == notification.visited_id
         notification.checked = true
      end
      notification.save if notification.valid?
      end
  end

  def create_notification_comment!(current_customer)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_customer.id, customer_id, id, 'comment'])
    if temp.blank?
      notification = current_customer.active_notifications.new(
        post_id: id,
        visited_id: customer_id,
        action: 'comment'
      )

      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end

