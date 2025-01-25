class Listing < ApplicationRecord
  has_many :bookings

  belongs_to :user
  belongs_to :book

  has_one_attached :image

  validates :title, presence: true
  validates :price, presence: true
  validates :condition, presence: true
  validates :comment, presence: true
end
