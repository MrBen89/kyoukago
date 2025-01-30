class Booking < ApplicationRecord
  enum status: [ :pending, :accepted, :rejected ]

  belongs_to :user
  belongs_to :listing



  validates :start_date, :end_date, :total_price, presence: true
  validates :status, presence: true
end
