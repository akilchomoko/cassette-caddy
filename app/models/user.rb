class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable :recoverable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :rentals, dependent: :destroy

  def address
    [address1, address2, postcode].compact.join(', ')
  end

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address1?
end
