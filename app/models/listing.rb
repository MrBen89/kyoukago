class Listing < ApplicationRecord
  has_many :bookings

  belongs_to :user
  belongs_to :book

  has_one_attached :image

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :condition, presence: true
end
