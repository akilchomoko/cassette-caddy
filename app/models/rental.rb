class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :title
  validates :user_id, presence: true
  validates :title_id, presence: true
  validates_uniqueness_of :title_id, scope: [:user_id, :start_date]

  def self.already_rented(title, user)
    # Rental.find_by(user_id: user.id, title_id: title.id, end_date: nil)
    user.rentals.where(title: title, end_date: nil).first
  end
end
