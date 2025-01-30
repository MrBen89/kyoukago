class Booking < ApplicationRecord
  enum status: [ :pending, :accepted, :rejected ]

  belongs_to :user
  belongs_to :listing



  validates :status, presence: true
  validates :total, presence: true
end
