require "date"

class ListingsController < ApplicationController
  def index
    @listings = Listing.all
    p params if params.present?
    if params[:genre].present?
      @listings = Listing.joins(:book).where("genre ILIKE ?", params[:genre] )
    elsif params[:price].present? && params[:query].present?
      @listings = Listing.where("price < ?", params[:price] ).global_search(params[:query])
    elsif params[:price].present?
      @listings = Listing.where("price < ?", params[:price] )
    elsif params[:query].present?
      @listings = Listing.global_search(params[:query])
    end
    @genres = get_genres(@listings)
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
    @books = Book.all
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    @books = Book.all
    if @listing.save
    redirect_to listings_path, notice: "Listing created!"
    else
      render :new
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :price, :condition, :comment, :book_id, :image)
  end
end

def get_genres(listings)
  genre_array = []
  listings.each do |listing|
    genre_array << listing.book.genre
  end
  genre_array.uniq!
end
