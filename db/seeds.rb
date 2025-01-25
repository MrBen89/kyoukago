# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'httparty'
require 'open-uri'


puts "Clearing database..."
ReservationReview.destroy_all
Booking.destroy_all
Listing.destroy_all
User.destroy_all
Book.destroy_all


puts "Creating users..."
users = [
  { email: "buyer1@example.com", password: "password", name: "Mia Lauper", address: "2836234 Rainbow Road"  },
  { email: "buyer2@example.com", password: "password", name: "Liam Jackson", address: "Somewhere up north"  },
  { email: "seller1@example.com", password: "password", name: "The Artist Formerly Known As Julian", address: "1 Tokyo Road"  },
  { email: "seller2@example.com", password: "password", name: "Ben Rotten", address: "6 Hell" }
]
users.each { |user| User.create!(user) }

puts "Fetching books from Open Library API..."
response = HTTParty.get("https://openlibrary.org/search.json?q=fiction&limit=25")
books_data = response.parsed_response["docs"]


puts "Creating books..."
sellers = User.all
books_data.each do |book_data|
  book = Book.create!(
    title: book_data["title"],
    author: book_data["author_name"]&.join(", ") || "Unknown Author"
  )

  cover_id = book_data["cover_i"]
  if cover_id
    image_url = "https://covers.openlibrary.org/b/id/#{cover_id}-L.jpg"
    downloaded_image = URI.open(image_url)
    book.image.attach(
      io: downloaded_image,
      filename: "#{book.title.parameterize}.jpg",
      content_type: "image/jpeg"
    )
  end
end


puts "Creating listings..."
buyers = User.all
books = Book.all
books.sample(20).each do |book|
  listing = Listing.new(
    book: book,
    user: buyers.sample,
    title: "#{book.title} #{['used', 'great condition', 'signed by author', 'bit skanky'].sample}",
    price: rand(50..350),
    condition: "Used",
    comment: "Delicious book, slightly used. Comes complete with original dust jacket and coffee stains."
  )

  cover_id = books_data.find { |b| b["title"] == book.title }&.dig("cover_i")
  if cover_id
    image_url = "https://covers.openlibrary.org/b/id/#{cover_id}-L.jpg"
    downloaded_image = URI.open(image_url)
    listing.image.attach(
      io: downloaded_image,
      filename: "#{book.title.parameterize}.jpg",
      content_type: "image/jpeg"
    )
  end
  listing.save
end

puts "Creating bookings..."
buyers = User.all
listings = Listing.all
listings.sample(5).each do |listing|
  Booking.create!(
    listing: listing,
    user: buyers.sample,
    start_date: "2025-01-26",
    end_date: "2025-01-28",
    status: 0,
    total: 350
  )
end

puts "Creating reviews..."
bookings = Booking.all
listings.each do |listing|
  rand(1..3).times do
    ReservationReview.create!(
      booking: bookings.sample,
      user: buyers.sample,
      score: rand(3..5),
      comment: "This book is cool! nice."
    )
  end
end

puts "Seeding complete!"
