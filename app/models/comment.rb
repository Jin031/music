class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  has_many :notifications, dependent: :destroy

  def create_notification_comment!(current_customer)
    customer = Customer.find(self.post.customer_id)
    save_notification_comment!(customer, id, current_customer)
  end

  def save_notification_comment!(customer, comment_id, current_customer)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = customer.active_notifications.new(
      comment_id: comment_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.customer_id == current_customer
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
