class BookingsController < ApplicationController
  def create
    @booking = Booking.new(bookings_param)
    @booking.user = current_user
    @booking.status = 0
    @booking.end_date = calc_end_date
    @booking.listing_id = params[:listing_id]
    @booking.save
    redirect_to listings_path, status: :see_other
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

  def calc_end_date()
    return @booking.start_date + (params[:weeks].to_i * 7)
  end

  def bookings_param
    params.require(:booking).permit(:listing_id, :start_date, :status, :total, :weeks)
  end
end
