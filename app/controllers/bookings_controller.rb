class BookingsController < ApplicationController
  def create
    @listing = Listing.find(params[:listing_id])
    @booking = @listing.bookings.build(booking_params)
    if @booking.save
      redirect_to @listing, notice: 'Booking was successfully created.'
    else
      render 'listings/show'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_price)
  end
end
