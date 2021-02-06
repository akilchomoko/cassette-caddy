class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :title
  validates :user_id, presence: true
  validates :title_id, presence: true
  validates_uniqueness_of :title_id, scope: [:user_id, :start_date]
end
