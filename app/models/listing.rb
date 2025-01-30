class Listing < ApplicationRecord
  include PgSearch::Model
  has_many :bookings

  belongs_to :user
  belongs_to :book

  has_one_attached :image

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :condition, presence: true
  validates :comment, presence: true

  pg_search_scope :global_search,
  against: [ :title ],
  associated_against: {
    book: [ :title, :author, :genre ]
  },
  using: {
    tsearch: { prefix: true }
  }
end
