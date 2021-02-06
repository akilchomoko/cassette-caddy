class Genre < ApplicationRecord
  has_many :titles, dependent: :destroy
  validates :name, presence: true
end
