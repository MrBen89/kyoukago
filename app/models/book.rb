include PgSearch::Model
class Book < ApplicationRecord
  has_many :listings
  has_one_attached :image

  validates :title, presence: true
  validates :author, presence: true

  pg_search_scope :search_by_genre,
  against: [ :genre ],
  using: {
    tsearch: { prefix: true } # <-- now `superman batm` will return something!
  }
end
