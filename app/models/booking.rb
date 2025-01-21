class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true
  validates :total, presence: true
end
#comment
