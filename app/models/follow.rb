class Follow < ApplicationRecord
  belongs_to :follower, class_name: "Customer"
  belongs_to :followed, class_name: "Customer"
  has_many :notifications, dependent: :destroy


  def create_notification_follow!
    customer = Customer.find(followed_id)
    temp = Notification.where(["follow_id = ? and action = ? ", id, 'follow'])
    if temp.blank?
      notification = customer.active_notifications.new(
        follow_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

end
