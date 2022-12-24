class Post < ApplicationRecord
  belongs_to :genre
  validates :title, presence: true
  validates :text, presence: true
  has_many_attached :images
end
