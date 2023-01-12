class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  has_many :notifications, dependent: :destroy

  def create_notification_favorite!(current_customer)
    temp = Notification.where(["favorite_id = ? and action = ? ", id, 'favorite'])
    if temp.blank?
      notification = customer.active_notifications.new(
        favorite_id: id,
        action: 'favorite'

      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.customer_id == current_customer.id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end
