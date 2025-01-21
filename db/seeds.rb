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
User.destroy_all
Book.destroy_all
Booking.destroy_all
Review.destroy_all

puts "Creating users..."
users = [
  { email: "buyer1@example.com", password: "password", role: "buyer" },
  { email: "buyer2@example.com", password: "password", role: "buyer" },
  { email: "seller1@example.com", password: "password", role: "seller" },
  { email: "seller2@example.com", password: "password", role: "seller" }
]
users.each { |user| User.create!(user) }

puts "Fetching books from Open Library API..."
response = HTTParty.get("https://openlibrary.org/search.json?q=fiction&limit=10")
books_data = response.parsed_response["docs"]


puts "Creating books..."
sellers = User.where(role: "seller")
books_data.each do |book_data|
  Book.create!(
    title: book_data["title"],
    author: book_data["author_name"]&.join(", ") || "Unknown Author",
    description: book_data["first_sentence"] || "No description available.",
    price: rand(10..50),
    rental_available: [true, false].sample,
    image_url: "https://covers.openlibrary.org/b/id/#{book_data['cover_i']}-L.jpg",
    user: sellers.sample
  )
end

puts "Creating bookings..."
buyers = User.where(role: "buyer")
books = Book.all
books.sample(5).each do |book|
  Booking.create!(
    book: book,
    user: buyers.sample,
    status: "pending"
  )
end

puts "Creating reviews..."
books.each do |book|
  rand(1..3).times do
    Review.create!(
      book: book,
      user: buyers.sample,
      rating: rand(3..5),
      content: "This book is cool! nice."
    )
  end
end

puts "Seeding complete!"
