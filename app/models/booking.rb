class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing



  validates :start_date, :end_date, :total_price, presence: true
  validates :status, presence: true
  validates :total, presence: true
end
