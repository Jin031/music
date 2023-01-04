class Post < ApplicationRecord
  belongs_to :genre
  belongs_to :customer
  has_many_attached :images
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :text, presence: true
  validate :max_file_count

  def max_file_count
    if images.size > 4
      errors.add(:images,"too many.")
    end
  end

  def favorited_by?(customer)
   favorites.exists?(customer_id: customer.id)
  end
end
