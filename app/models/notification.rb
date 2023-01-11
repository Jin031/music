class Notification < ApplicationRecord
  belongs_to :favorite, optional: true
  belongs_to :comment, optional: true
  belongs_to :follow, optional: true
end
