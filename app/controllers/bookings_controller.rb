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

  def accept
    @booking = Booking.find(params[:id])
    @booking.update(status: 1)
    redirect_to user_dashboard_path
  end

  def deny
    @booking = Booking.find(params[:id])
    @booking.update(status: 2)
    redirect_to user_dashboard_path
  end


  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_price)
  end
end
