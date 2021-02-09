class Title < ApplicationRecord
  belongs_to :genre
  has_many :rentals, dependent: :destroy
  has_many :users, through: :rental
  validates :title, presence: true
end
