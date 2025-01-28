class Book < ApplicationRecord
  has_many :listings
  has_one_attached :image

  validates :title, presence: true
  validates :author, presence: true
end
