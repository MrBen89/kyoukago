class BookingsController < ApplicationController
  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.save
    redirect_to listings_path, status: :see_other
  end

  private

  def bookings_param
    params.require(:booking).permit(:listing_id, :start_date, :end_date, :status, :total)
  end
end
t.bigint "user_id", null: false
@listing = Listing.new(listing_params)
    @listing.user = current_user
    @listing.save
    redirect_to listings_path, status: :see_other
