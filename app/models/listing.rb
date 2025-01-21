class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :title, presence: true
  validates :price, presence: true
  validates :condition, presence: true
  validates :comment, presence: true
end
