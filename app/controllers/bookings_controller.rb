class BookingsController < ApplicationController
  def create
    @booking = Booking.new(bookings_param)
    @booking.user = current_user
    @booking.status = 0
    @booking.save
    redirect_to listings_path, status: :see_other
  end

  private

  def bookings_param
    params.require(:booking).permit(:listing_id, :start_date, :end_date, :status, :total)
  end
end
