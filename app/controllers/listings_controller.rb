require "date"

class ListingsController < ApplicationController
  def index
    if params[:genre].present?
      @listings = Listing.joins(:book).where(books: { genre: params[:genre] })
    else
      @listings = Listing.all
    end
  end

  def show
    @listing = Listing.find(params[:id])
    @booking = Booking.new
    @bookings = Booking.all
    @updated = (Date.today - @listing.updated_at.to_date).to_i
    @reviews = ReservationReview.joins(:booking).where(bookings: { listing_id: @listing.id }).limit(3)
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
    redirect_to listings_path, notice: "Listing created!"
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :price, :condition, :comment, :book_id, :image)
  end
end
