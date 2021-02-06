class Title < ApplicationRecord
  belongs_to :genre
  has_many :rentals
  has_many :users, through: :rental
  validates :title, presence: true
end
