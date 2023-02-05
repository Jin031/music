class Follow < ApplicationRecord
  belongs_to :follower, class_name: "Customer"
  belongs_to :followed, class_name: "Customer"
  has_many :notifications, dependent: :destroy

    def create_notification_follow!
      temp = Notification.where(["visitor_id = ? and visited_id = ? and follow_id = ? and action = ? ", follower_id, followed_id, id, 'follow'])
        if temp.blank?
          notification = Notification.new(
          follow_id: id,
          visitor_id: follower_id,
          visited_id: followed_id,
          action: 'follow'
        )
          notification.save if notification.valid?
        end
    end
end
