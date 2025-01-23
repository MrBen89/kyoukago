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

puts "Clearing database..."
ReservationReview.destroy_all
Booking.destroy_all
Listing.destroy_all
User.destroy_all
Book.destroy_all


puts "Creating users..."
users = [
  { email: "buyer1@example.com", password: "password" },
  { email: "buyer2@example.com", password: "password" },
  { email: "seller1@example.com", password: "password" },
  { email: "seller2@example.com", password: "password" }
]
users.each { |user| User.create!(user) }

puts "Fetching books from Open Library API..."
response = HTTParty.get("https://openlibrary.org/search.json?q=fiction&limit=10")
books_data = response.parsed_response["docs"]


puts "Creating books..."
sellers = User.all
books_data.each do |book_data|
  Book.create!(
    title: book_data["title"],
    author: book_data["author_name"]&.join(", ") || "Unknown Author",
  )
end


puts "Creating listings..."
buyers = User.all
books = Book.all
books.sample(5).each do |book|
  Listing.create!(
    book: book,
    user: buyers.sample,
    title: ["To kill a zebra", "To kill a hamster", "To kill a Mia", "To kill a mockingbird", "To kill nobody at all, preferably"].sample,
    price: 350,
    condition: "Used",
    comment: "delicious"
  )
end

puts "Creating bookings..."
buyers = User.all
listings = Listing.all
listings.sample(5).each do |listing|
  Booking.create!(
    listing: listing,
    user: buyers.sample,
    status: "pending",
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
