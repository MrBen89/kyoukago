class Book < ApplicationRecord
  has_many :listings

  validates :title, presence: true
  validates :author, presence: true
end
