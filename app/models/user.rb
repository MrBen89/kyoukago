class User < ApplicationRecord
  has_many :bookings
  has_many :listings
  has_one_attached :profile_image
  has_many :bookings_as_owner, through: :listings, source: :bookings


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
