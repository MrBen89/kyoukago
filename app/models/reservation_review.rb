class ReservationReview < ApplicationRecord
  belongs_to :bookings
  belongs_to :user
end
