class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image
  has_many :posts
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :relationships, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  def follow(customer_id)
   relationships.create(followed_id: customer_id)
  end
   # フォローを外すときの処理
  def unfollow(customer_id)
   relationships.find_by(followed_id: customer_id).destroy
  end
  # フォローしているか判定
  def following?(customer)
   followings.include?(customer)
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com', name: 'たろう') do |customer|
      customer.password = SecureRandom.urlsafe_base64
    end
  end

  def guest?
    email == 'guest@example.com'
  end

  def create_notification_follow!(current_customer)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_customer.id, customer_id, id, 'favorite'])
  end
end






