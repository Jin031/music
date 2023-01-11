class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  has_many :notifications, dependent: :destroy

  def create_notification!(current_customer)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and favorite_id = ? ", current_customer.id, customer_id, id])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_customer.active_notifications.new(
        favorite_id: id,
        visited_id: customer_id,

      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end
