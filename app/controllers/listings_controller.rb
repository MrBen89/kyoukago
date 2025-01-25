require "date"

class ListingsController < ApplicationController
  def index
    @listings = Listing.all
  end

  def show
    @listing = Listing.find(params[:id])
    @booking = Booking.new
    @bookings = Booking.all
    @updated = (Date.today - @listing.updated_at.to_date).to_i
    @reviews = Review.where(listing: @listing).limit(3)
    @suggested_books = Book.where.not(id: @listing.book_id).limit(4)

  end

  def update
    @listing = Listing.find(params[:id])
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    @listing.save
    redirect_to listings_path, status: :see_other
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :price, :condition, :comment, :book_id, :image)
  end

end
